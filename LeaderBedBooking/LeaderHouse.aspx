<%@ Page Title="" Language="C#" MasterPageFile="~/LeaderBedBooking/LBB.master" AutoEventWireup="true" ViewStateMode="Enabled" EnableSessionState="True"
    CodeFile="LeaderHouse.aspx.cs" Inherits="LeaderBedBooking_LeaderHouse" Debug="false" EnableViewState="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="col-md-12 text-center">
        <h1>Leader House</h1>
        <br />
        <div class="row">
            <div class="col-md-4">
                <asp:DropDownList ID="ddlLeaderHouses" CssClass="form-control dropdown" runat="server"
                    OnSelectedIndexChanged="ddlLeaderHouses_OnSelectedIndexChange" AutoPostBack="true">
                    <asp:ListItem Text="--Please Select--"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-8">
                <div class="table-responsive">
                    <asp:DetailsView ID="dtlLeaderHouseInformation" runat="server" AutoGenerateRows="false"
                        GridLines="None" CssClass="table alert alert-info">
                        <Fields>
                            <%--                            <asp:BoundField DataField="cLeaderHouseName" ItemStyle-CssClass="h2" />
                            --%>
                            <asp:BoundField DataField="cAddress" HeaderText="Location" />
                            <asp:BoundField DataField="iNumBeds" HeaderText="Beds" />
                            <asp:BoundField DataField="cWarehouse" HeaderText="Warehouse" />
                            <asp:BoundField DataField="cRssName" HeaderText="RSS" />
                        </Fields>
                    </asp:DetailsView>
                </div>                
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="row">
            <div class="col-md-3"></div>
                <div class="col-md-4">
                    <p class="bg-info" style="padding:5px 5px;">Legend: (S)=Scheduled, (W)=Working, (V)=Visiting</p>
                </div>
                <div class="col-md-5"></div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <asp:UpdatePanel runat="server" ID="pnlBookings">
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="dtlLeaderHouseInformation" EventName="OnSelectedIndexChanged" />
                            </Triggers>
                            <ContentTemplate>
                                <asp:GridView ID="grvLeaderHouseBookings" runat="server" ShowHeader="true" CssClass="table"
                                    GridLines="Vertical" AutoGenerateColumns="False" OnRowDataBound="grvLeaderHouseBookings_RowDataBound" OnRowEditing="grvLeaderHouseBookings_RowEditing">
                                    <Columns>
                                        <asp:BoundField DataField="dDate" DataFormatString="{0:M/d}" HeaderText="Date" />
                                        <asp:BoundField DataField="iNumBeds" HeaderText="Available Beds" />
                                        <asp:BoundField DataField="iBedsBooked" HeaderText="Beds Booked" />
                                        <asp:TemplateField HeaderText="Overflow Count">
                                            <ItemTemplate>
                                                <%# Convert.ToInt32(Eval("iOverflow")) < 0 ? "0": Eval("iOverflow") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Confirmed">
                                            <ItemTemplate>
                                                <asp:Repeater ID="rptrConf" runat="server">
                                                <SeparatorTemplate><br /></SeparatorTemplate>
                                                    <ItemTemplate>
                                                        <%# Eval("cName") %>(<%#Eval("cBookType") %>)
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Overflow">
                                            <ItemTemplate>
                                                <asp:Repeater ID="rptrOvrf" runat="server">
                                                <SeparatorTemplate><br /></SeparatorTemplate>
                                                    <ItemTemplate>
                                                        <%# Eval("cName") %>(<%#Eval("cBookType") %>)
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Tentative">
                                            <ItemTemplate>
                                                <asp:Repeater ID="rptrTent" runat="server">
                                                <SeparatorTemplate><br /></SeparatorTemplate>
                                                    <ItemTemplate>
                                                        <%# Eval("cName") %>(<%#Eval("cBookType") %>)
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cancelled">
                                            <ItemTemplate>
                                                <asp:Repeater ID="rptrCanx" runat="server">
                                                <SeparatorTemplate><br /></SeparatorTemplate>
                                                    <ItemTemplate>
                                                        <%# Eval("cName") %>(<%#Eval("cBookType") %>)
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Label ID="lblEditBtn" runat="server" Text="Edit"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div class="col-md-6">
                </div>
            </div>
        </div>
        <asp:GridView ID="GridView2" runat="server">
        </asp:GridView>
    </div>

</asp:Content>
