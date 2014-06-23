<%@ WebHandler Language="C#" Class="LeaderHouseManager" %>

using System;
using System.Web;
using System.Text;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Linq;
using Newtonsoft.Json;

public class LeaderHouseManager : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        context.Response.ContentEncoding = Encoding.UTF8;

        string resp = "";
       
        string t;

        int leaderhouseid = 0;
        int leaderhousebedid;
        int from_month = 0;
        int to_month = 0;
        int from_day = 0;
        int to_day = 0;
        int num_beds = 0;
        int num_beds_other = 0;
        //string notes = "";
        int who_updated = 0;
        

        ////notes = context.Request.QueryString["notes"];
        //who_updated = Convert.ToInt32(context.Request.QueryString["who_updated"]);
        
        string connString = ConfigurationManager.ConnectionStrings["ibis11copy2"].ToString();
        SqlConnection conn = new SqlConnection(connString);

        t = context.Request.QueryString["t"];
        

        switch (t)
        {
            case "GetBeds":
                leaderhouseid = Convert.ToInt32(context.Request.QueryString["leaderhouseid"]);
                resp = GetBeds(leaderhouseid);
                break;
            case "Update":
                SqlCommand sqlComm;
                
                //leaderhousebedid = Convert.ToInt32(context.Request.QueryString["leaderhousebedid"]);
                //from_month = Convert.ToInt32(context.Request.QueryString["from_month"]);
                //to_month = Convert.ToInt32(context.Request.QueryString["to_month"]);
                //from_day = Convert.ToInt32(context.Request.QueryString["from_day"]);
                //to_day = Convert.ToInt32(context.Request.QueryString["to_day"]);
                //num_beds = Convert.ToInt32(context.Request.QueryString["num_beds"]);
                //num_beds_other = Convert.ToInt32(context.Request.QueryString["num_beds_other"]);

                List<string> reqP = (List<string>)JsonConvert.DeserializeObject(context.Request.ToString(),typeof(List<string>));
                
                leader
                from_month = Convert.ToInt32(context.Request.QueryString["from_month"]);
                to_month = Convert.ToInt32(context.Request.QueryString["to_month"]);
                from_day = Convert.ToInt32(context.Request.QueryString["from_day"]);
                to_day = Convert.ToInt32(context.Request.QueryString["to_day"]);
                num_beds = Convert.ToInt32(context.Request.QueryString["num_beds"]);
                num_beds_other = Convert.ToInt32(context.Request.QueryString["num_beds_other"]);

                conn.Open();
                sqlComm = new SqlCommand("usp_ld_BedBooking_LeaderHouseBed_Update", conn);
                sqlComm.CommandType = CommandType.StoredProcedure;
                sqlComm.Parameters.AddWithValue("@iLeaderHouseBedID", leaderhousebedid);
                sqlComm.Parameters.AddWithValue("@iLeaderHouseID", leaderhouseid);
                sqlComm.Parameters.AddWithValue("@iFromMonth", from_month);
                sqlComm.Parameters.AddWithValue("@iFromDay", from_day);
                sqlComm.Parameters.AddWithValue("@iToMonth", to_month);
                sqlComm.Parameters.AddWithValue("@iToDay", to_day);
                sqlComm.Parameters.AddWithValue("@iNumBeds", num_beds);
                sqlComm.Parameters.AddWithValue("@iNumBedsOther", num_beds_other);

                try
                {
                    sqlComm.ExecuteNonQuery();
                    resp = "success";
                }
                catch(Exception e)
                {
                    resp = e.Message;
                }
                
                //SqlDataAdapter sda = new SqlDataAdapter();
                
                break;
            case "Add":
                
                leaderhousebedid = 0;
                leaderhouseid = Convert.ToInt32(context.Request.QueryString["leaderhouseid"]);
                from_month = Convert.ToInt32(context.Request.QueryString["from_month"]);
                to_month = Convert.ToInt32(context.Request.QueryString["to_month"]);
                from_day = Convert.ToInt32(context.Request.QueryString["from_day"]);
                to_day = Convert.ToInt32(context.Request.QueryString["to_day"]);
                num_beds = Convert.ToInt32(context.Request.QueryString["num_beds"]);
                num_beds_other = Convert.ToInt32(context.Request.QueryString["num_beds_other"]);

                conn.Open();
                SqlCommand sqlComm = new SqlCommand("usp_ld_BedBooking_LeaderHouseBed_Update", conn);
                sqlComm.CommandType = CommandType.StoredProcedure;
                sqlComm.Parameters.AddWithValue("@iLeaderHouseBedID", leaderhousebedid);
                sqlComm.Parameters.AddWithValue("@iLeaderHouseID", leaderhouseid);
                sqlComm.Parameters.AddWithValue("@iFromMonth", from_month);
                sqlComm.Parameters.AddWithValue("@iFromDay", from_day);
                sqlComm.Parameters.AddWithValue("@iToMonth", to_month);
                sqlComm.Parameters.AddWithValue("@iToDay", to_day);
                sqlComm.Parameters.AddWithValue("@iNumBeds", num_beds);
                sqlComm.Parameters.AddWithValue("@iNumBedsOther", num_beds_other);

                try
                {
                    sqlComm.ExecuteNonQuery();
                    resp = "success";
                }
                catch(Exception e)
                {
                    resp = e.Message;
                }
                

                break;
                
            default:
                break;
        }
        
        context.Response.Write(resp);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
    
    private string GetBeds(int leaderhouseid)
    {
        string resp = "";

        DataSet ds = new DataSet();
        conn.Open();
        SqlCommand sqlComm = new SqlCommand();
        
        
        
        //DataSet1TableAdapters.LeaderHouse_BedTableAdapter lhb = new DataSet1TableAdapters.LeaderHouse_BedTableAdapter();
        //sqlComm.CommandType = CommandType.Text;
        //sqlComm.CommandText = "SELECT * from LeaderHouse_Bed where iLeaderHouseID = " + leaderhouseid;
        //sqlComm.Connection = conn;
        SqlDataAdapter sda = new SqlDataAdapter("SELECT * from LeaderHouse_Bed where iLeaderHouseID = " + leaderhouseid, conn);
        sda.Fill(ds);
        
        JsonSerializerSettings setts = new JsonSerializerSettings();
        setts.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
        //var b = lhb.GetDataByLeaderHouseID(leaderhouseid).AsDataView();
        resp = JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented, setts);
        //var leaderList = Cache[cacheKey];
        //if (leaderList == null)
        //{
        //    var LeaderHouseBeds = (from l in lhb.GetData()
        //                           group l by l.cLeaderHouseName into g
        //                           select new { House = g.Key, Info = g }).ToList();
        //    Cache.Insert(cacheKey, LeaderHouseBeds);
        //    leaderList = Cache[cacheKey];
        //}

        return resp;
    }
    

}