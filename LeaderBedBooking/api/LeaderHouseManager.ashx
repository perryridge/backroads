<%@ WebHandler Language="C#" Class="LeaderHouseManager" %>

using System;
using System.Web;
using System.Data;
using System.Configuration;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Linq;
using Newtonsoft.Json;

public class LeaderHouseManager : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";

        DataSet ds = new DataSet();
        string connString = ConfigurationManager.AppSettings["ibis11copy"];
        SqlConnection conn = new SqlConnection(connString);
        SqlCommand sqlComm = new SqlCommand("usp_ld_BedBooking_LeaderHouseBed_Update");
        sqlComm.CommandType = CommandType.StoredProcedure;
        
        
        string t;
        int leaderHouseId = 0;

        t = context.Request.QueryString["t"];
        leaderHouseId = Convert.ToInt32(context.Request.QueryString["leaderHouseId"]);

        
        
        context.Response.Write("Hello World");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}