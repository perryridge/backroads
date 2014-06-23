<%@ Page Title="" Language="C#" MasterPageFile="~/LeaderBedBooking/LBB.master" AutoEventWireup="true"
    Debug="false" EnableViewState="false" CodeFile="RSSMaintenance.aspx.cs" Inherits="LeaderBedBooking_RSSMaintenance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .LeaderHouseTable tr td {
            padding: 3px 3px;
            /*background-color: #B0C4DE;*/
        }


        .calTheme .ajax__calendar_container {
            background-color: #e2e2e2;
            border: solid 1px #cccccc;
        }

        .calTheme .ajax__calendar_header {
            background-color: #ffffff;
            margin-bottom: 4px;
        }

        .calTheme .ajax__calendar_title, .calTheme .ajax__calendar_next, .calTheme .ajax__calendar_prev {
            color: #004080;
            padding-top: 3px;
        }

        .calTheme .ajax__calendar_body {
            background-color: #e9e9e9;
            border: solid 1px #cccccc;
        }

        .calTheme .ajax__calendar_dayname {
            text-align: center;
            font-weight: bold;
            margin-bottom: 4px;
            margin-top: 2px;
        }

        .calTheme .ajax__calendar_day {
            text-align: center;
        }

        .calTheme .ajax__calendar_hover .ajax__calendar_day, .calTheme .ajax__calendar_hover .ajax__calendar_month, .calTheme .ajax__calendar_hover .ajax__calendar_year, .calTheme .ajax__calendar_active {
            color: #004080;
            font-weight: bold;
            background-color: #ffffff;
        }

        .calTheme .ajax__calendar_today {
            font-weight: bold;
        }

        .calTheme .ajax__calendar_other, .calTheme .ajax__calendar_hover .ajax__calendar_today, .calTheme .ajax__calendar_hover .ajax__calendar_title {
            color: #bbbbbb;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1>RSS Maintenance</h1>
    <div class="row">
        <div class="col-md-12">

            <asp:UpdatePanel runat="server" ID="upnlLeaderHouseGrid">
                <ContentTemplate>
                    <div class="table-responsive">
                        <asp:GridView ID="gvLeaderHouses" RowStyle-BackColor="#B0C4DE" CssClass="table table-condensed"
                            OnRowEditing="gvLeaderHouses_RowEditing" runat="server" OnRowCancelingEdit="gvLeaderHouses_RowCanceling"
                            GridLines="None" CellSpacing="8" AutoGenerateColumns="false" RowStyle-VerticalAlign="Top"
                            CellPadding="8">
                            <Columns>
                                <asp:BoundField DataField="House" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Larger"
                                    ReadOnly="true" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblHouseInfo"></asp:Label>
                                        <asp:GridView ID="gvHouseBeds" runat="server" CssClass="table table-condensed" DataSource='<%# Eval("Info") %>'
                                            OnRowDataBound="gvHouseBeds_RowDataBound" AutoGenerateColumns="false" RowStyle-HorizontalAlign="Left"
                                            RowStyle-VerticalAlign="Bottom" CellPadding="8" CellSpacing="8" EnableViewState="False">
                                            <Columns>
                                                <asp:BoundField DataField="cAddress" HeaderText="Address" />
                                                <asp:TemplateField HeaderText="Available Dates">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblFromDate"></asp:Label>
                                                        <asp:Label runat="server" ID="lblToDate"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="iNumBeds" HeaderText="# of Beds Available" ItemStyle-HorizontalAlign="Center" />
                                            </Columns>
                                        </asp:GridView>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label runat="server" ID="lblFromDate">From: </asp:Label><asp:TextBox ID="tbFromDate"
                                            runat="server"></asp:TextBox><ajaxToolkit:CalendarExtender ID="calxFromDate" runat="server"
                                                TargetControlID="tbFromDate" CssClass="calTheme">
                                            </ajaxToolkit:CalendarExtender>
                                        <asp:Label runat="server" ID="lblToDate">To: </asp:Label><asp:TextBox ID="tbToDate"
                                            runat="server"></asp:TextBox><ajaxToolkit:CalendarExtender ID="calxToDate" runat="server"
                                                TargetControlID="tbToDate">
                                            </ajaxToolkit:CalendarExtender>
                                        <asp:Label runat="server" ID="lblNumBeds"># of beds available: </asp:Label><asp:TextBox
                                            ID="tbNumBeds" runat="server"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ButtonType="Button" ControlStyle-CssClass="btn btn-default" ShowEditButton="true" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>


            <%--            <asp:DataList ID="dlLeaderHouses" runat="server">
                <ItemTemplate>
                    <h4>
                        <%# Eval("House") %></h4>
                    <div class="table-responsive">
                    </div>
                </ItemTemplate>
            </asp:DataList>
            --%>
        </div>
    </div>
</asp:Content>
