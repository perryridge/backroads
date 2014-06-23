using System;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

public partial class LeaderBedBooking_LeaderHouse : System.Web.UI.Page
{
    DateTime bookDate;
    int iMonth = 6;
    int iHouseId = 0;

    object listConfirmed;
    object listCancelled;
    object listTentative;
    object listOverflow;

    public string HouseName = "";
    public string MonthName = "";
    public int NumBeds;
    public string paramHouseId = "";
    
    System.Globalization.DateTimeFormatInfo mfi = new System.Globalization.DateTimeFormatInfo();


    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetAllowResponseInBrowserHistory(true);

        if (!IsPostBack)
        {
            MonthName = mfi.GetMonthName(iMonth);
            if (Request["leaderHouseId"] != null)
            {
                iHouseId = Convert.ToInt32(Request["leaderHouseId"].ToString());
                SetGridData(iMonth, iHouseId);
            }
            else
            {
                iHouseId = 0;
            }
            FillLeaderHouseDdl();
        }
    }

    protected object GetBookedNames(DateTime bookedDate, int leaderHouseID, string bookedStatus)
    {
        DataSet1TableAdapters.usp_ld_BedBooking_Get_NamesTableAdapter bookedNames = new DataSet1TableAdapters.usp_ld_BedBooking_Get_NamesTableAdapter();
        var namesConfirmed = bookedNames.GetData(leaderHouseID, bookedDate, bookedStatus);
        var namesCancelled = bookedNames.GetData(leaderHouseID, bookedDate, bookedStatus);
        var namesTentative = bookedNames.GetData(leaderHouseID, bookedDate, bookedStatus);
        var namesOverflow = bookedNames.GetData(leaderHouseID, bookedDate, bookedStatus);

        object names = new object();
        return names;
    }

    protected void SetGridData(int ipMonth, int ipHouseID)
    {
        //TABLE OF BOOKINGS
        DataSet1TableAdapters.usp_ld_BedBooking_Get_LeaderHouseDatesTableAdapter houseBookings = new DataSet1TableAdapters.usp_ld_BedBooking_Get_LeaderHouseDatesTableAdapter();

        //GETS THE LEADER HOUSE NAME
        DataSet1TableAdapters.LeaderHouseTableAdapter lh = new DataSet1TableAdapters.LeaderHouseTableAdapter();
        DataTable dt = lh.GetDataByHouseID(ipHouseID);
        HouseName = dt.Rows[0]["cLeaderHouseName"].ToString();

        //GET THE HOUSE INFORMATION
        DataSet1TableAdapters.usp_ld_bedBooking_GetLeaderHousesTableAdapter lhbv = new DataSet1TableAdapters.usp_ld_bedBooking_GetLeaderHousesTableAdapter();

        DataTable tblHouseInfo = lhbv.GetData(ipHouseID,0);

        grvLeaderHouseBookings.DataSource = houseBookings.GetData(ipHouseID);
        grvLeaderHouseBookings.DataBind();

        dtlLeaderHouseInformation.DataSource = tblHouseInfo;
        dtlLeaderHouseInformation.DataBind();

        DataSet ds = new DataSet();
        string connString = ConfigurationManager.AppSettings["ibis11copy"];
        SqlConnection conn = new SqlConnection(connString);
        SqlCommand sqlComm = new SqlCommand("usp_ld_bedBooking_GetLeaderHouses");
        sqlComm.CommandType = CommandType.StoredProcedure;

        GridView2.DataSource = tblHouseInfo;
        GridView2.DataBind();
    }

    protected void grvLeaderHouseBookings_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //TABLE OF ALL NAMES BOOKED
        DataSet1TableAdapters.usp_ld_BedBooking_Get_NamesTableAdapter bookingNames = new DataSet1TableAdapters.usp_ld_BedBooking_Get_NamesTableAdapter();

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView drv = (DataRowView)e.Row.DataItem;
            DateTime dDate = (DateTime)drv["dDate"];
            //CONFIRMED LIST
            Repeater rptrConf = (Repeater)e.Row.FindControl("rptrConf");
            if (rptrConf != null)
            {
                rptrConf.DataSource = bookingNames.GetData(iHouseId, dDate, "Confirmed");
                rptrConf.DataBind();
            }
            //OVERFLOW
            Repeater rptrOvrf = (Repeater)e.Row.FindControl("rptrOvrf");
            if (rptrOvrf != null)
            {
                rptrOvrf.DataSource = bookingNames.GetData(iHouseId, dDate, "Overflow");
                rptrOvrf.DataBind();
            }
            //TENTATIVE
            Repeater rptrTent = (Repeater)e.Row.FindControl("rptrTent");
            if (rptrTent != null)
            {
                rptrTent.DataSource = bookingNames.GetData(iHouseId, dDate, "Tentative");
                rptrTent.DataBind();
            }
            //CANCELLED
            Repeater rptrCanx = (Repeater)e.Row.FindControl("rptrCanx");
            if (rptrCanx != null)
            {
                rptrCanx.DataSource = bookingNames.GetData(iHouseId, dDate, "Cancelled");
                rptrCanx.DataBind();
            }

            Label lblEditLink = (Label)e.Row.FindControl("lblEditBtn");
            if(lblEditLink != null)
            {
                lblEditLink.Text = "<a href=\"UpdateBookingStatus.aspx?leaderHouseId=" + iHouseId + "&bookDate=" + drv["dDate"].ToString() + "\">Edit</a>";
            }
        }

    }

    
    protected void FillLeaderHouseDdl()
    {
        DataSet1TableAdapters.LeaderHouseTableAdapter housesTable = new DataSet1TableAdapters.LeaderHouseTableAdapter();
        var houses = (from h in housesTable.GetData()
                      where h.lActive = true
                      orderby h.cLeaderHouseName
                      select new { h.cLeaderHouseName, h.iLeaderHouseID }).Distinct();
        ddlLeaderHouses.DataTextField = "cLeaderHouseName";
        ddlLeaderHouses.DataValueField = "iLeaderHouseID";
        ddlLeaderHouses.DataSource = houses;
        ddlLeaderHouses.DataBind();
        ddlLeaderHouses.Items.Insert(0, "Please Select");
        if (iHouseId != 0)
        {
            ddlLeaderHouses.SelectedValue = iHouseId.ToString();
        }
        
    }

    protected void ddlLeaderHouses_OnSelectedIndexChange(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;
        int selId = Convert.ToInt32(ddl.SelectedValue);
        iHouseId = selId;
        paramHouseId = ddl.SelectedValue;
        SetGridData(6, selId);

    }
    protected void grvLeaderHouseBookings_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }
}