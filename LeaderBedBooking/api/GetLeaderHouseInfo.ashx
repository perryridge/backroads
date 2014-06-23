<%@ WebHandler Language="C#" Class="GetLeaderHouseInfo" Debug="true" %>

using System;
using System.Text;
using System.Web;
using System.Data;
using System.Linq;
using Newtonsoft.Json;

public class GetLeaderHouseInfo : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        context.Response.ContentEncoding = Encoding.UTF8;

        string t;
        int leaderHouseId = 0;
        DateTime bookDate;
        int leaderId = 0;
        string cStat = "";
        var resp = "";

        DataSet1 ds = new DataSet1();

        t = context.Request.QueryString["t"];
        leaderHouseId = Convert.ToInt32(context.Request.QueryString["leaderHouseId"]);
        bookDate = Convert.ToDateTime(context.Request.QueryString["bookDate"]);
        leaderId = Convert.ToInt32(context.Request.QueryString["leaderId"]);
        cStat = context.Request.QueryString["status"];

        JsonSerializerSettings setts = new JsonSerializerSettings();

        switch (t)
        {
            case "HouseInfo":
                DataSet1TableAdapters.usp_ld_bedBooking_GetLeaderHousesTableAdapter lhdt = new DataSet1TableAdapters.usp_ld_bedBooking_GetLeaderHousesTableAdapter();
                var b = lhdt.GetData(Convert.ToInt32(leaderHouseId), 0).AsDataView();
                setts.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
                resp = JsonConvert.SerializeObject(b, Newtonsoft.Json.Formatting.Indented, setts);
                break;

            case "Names":
                DataSet1TableAdapters.usp_ld_BedBooking_Get_NamesTableAdapter allNames = new DataSet1TableAdapters.usp_ld_BedBooking_Get_NamesTableAdapter();
                setts.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
                resp = JsonConvert.SerializeObject(allNames.GetData(leaderHouseId, bookDate, "ALL").ToArray(), Newtonsoft.Json.Formatting.Indented, setts);

                break;
            
            case "BookedDates":
                DataSet1TableAdapters.usp_ld_BedBooking_Get_LeaderHouseDatesTableAdapter datesTA = new DataSet1TableAdapters.usp_ld_BedBooking_Get_LeaderHouseDatesTableAdapter();
                var bookedDates = (from d in datesTA.GetData(Convert.ToInt32(leaderHouseId))
                                   select d.dDate.ToString());
                setts.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
                resp = JsonConvert.SerializeObject(bookedDates);
                break;
                
            case "Update":
                DataSet1TableAdapters.LeaderHouse_BedBookingTableAdapter lhbb_ta = new DataSet1TableAdapters.LeaderHouse_BedBookingTableAdapter();
                try
                {
                    lhbb_ta.UpdateLeaderResponse(cStat, leaderId, bookDate, leaderHouseId);
                    resp = JsonConvert.SerializeObject("Success");                    
                }
                catch
                {
                    resp = JsonConvert.SerializeObject("Failed to update");
                }
                break;

            default:
                break;
        }

        context.Response.Write(resp);

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}