using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LeaderBedBooking_controls_headerLBB : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetAllowResponseInBrowserHistory(true);

        object cacheUser = Cache["username"];
        object cachePartyID = Cache["partyid"];
        string currentUser = "";
        TimeSpan cacheLife = new TimeSpan(6, 0, 0);
        if (Session["ATLAS_iPartyID"]!= null)
        {
            if (Session["ATLAS_UserName"] != null)
            {
                Cache.Insert("username", Session["ATLAS_UserName"].ToString(), null, DateTime.MaxValue, cacheLife);
                Cache.Insert("partyid", HttpContext.Current.User.Identity.Name, null, DateTime.MaxValue, cacheLife);
                currentUser = Session["ATLAS_UserName"].ToString();
            }
        }
        else
        {
            if (Session["ATLAS_UserName"] != null)
            {
                currentUser = Session["ATLAS_UserName"].ToString();
            }
        }
        lblUser.Text = currentUser;
    }
}