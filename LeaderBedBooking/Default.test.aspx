<%@ Page Title="" Language="C#" MasterPageFile="~/LeaderBedBooking/LBB.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" Debug="true" EnableViewState="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .gridPager td {
            padding: 2px 2px;
        }

        .gridPager a {
            background-color: White;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel runat="server" ID="updLeaderSchedule" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="row">
                <div class="col-md-3">
                </div>
                <div class="col-xs-6">
                    <p class="alert alert-warning text-center" id="pAlertMsg" runat="server" clientidmode="Static"
                        style="display: none;">
                        <asp:Label runat="server" ID="lblWarning" ClientIDMode="Static"></asp:Label>
                    </p>
                </div>
                <div class="col-md-3">
                </div>
            </div>
            <div class="row">
                <%--        <div class="col-md-3">
            <!--SIDE MENU NAV HERE-->
        </div>
                --%>
                <div class="col-md-12">
                    <asp:DropDownList ID="ddlLeaders" ClientIDMode="Static" runat="server" DataTextField="LeaderName"
                        DataValueField="iLeaderPartyID" OnSelectedIndexChanged="ddlLeaders_SelectedIndexChanged"
                        AutoPostBack="true" EnableViewState="true" Visible="false">
                    </asp:DropDownList>
                    <br />
                    <br />
                    <h3>
                        <asp:Label runat="server" ID="lblLeaderName"></asp:Label></h3>
                    <div class="table-responsive">
                        <asp:GridView ID="grdLeaderView" ClientIDMode="Static" runat="server" AutoGenerateColumns="False"
                            AllowPaging="True" OnPageIndexChanging="grdLeaderView_PageIndexChanging" CssClass="table table-condensed"
                            ForeColor="Black" HeaderStyle-BackColor="#B0C4DE" PagerStyle-ForeColor="White" GridLines="Vertical"
                            OnRowCommand="btnRespond_RowCommand" OnRowUpdating="grdLeaderView_RowUpdating"
                            HeaderStyle-ForeColor="Black" CellPadding="1" CellSpacing="8" PageSize="20" RowStyle-HorizontalAlign="Center"
                            HeaderStyle-HorizontalAlign="Center">
                            <Columns>
                                <%--<asp:CommandField ShowEditButton="true" ButtonType="Button" ControlStyle-CssClass="btn btn-primary"
                            EditText="Reply" UpdateText="Submit" ItemStyle-HorizontalAlign="Center" />
                                   <asp:BoundField DataField="LeaderName" HeaderText="Leader Name" ReadOnly="true" />
                                --%>
                                <asp:BoundField DataField="activityName" HeaderText="Activity" ReadOnly="true" HeaderStyle-HorizontalAlign="Center"
                                    HeaderStyle-ForeColor="Black" />
                                <asp:BoundField DataField="dDate" HeaderText="Date" DataFormatString="{0:MM/dd/yyyy}"
                                    ReadOnly="true" HeaderStyle-ForeColor="Black" />
                                <asp:BoundField DataField="cLeaderHouseName" HeaderText="Leader House" ReadOnly="true"
                                    SortExpression="cLeaderHouseName" HeaderStyle-ForeColor="Black" />
                                <asp:BoundField DataField="cStatus" HeaderText="Status" HeaderStyle-ForeColor="Black" />
                                <asp:TemplateField HeaderText="Cancel or Confirm Booking" ItemStyle-HorizontalAlign="Center"
                                    HeaderStyle-Wrap="true" HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="Black">
                                    <ItemTemplate>
                                        <asp:Button ID="btnRespondCanx" CommandName="Cancelled" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                            CssClass="btn btn-default" runat="server" Text="Cancel" Visible='<%# Eval("cStatus").ToString() == "Confirmed" ? true : false %>' />
                                        <asp:Button ID="btnRespondConf" CommandName="Confirmed" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                            Visible='<%# Eval("cStatus").ToString() == "Cancelled" || Eval("cStatus").ToString() == "Tentative" ? true : false %>' CssClass="btn btn-default" runat="server" Text="Confirm" />
                                        <%--                                        <asp:Button ID="btnRespond" CommandName='<%# Eval("cStatus").ToString() == "Confirmed" ? "Cancelled":"Confirmed" %>' CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                            CssClass="btn btn-default" runat="server" Text='<%# Eval("cStatus").ToString() == "Confirmed" ? "Cancel":"Confirm" %>' />
                                        --%>
                                        <asp:HiddenField runat="server" ID="hdnBedID" Value='<%# Eval("iLeaderHouseBedBookingID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--                                <asp:BoundField DataField="cNotes" HeaderText="Notes" ReadOnly="true" />
                                --%>
                            </Columns>
                            <HeaderStyle ForeColor="Blue"></HeaderStyle>
                            <PagerStyle ForeColor="Blue" CssClass="gridPager"></PagerStyle>
                        </asp:GridView>
                        <button id="btnAdd2" clientidmode="Static" class="btn btn-default" onclick="showAddForm()"
                            type="button" runat="server">
                            Leader House Reservation Request</button>
                    </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel runat="server" ID="uplAdd" UpdateMode="Conditional">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddlFrmHouse" EventName="ddlFrmHouse_SelectedIndexChanged" />
        </Triggers>
        <ContentTemplate>
            <div id="divInputNew">
                <br />
                <h3>Leader House Reservation Request</h3>
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-2">
                            <label for="tbFrmDate">
                                Check-In Date</label>
                            <asp:TextBox ID="tbFrmDate" ClientIDMode="Static" CssClass="form-control" runat="server">Please Select</asp:TextBox>
                            <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="tbFrmDate">
                            </ajaxToolkit:CalendarExtender>
                        </div>
                        <div class="col-xs-2">
                            <label for="tbToDate">
                                Check-Out Date</label>
                            <asp:TextBox ID="tbToDate" ClientIDMode="Static" CssClass="form-control" runat="server">Please Select</asp:TextBox>
                            <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="tbToDate">
                            </ajaxToolkit:CalendarExtender>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-2">
                            <label for="ddlFrmHouse">
                                Leader House</label>
                            <asp:DropDownList ID="ddlFrmHouse" ClientIDMode="Static" CssClass="form-control dropdown"
                                runat="server" EnableViewState="true" OnSelectedIndexChanged="ddlFrmHouse_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-2">
                            <label for="rbWorkingInArea">
                                Are you working in the area on or around the requested date?</label>
                            <asp:RadioButtonList ID="rbWorkingInArea" runat="server" RepeatDirection="Horizontal"
                                ClientIDMode="Static">
                                <asp:ListItem Text="Yes - Working" Value="1"></asp:ListItem>
                                <asp:ListItem Text="No - Visiting" Value="0" Selected="True"></asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                    </div>
                </div>
                <%--                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-2">
                                    <label for="tbFrmNotes">
                                        Notes</label>
                                    <asp:TextBox ID="tbFrmNotes" Columns="4" Rows="4" runat="server" TextMode="MultiLine"
                                        ClientIDMode="Static" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                --%>

                <asp:Button runat="server" ID="btnSubmitNew" Text="Submit" OnClick="btnSubmitNew_Click"
                    CssClass="btn btn-submit" ClientIDMode="Static" UseSubmitBehavior="true" />
                <asp:Button runat="server" ID="btnCancel" CssClass="btn" OnClick="btnCancel_Click"
                    Text="Cancel" CausesValidation="false" EnableViewState="False" UseSubmitBehavior="False" />

            </div>
            <div runat="server" id="debugging">
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>

    <script type="text/javascript">

        function showAddForm() {
            $("#btnAdd2").hide();
            $("#divInputNew").show();
            $("#grdLeaderView").hide();
            $("#ddlLeaders").hide();
        }
        //            $("#lnkSubmitNew").click(function (event) {
        //                //event.preventDefault();
        //                $("#pAlertMsg").show();
        //                $("#lblWarning").html("You must select a start date.");
        //                 if ($("#tbToDate").val() == "Please Select") {
        //                    
        //                }
        //            });

    </script>
</asp:Content>
