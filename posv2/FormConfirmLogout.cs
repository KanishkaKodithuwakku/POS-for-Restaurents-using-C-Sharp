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
    public partial class FormConfirmLogout : Form
    {
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

        }
    }
}
