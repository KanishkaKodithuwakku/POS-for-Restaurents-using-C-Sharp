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
        public Form_login()
        {
            InitializeComponent();
        }

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
                string shiftQuery = "SELECT shift.id,shift.users_id,users.username FROM `shift` JOIN users ON users.id = shift.users_id WHERE shift.shift_end IS NULL ORDER BY shift.id DESC LIMIT 1";
                con.MysqlQuery(shiftQuery);
                shift = con.QueryEx();
                con.conClose();
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
