using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class LeaderBedBooking_RSSMaintenance : System.Web.UI.Page
{
    string cacheKey = "LBB_RSSData";

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetAllowResponseInBrowserHistory(true);

        if (!Page.IsPostBack)
        {
            GetGridData();
        }
    }
    protected void GetGridData()
    {
        DataSet1TableAdapters.BedBooking_LeaderHouseBeds_vTableAdapter lhb = new DataSet1TableAdapters.BedBooking_LeaderHouseBeds_vTableAdapter();
        var houseData = (from l in lhb.GetData()
                         group l by l.cLeaderHouseName into newHouseData
                         select new { LeaderHouse = newHouseData.Key, newHouseData }).ToList();

        var leaderList = Cache[cacheKey];
        if (leaderList == null)
        {
            var LeaderHouseBeds = (from l in lhb.GetData()
                                   group l by l.cLeaderHouseName into g
                                   select new { House = g.Key, Info = g }).ToList();
            Cache.Insert(cacheKey, LeaderHouseBeds);
            leaderList = Cache[cacheKey];
        }
        gvLeaderHouses.DataSource = leaderList;
        gvLeaderHouses.DataBind();
    }

    protected void gvLeaderHouses_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView gvLeaderHouses = (GridView)sender;
        gvLeaderHouses.EditIndex = e.NewEditIndex;
        GetGridData();
    }
    
    protected void gvLeaderHouses_RowCanceling(object sender, GridViewCancelEditEventArgs e)
    {
        gvLeaderHouses.EditIndex = -1;
        GetGridData();
    }

    protected void gvHouseBeds_RowDataBound(object sender, GridViewRowEventArgs e)
    {        

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataSet1.BedBooking_LeaderHouseBeds_vRow drv = (DataSet1.BedBooking_LeaderHouseBeds_vRow)e.Row.DataItem;
            System.Globalization.DateTimeFormatInfo mfi = new System.Globalization.DateTimeFormatInfo();
            
            Label lblToDate = (Label)e.Row.FindControl("lblToDate");
            Label lblFromDate = (Label)e.Row.FindControl("lblFromDate");
            int fromMonth = Convert.ToInt32(drv["iFromMonth"]);
            int toMonth = Convert.ToInt32(drv["iToMonth"]);
            int fromDay = Convert.ToInt32(drv["iFromDay"]);
            int toDay = Convert.ToInt32(drv["iToDay"]);
            lblFromDate.Text = "";
            lblToDate.Text = "";
 
            if (fromMonth > 0 && fromDay > 0)
            {
                lblFromDate.Text = mfi.GetAbbreviatedMonthName(Convert.ToInt32(drv["iFromMonth"])) + " " + drv["iFromDay"].ToString();
            }
            if (toMonth > 0 && toDay > 0)
            {
                lblToDate.Text = " to " + mfi.GetAbbreviatedMonthName(Convert.ToInt32(drv["iToMonth"])) + " " + drv["iToDay"].ToString();
            }
        }
    }

}