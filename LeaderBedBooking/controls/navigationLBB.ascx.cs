using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LeaderBedBooking_controls_navigationLBB : System.Web.UI.UserControl
{
    public string PayStubAvailable = "";
    public string PaySheetCan = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        //PayStubAvailable = (Session["ATLAS_PayStub_Available"].ToString() == "Y") ? "menu[5][3] = new Item('Pay Stubs', 'PayStubs.aspx', defHeight, 0);menu[5][4] = new Item('ATLAS Pay Sheets', 'PaySheet.aspx', defHeight, 0);" : "";
        //PaySheetCan = (Session["ATLAS_PaySheet_Can"].ToString() == "Y") ? "menu[5][3] = new Item('ATLAS Pay Sheets', 'PaySheetCan.aspx', defHeight, 0);":"";
    }
}