using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using System.Drawing.Printing;
using System.Drawing;
using System.Data;

namespace posv2
{
    public class Zreport
    {
        PrintDocument pdoc = null;
        int guestcount;
        double totalsale,totalcardsale,totalcashsale;
        DataTable cardwisesale, cardsale, cashsale, voiditems, categorysale;

        public double TotalSale
        {
            //set the TotalSale
            set { this.totalsale = value; }
            //get the TotalSale
            get { return this.totalsale; }
        }

        public double SetTotalCardSale
        {
            //set the totalcardsale
            set { this.totalcardsale = value; }
            //get the totalcardsale
            get { return this.totalcardsale; }
        }

        public double SetTotalCashSale
        {
            //set the totalcashsale
            set { this.totalcashsale = value; }
            //get the totalcashsale
            get { return this.totalcashsale; }
        }

        

        public DataTable CardWiseSale
        {
            //set the Card wise sale
            set { this.cardwisesale = value; }
            //get the Card wise sale
            get { return this.cardwisesale; }
        }


        //shift based
        public DataTable TalalCardSale
        {
            //set the TalalCardSale
            set { this.cardsale = value; }
            //get the TalalCardSale
            get { return this.cardsale; }
        }

        //shift based
        public DataTable TalalCashSale
        {
            //set the TalalCardSale
            set { this.cashsale = value; }
            //get the TalalCardSale
            get { return this.cashsale; }
        }

        public DataTable VoidItems
        {
            //set the voiditems
            set { this.voiditems = value; }
            //get the voiditems
            get { return this.voiditems; }
        }

        public DataTable CategorySale
        {
            //set the categorysale
            set { this.categorysale = value; }
            //get the categorysale
            get { return this.categorysale; }
        }


        public int GuestCount
        {
            //set the guestcount
            set { this.guestcount = value; }
            //get the guestcount
            get { return this.guestcount; }
        }

        
        public void print(string printer)
        {
            PrintDocument pdoc = new PrintDocument();
            pdoc.PrinterSettings.PrinterName = printer;

            if (pdoc.PrinterSettings.IsValid)
            {
                pdoc.PrintPage += new PrintPageEventHandler(pdoc_PrintPage);
                pdoc.Print();
            }
            else
            {
                MessageBox.Show("Printer is invalid.");
            }
        }





        void pdoc_PrintPage(object sender, PrintPageEventArgs e)
        {
            // MessageBox.Show(orderid.ToString());
            Graphics graphics = e.Graphics;
            Font font = new Font("Courier New", 10);
            string customfont = "Courier New";
            float fontHeight = font.GetHeight();
            int startX = 0;
            int startY = 0;
            int Offset = -5;
            //heder start

            //logo
            Image photo = Image.FromFile(@"c:/xampp/htdocs/mpos/images/mpos.png");
            //print logo if neccessary
            //graphics.DrawImage(photo, 10, -60);


            Offset = Offset + 5;
            graphics.DrawString("Heritage Cafe & Bistro", new Font("Courier New", 14),
                                new SolidBrush(Color.Red), 50, startY + Offset);
            Offset = Offset + 20;
            graphics.DrawString("Z-Report", new Font("Courier New", 12),
                                new SolidBrush(Color.Red), 70, startY + Offset);
            Offset = Offset + 20;
            //Report date
            graphics.DrawString("Report Date :",
                     new Font(customfont, 10),
                     new SolidBrush(Color.Black), startX, startY + Offset);
            Offset = Offset + 15;
            //Till Open Time
            graphics.DrawString("Till Open Time :" + SessionData.tillOpenTime,
                     new Font(customfont, 10),
                     new SolidBrush(Color.Black), startX, startY + Offset);
            //Till Open Balance
            Offset = Offset + 15;
            graphics.DrawString("Till Open Balance :" + SessionData.tillOpenTime,
                     new Font(customfont, 10),
                     new SolidBrush(Color.Black), startX, startY + Offset);
            //Till close time
            Offset = Offset + 15;
            graphics.DrawString("Till Closed Time :" + DateTime.Now.ToString("yyyyMMddHHmmss"),
                     new Font(customfont, 10),
                     new SolidBrush(Color.Black), startX, startY + Offset);
            //Till closing balance
            Offset = Offset + 15;
            graphics.DrawString("Till Closing Balance :",
                     new Font(customfont, 10),
                     new SolidBrush(Color.Black), startX, startY + Offset);
            //Cashier
            Offset = Offset + 15;
            graphics.DrawString("Cashier :" + SessionData.user,
                     new Font(customfont, 10),
                     new SolidBrush(Color.Black), startX, startY + Offset);

            //Title Sales Summery
            Offset = Offset + 15;
            graphics.DrawString("Sales Summery", new Font("Courier New", 12),
                                new SolidBrush(Color.Red), 70, startY + Offset);
            String underLine = "----------------------------------";
            graphics.DrawString(underLine, new Font(customfont, 10),
                     new SolidBrush(Color.Black), startX, startY + Offset);

            foreach (DataRow cardwisesalerow in cardwisesale.Rows)
            {
               
            }

            graphics.DrawString(underLine, new Font(customfont, 10),
                     new SolidBrush(Color.Black), startX, startY + Offset);
            //End cardwise sale

            //Total Sale
            Offset = Offset + 15;
            graphics.DrawString("Total Sale :" + totalsale,
                     new Font(customfont, 10),
                     new SolidBrush(Color.Black), startX, startY + Offset);

            //Total card sale
            Offset = Offset + 15;
            graphics.DrawString("Total Card Sale :" + totalcardsale,
                     new Font(customfont, 10),
                     new SolidBrush(Color.Black), startX, startY + Offset);

            //shifts
            foreach (DataRow cardsaleRows in cardsale.Rows)
            {

            }


            //Total Cash sale
            Offset = Offset + 15;
            graphics.DrawString("Total Cash Sale :" + totalcashsale,
                     new Font(customfont, 10),
                     new SolidBrush(Color.Black), startX, startY + Offset);

            //shifts
            foreach (DataRow cashsaleRows in cashsale.Rows)
            {

            }

            Offset = Offset + 15;
            graphics.DrawString(underLine, new Font(customfont, 10),
                     new SolidBrush(Color.Black), startX, startY + Offset);


            //Void Items
            foreach (DataRow voidItemsRows in voiditems.Rows)
            {

            }
            //underline
            graphics.DrawString(underLine, new Font(customfont, 10),
                     new SolidBrush(Color.Black), startX, startY + Offset);




            Offset = Offset + 10;
            graphics.DrawString("Powered by Mcreatives", new Font(customfont, 8),
                     new SolidBrush(Color.Black), 50, startY + Offset);
            Offset = Offset + 10;
            graphics.DrawString("+94 117 - 208 375", new Font(customfont, 8),
                     new SolidBrush(Color.Black), 55, startY + Offset);
            Offset = Offset + 10;


        }


    }
}
