using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class LBBMasterPage : System.Web.UI.MasterPage
{
    String currentUser = String.Empty;
    bool isLeader = false;
    public bool isTS = false;
    public bool isRE = false;
    public bool isRSS = false;
    int leaderPartyID = 0;
    int userPartyID = 0;

    bool isDev = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        string svr = Request.UserHostAddress;
        Response.Cache.SetAllowResponseInBrowserHistory(true);
        Response.ExpiresAbsolute = DateTime.Today.AddDays(1);

        userPartyID = Convert.ToInt32(Cache["partyid"]);
        SetLeaderAuth(userPartyID);
        if (!isLeader)
        {
            //lblWarning.Visible = true;
            //lblWarning.Text = "Since you are not identified as a leader, you have no bookings or schedule to display.";
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
                if (dr["is_RE"].ToString() == "Y")
                {
                    isRE = true;
                }
                if (dr["is_TS"].ToString() == "Y")
                {
                    isTS = true;
                }
                if (dr["is_RSS"].ToString() == "Y")
                {
                    isRSS = true;
                }
            }

        }
    }

}
