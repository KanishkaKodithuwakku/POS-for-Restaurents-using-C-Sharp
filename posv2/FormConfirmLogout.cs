using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace posv2
{
    public partial class FormConfirmLogout : Form
    {
        private db con;
        public FormConfirmLogout()
        {
            InitializeComponent();
        }

        private void btn_doSleep_Click(object sender, EventArgs e)
        {
            Form_display.logoutStatus = false;
            this.Close();
        }

        private void btn_doShoutDown_Click(object sender, EventArgs e)
        {

            DialogResult dr = MessageBox.Show("Are you sure want to shoutdown.", "Title", MessageBoxButtons.YesNoCancel,
            MessageBoxIcon.Information);

            if (dr == DialogResult.Yes)
            {
                Form_display.logoutStatus = true;
                this.Close();
            }
            
        }

        private void switch_user_Click(object sender, EventArgs e)
        {
            //process logout'
            DataTable shift;
            con = new db();
            string shiftQuery = "SELECT shift.id,shift.users_id,users.username FROM `shift` JOIN users ON users.id = shift.users_id WHERE shift.shift_end IS NULL ORDER BY shift.id DESC LIMIT 1";
            con.MysqlQuery(shiftQuery);
            shift = con.QueryEx();
            con.conClose();

            if (shift.Rows.Count > 0) {
                closeShift(int.Parse(shift.Rows[0][0].ToString()));
            }

        }

        void closeShift(int shiftid) {
            con = new db();
            string q = "UPDATE shift SET shift_end = '" + DateTime.Now.ToString("yyyyMMddHHmmss") + "' WHERE shift.id = '" + shiftid + "'";
            con.MysqlQuery(q);
            con.NonQueryEx();
            con.conClose();
            Form_display.logoutStatus = true;
            panel1.Visible = true;
            Thread.Sleep(5000);
            // set login form to switch user
            Form_login.switcheUser = true;
            this.Close();
        }

        private void FormConfirmLogout_Load(object sender, EventArgs e)
        {
            panel1.Visible = false;
        }

    }
}
