using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace posv2
{
    public partial class Form_login : Form
    {
        private db con;
        private string errormsg = "";
        double totalSale,totalDiscount,totalServiceCharge;
        DataTable allcardsale,voidItems,categorySale;
        int guestCount;
        public Form_login()
        {
            InitializeComponent();
        }

        //zreport data

        //today total sale
        void getTotalSale(){
            DataTable result;
            con = new db();
            string query = "SELECT (IF(SUM(order_details.subtotal)>0,FORMAT(SUM(order_details.subtotal),2),FORMAT(0,2))) AS totalsale FROM `order_details` WHERE date(order_details.added) = date(CURDATE())";
            con.MysqlQuery(query);
            result = con.QueryEx();
            con.conClose();
            totalSale = double.Parse(result.Rows[0][0].ToString()); 
        }

        //card wise sale
        void getCardwiseSale() {
            DataTable result;
            con = new db();
            string query = "SELECT COUNT(order_details.id) AS itemcount,(SUM(order_details.subtotal)) AS cardsale, (IF(paymentdetails.cardtype='','CASH',paymentdetails.cardtype)) AS cardtype FROM order_details JOIN orders ON orders.id=order_details.order_id JOIN paymentdetails ON paymentdetails.orders_id = order_details.order_id WHERE date(order_details.added) = CURDATE() GROUP BY paymentdetails.cardtype";
            con.MysqlQuery(query);
            result = con.QueryEx();
            con.conClose();
            allcardsale = result;
        }

        //get void items
        void getVoidItems() {
            DataTable result;
            con = new db();
            string query = "SELECT products.name,order_details.qty,order_details.subtotal FROM `order_details` JOIN products ON products.id = order_details.product_id WHERE date(order_details.added) = date(CURDATE()) AND order_details.online = 0 ";
            con.MysqlQuery(query);
            result = con.QueryEx();
            con.conClose();
            voidItems = result;
        }

        //get category sale
        void getCategorySale() {
            DataTable result;
            con = new db();
            string query = "SELECT SUM(order_details.subtotal) AS sale,categories.name, COUNT(order_details.product_id) AS itemcount FROM order_details JOIN products ON products.id = order_details.product_id JOIN categories ON categories.id = products.category_id WHERE date(order_details.added) = CURDATE() GROUP BY categories.id";
            con.MysqlQuery(query);
            result = con.QueryEx();
            con.conClose();
            categorySale = result;
        }

        //get guest count
        void getGuestCount()
        {
            DataTable result;
            con = new db();
            string query = "SELECT SUM(orders.guest) AS guestcount FROM order_details JOIN orders ON orders.id = order_details.order_id WHERE date(order_details.added) = date(CURDATE())";
            con.MysqlQuery(query);
            result = con.QueryEx();
            con.conClose();
            guestCount = int.Parse(result.Rows[0][0].ToString());
        }

        //get total discount and servicecharge






        public static bool switcheUser = false;
        private void btn_login_Click(object sender, EventArgs e)
        {
            if (CheckUserAvailabel()==1)
            {
                Form_display frmdisplay = new Form_display();
                this.WindowState = FormWindowState.Minimized;
                this.Hide();
                frmdisplay.ShowDialog();
                if (switcheUser)
                {
                    //MessageBox.Show(switcheUser.ToString());
                    SessionData.SetUserAuth(false);
                    SessionData.SetUserId("");
                    SessionData.setauthType("");
                    SessionData.setUser("");
                    this.Show();
                    this.WindowState = FormWindowState.Normal;
                }else {
                    //genarate z report
                    Zreport zreport = new Zreport();
                    zreport.print("POS-80Series");
                    this.Close();  
                }
               
            }
            else if (CheckUserAvailabel() == 0)
            {
                MessageBox.Show("Invalid Authentication!");
            }
            else {
                MessageBox.Show(errormsg);
            }
        }







        private int CheckUserAvailabel()
        {
            con = new db();
            int status = 0;
            SessionData.SetMd5PasswordToConvert(textBox2.Text);
            string md5pass = SessionData.md5Password;
            DataTable users;
            DataTable shift;
            int count;
            string query = "SELECT id,username,user_type FROM users WHERE username='" + textBox1.Text + "' AND password = '" + md5pass + "' AND users.user_type IN('C','A')";
            con.MysqlQuery(query);
            users = con.QueryEx();
            count = users.Rows.Count;

            if (count > 0)
            {
                //SELECT shift.id FROM `shift` WHERE shift.users_id = 2 AND shift.shift_end > "" ORDER BY shift.id DESC
                SessionData.SetUserAuth(true);
                SessionData.SetUserId(users.Rows[0][0].ToString());
                SessionData.setauthType(users.Rows[0][2].ToString());
                SessionData.setUser(users.Rows[0][1].ToString());
                SessionData.SetTillOpenBalance(5000);
                SessionData.SetTillOpenTime(DateTime.Now.ToString("yyyyMMddHHmmss"));
                string shiftQuery = "SELECT shift.id,shift.users_id,users.username,shift.shift_no FROM `shift` JOIN users ON users.id = shift.users_id WHERE shift.shift_end IS NULL ORDER BY shift.id DESC LIMIT 1";
                con.MysqlQuery(shiftQuery);
                shift = con.QueryEx();
                con.conClose();

                //set shift
                if (shift.Rows.Count > 0) {
                    SessionData.SetUserShiftId(int.Parse(shift.Rows[0][0].ToString()));
                    SessionData.SetUserShiftNo(int.Parse(shift.Rows[0][3].ToString()));
                }


                if (shift.Rows.Count > 0 && shift.Rows[0][1].ToString() != SessionData.userid)
                {
                    errormsg = "Previous Shift (" + shift.Rows[0][2].ToString() + ") was not closed. could not start a new shift for (" + SessionData.user + "). please signout last shift.";
                    status = 2;
                }
                else {
                    status =  1;
                }
                return status;
            }
            else
            {
                return status;
                
            }
            
           
        }
 
    }
}
