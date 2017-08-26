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
        public Form_login()
        {
            InitializeComponent();
        }

        private void btn_login_Click(object sender, EventArgs e)
        {
            if (CheckUserAvailabel())
            {
                Form_display frmdisplay = new Form_display();
                this.WindowState = FormWindowState.Minimized;
                frmdisplay.ShowDialog();
                this.Close();
            }
            else {
                MessageBox.Show("Invalid Authentication!");
            }


        }


        private bool CheckUserAvailabel()
        {
            SessionData.SetMd5PasswordToConvert(textBox2.Text);
            string md5pass = SessionData.md5Password;
            DataTable users;
            int count;
            con = new db();
            string query = "SELECT id,username,user_type FROM users WHERE username='" + textBox1.Text + "' AND password = '" + md5pass + "' AND users.user_type IN('C','A')";
            con.MysqlQuery(query);
            users = con.QueryEx();
            count = users.Rows.Count;

            if (count > 0)
            {
                SessionData.SetUserAuth(true);
                SessionData.SetUserId(users.Rows[0][0].ToString());
                SessionData.setauthType(users.Rows[0][2].ToString());
                SessionData.setUser(users.Rows[0][1].ToString());
                return true;
            }
            else
            {
                return false;
            }
        }


      
    }
}
