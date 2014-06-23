using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page
{
    String currentUser = String.Empty;
    bool isLeader = false;
    string isTS = "";
    string isRE = "";
    string isRSS = "";
    int leaderPartyID = 0;
    int selected_LeaderHouseID = 0;
    int userPartyID;
    string cacheKey = "LeaderBedBookingDataSet";
    bool canConfirm = true;
    string selectedLeaderName = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetAllowResponseInBrowserHistory(true);
        Response.ExpiresAbsolute = DateTime.Today.AddDays(1);

        userPartyID = Convert.ToInt32(Session["ATLAS_iPartyID"]);

        if (!Page.IsPostBack)
        {
            SetLeaderAuth(userPartyID);
            LoadLeaderHouseDDL();
            LoadLeadersDDL();
            ddlLeaders.Visible = true;
            leaderPartyID = Convert.ToInt32(ddlLeaders.SelectedValue);
            selectedLeaderName = ddlLeaders.SelectedItem.Text;
            if (!isLeader)
            {
                //lblWarning.Text = "Since you are not identified as a leader, you have no bookings or schedule to display.";
                //pAlertMsg.Visible = true;
            }
        }
        else
        {
            selectedLeaderName = ddlLeaders.SelectedItem.Text;
            leaderPartyID = Convert.ToInt32(ddlLeaders.SelectedValue);
        }
    }

    protected void grdLeaderView_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdLeaderView.PageIndex = e.NewPageIndex;
        grdLeaderView.DataBind();
    }

    protected void grdLeaderView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        grdLeaderView.EditIndex = e.NewEditIndex;
        BindGrid();
    }

    protected void grdLeaderView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow row = (GridViewRow)grdLeaderView.Rows[e.RowIndex];
        int id = Int32.Parse(grdLeaderView.DataKeys[e.RowIndex].Value.ToString());
    }

    protected void grdLeaderView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
        }

    }

    protected void grdLeaderView_RowCanceling(object sender, GridViewCancelEditEventArgs e)
    {
        grdLeaderView.EditIndex = -1;
        BindGrid();
    }

    protected void BindGrid()
    {
        grdLeaderView.DataSource = GetGridData();
        grdLeaderView.DataBind();
    }

    protected object GetGridData()
    {
        object cacheItem = Cache[cacheKey];
        if (cacheItem == null)
        {
            DataSet1TableAdapters.LeaderHouse_BedBookingTableAdapter lhbbta = new DataSet1TableAdapters.LeaderHouse_BedBookingTableAdapter();
            Cache.Insert(cacheKey, lhbbta.GetData());
        }
        return Cache[cacheKey];
    }

    protected void LoadLeadersDDL()
    {
        DataSet1TableAdapters.Leaders_vTableAdapter lv = new DataSet1TableAdapters.Leaders_vTableAdapter();
        DataSet1.Leaders_vDataTable ldt = new DataSet1.Leaders_vDataTable();
        lv.Fill(ldt);
        var leaders = (from d in lv.GetData()
                       orderby d.name
                       select new { LeaderName = d.name, iLeaderPartyID = d.ipartyid }).Distinct();

        ddlLeaders.DataSource = leaders.AsEnumerable();
        ddlLeaders.DataBind();
        ListItem li = new ListItem();
        li.Text = "Please Select";
        li.Value = "0";
        ddlLeaders.Items.Insert(0, li);
        ddlLeaders.SelectedIndex = 0;
    }

    protected void LoadLeaderHouseDDL()
    {
        DataSet1TableAdapters.LeaderHouseTableAdapter lhta = new DataSet1TableAdapters.LeaderHouseTableAdapter();
        var houses = (from h in lhta.GetData()
                      orderby h.cLeaderHouseName
                      select new { HouseName = h.cLeaderHouseName, HouseID = h.iLeaderHouseID }).Distinct();
        ddlFrmHouse.DataTextField = "HouseName";
        ddlFrmHouse.DataValueField = "HouseID";
        ddlFrmHouse.DataSource = houses.AsEnumerable();
        ddlFrmHouse.DataBind();

        ListItem li = new ListItem();
        li.Text = "Please Select";
        li.Value = "0";
        ddlFrmHouse.Items.Insert(0, li);
        ddlFrmHouse.SelectedIndex = 0;
    }

    protected void ddlFrmHouse_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;
        selected_LeaderHouseID = Convert.ToInt32(ddl.SelectedValue);
    }

    protected void BindGridByLeaderId(int LeaderID)
    {
        btnAdd.Visible = true;
        DataSet1TableAdapters.BedBooking_byDate_vTableAdapter lhbbta = new DataSet1TableAdapters.BedBooking_byDate_vTableAdapter();
        grdLeaderView.DataSource = lhbbta.GetDataByLeaderID(LeaderID);
        grdLeaderView.DataBind();
    }

    protected void ddlLeaders_SelectedIndexChanged(object sender, EventArgs e)
    {
        updLeaderSchedule.Visible = true;
        uplAdd.Visible = false;
        DropDownList ddl = (DropDownList)sender;
        int selId = Convert.ToInt32(ddl.SelectedValue);
        lblLeaderName.Text = ddl.SelectedItem.Text;

        leaderPartyID = selId;
        BindGridByLeaderId(selId);
    }

    protected void btnRespond_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        DataSet1TableAdapters.LeaderHouse_BedBookingTableAdapter lhbb_ta = new DataSet1TableAdapters.LeaderHouse_BedBookingTableAdapter();
        int index = Convert.ToInt32(e.CommandArgument);
        GridViewRow row = grdLeaderView.Rows[index];
        string response = e.CommandName;
        string d = row.Cells[1].Text;
        DateTime bookDate = Convert.ToDateTime(d);
        HiddenField lh = (HiddenField)row.FindControl("hdnLeaderHouseId");
        int hdnLeaderHouse = Convert.ToInt16(lh.Value);
        lhbb_ta.UpdateLeaderResponse(response, leaderPartyID, bookDate, hdnLeaderHouse);
        ddlLeaders_SelectedIndexChanged(ddlLeaders, null);
    }


    protected void grdLeaderView_RowCreated(object sender, GridViewRowEventArgs e)
    {

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        uplAdd.Visible = false;
        updLeaderSchedule.Visible = true;
        ddlLeaders.Visible = true;
    }
    protected void btnSubmitNew_Click(object sender, EventArgs e)
    {

        selected_LeaderHouseID = Convert.ToInt32(ddlFrmHouse.SelectedValue);
        int leaderHouseID = selected_LeaderHouseID;
        int bWorkingInArea = Convert.ToInt32(rbWorkingInArea.SelectedValue);
        string inputFrom = tbFrmDate.Text;
        string inputTo = tbToDate.Text;
        if (inputFrom == "Please Select" || inputTo == "Please Select" || selected_LeaderHouseID == 0)
        {
            lblWarning.Text = "You must select both check-in and check-out dates.";
        }
        else
        {
            DateTime dCheckInDate = DateTime.Parse(tbFrmDate.Text);
            DateTime dCheckOutDate = DateTime.Parse(tbToDate.Text);
            DataSet1TableAdapters.usp_ld_BedBooking_AddTableAdapter lbbAdd = new DataSet1TableAdapters.usp_ld_BedBooking_AddTableAdapter();
            DataSet1.usp_ld_BedBooking_AddDataTable dt = new DataSet1.usp_ld_BedBooking_AddDataTable();
            lbbAdd.Fill(dt, leaderPartyID, leaderHouseID, dCheckInDate, dCheckOutDate, bWorkingInArea, userPartyID);
            uplAdd.Visible = false;
            updLeaderSchedule.Visible = true;
            ddlLeaders_SelectedIndexChanged(ddlLeaders, null);
        }
    }

    protected void SetLeaderAuth(int iLeaderPartyID)
    {
        DataSet1TableAdapters.Leaders_vTableAdapter ldrView = new DataSet1TableAdapters.Leaders_vTableAdapter();
        DataTable leaderRoles = ldrView.GetDataByLeaderId(iLeaderPartyID);
        if (leaderRoles.Rows.Count > 0)
        {
            isLeader = true;
            foreach (DataRow dr in leaderRoles.Rows)
            {
                isRE = dr["is_RE"].ToString();
                isTS = dr["is_TS"].ToString();
                isRSS = dr["is_RSS"].ToString();
            }
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        uplAdd.Visible = true;
        updLeaderSchedule.Visible = false;
        ddlLeaders.Visible = false;
        divPageTitle.InnerHtml = "<h1>" + selectedLeaderName + "</h1>";
        lblLeaderName.Visible = false;
        ddlFrmHouse.SelectedIndex = 0;
    }

    private Control FindControlRecursive(Control ctlRoot, string sControlId)
    {
        // if this control is the one we are looking for, break from the recursion
        // and return the control.
        if (ctlRoot.ID == sControlId)
        {
            return ctlRoot;
        }

        // loop the child controls of this parent control and call recursively.
        foreach (Control ctl in ctlRoot.Controls)
        {
            Control ctlFound = FindControlRecursive(ctl, sControlId);

            // if we found the control, return it.
            if (ctlFound != null)
            {
                return ctlFound;
            }
        }

        // we never found the control so just return null.
        return null;
    }
}