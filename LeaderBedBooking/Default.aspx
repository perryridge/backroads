<%@ Page Title="" Language="C#" MasterPageFile="~/LeaderBedBooking/LBB.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" Debug="false" ViewStateMode="Enabled" EnableSessionState="True" EnableViewState="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .gridPager td {
            padding: 2px 2px;
        }

        /*.gridPager a {
            background-color: White;
        }*/
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div runat="server" id="divPageTitle">
        <h1>Leader Bed Booking Schedule</h1>
    </div>
    <br />

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
        <div class="col-md-4">
            <asp:DropDownList ID="ddlLeaders" ClientIDMode="Static" CssClass="form-control dropdown" runat="server" DataTextField="LeaderName"
                DataValueField="iLeaderPartyID" OnSelectedIndexChanged="ddlLeaders_SelectedIndexChanged"
                AutoPostBack="true" EnableViewState="true" Visible="false">
            </asp:DropDownList>
        </div>
    </div>
    <div class="row">
        <div class="col-md-8">
            <h3>
                <asp:Label runat="server" ID="lblLeaderName"></asp:Label></h3>
            <asp:UpdatePanel runat="server" ID="updLeaderSchedule" UpdateMode="Conditional" EnableViewState="true">
                <ContentTemplate>
                    <br />
                    <div class="table-responsive">
                        <asp:GridView ID="grdLeaderView" ClientIDMode="Static" runat="server" AutoGenerateColumns="False"
                            AllowPaging="False" OnPageIndexChanging="grdLeaderView_PageIndexChanging" CssClass="table table-condensed"
                            ForeColor="Black" HeaderStyle-BackColor="#B0C4DE" PagerStyle-ForeColor="White" GridLines="Vertical"
                            OnRowCommand="btnRespond_RowCommand" OnRowUpdating="grdLeaderView_RowUpdating"
                            HeaderStyle-ForeColor="Black" CellPadding="1" CellSpacing="8" PageSize="20" RowStyle-HorizontalAlign="Center"
                            HeaderStyle-HorizontalAlign="Center">
                            <Columns>
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
                                            CssClass="btn btn-default" runat="server" Text="Cancel" Visible='<%# Eval("cStatus").ToString() == "Confirmed" || Eval("cStatus").ToString() == "Tentative" ? true : false %>' />
                                        <asp:Button ID="btnRespondConf" CommandName="Confirmed" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                            Visible='<%# Eval("cStatus").ToString() == "Cancelled" ? true : false %>' CssClass="btn btn-default" runat="server" Text='<%# Eval("activityName").ToString() == "Visiting" && Eval("cStatus").ToString() == "Cancelled" ? "Un-cancel":"Confirm" %>' />
                                        <asp:HiddenField runat="server" ID="hdnBedID" Value='<%# Eval("iLeaderHouseBedBookingID") %>' />
                                        <asp:HiddenField runat="server" ID="hdnLeaderHouseId" Value='<%# Eval("iLeaderHouseID") %>' />

                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle ForeColor="Blue"></HeaderStyle>
                            <PagerStyle ForeColor="Blue" CssClass="gridPager"></PagerStyle>
                        </asp:GridView>
                        <asp:Button ID="btnAdd" runat="server" Text="Leader House Reservation Request" OnClick="btnAdd_Click" />
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdatePanel runat="server" ID="uplAdd" UpdateMode="Conditional" Visible="false" ClientIDMode="Static" EnableViewState="true">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSubmitNew" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="ddlFrmHouse" EventName="ddlFrmHouse_SelectedIndexChanged" />
                </Triggers>
                <ContentTemplate>
                    <div id="divInputNew">
                        <br />
                        <h3>Leader House Reservation Request</h3>
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label for="tbFrmDate">
                                        Check-In Date</label>
                                    <asp:TextBox ID="tbFrmDate" ClientIDMode="Static" CssClass="form-control" runat="server" EnableViewState="false">Please Select</asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="tbFrmDate">
                                    </ajaxToolkit:CalendarExtender>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" Type="Date" ControlToValidate="tbFrmDate" ErrorMessage="Please select a check-in date" Display="None" Operator="DataTypeCheck"></asp:CompareValidator>
                                    <asp:RequiredFieldValidator ID="requiredCheckInDate" ControlToValidate="tbFrmDate" runat="server" Display="None" ErrorMessage="Check-in date is required"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-sm-4">
                                    <label for="tbToDate">
                                        Check-Out Date</label>
                                    <asp:TextBox ID="tbToDate" ClientIDMode="Static" CssClass="form-control" runat="server" EnableViewState="false">Please Select</asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="tbToDate">
                                    </ajaxToolkit:CalendarExtender>
                                    <asp:CompareValidator ID="compareCheckOutDate" runat="server" Type="Date" ControlToValidate="tbToDate" ErrorMessage="Please select a check-out date" Display="None" Operator="DataTypeCheck"></asp:CompareValidator>
                                    <asp:RequiredFieldValidator ID="requiredCheckOutDate" ControlToValidate="tbToDate" runat="server" Display="None" ErrorMessage="Check-out date is required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label for="ddlFrmHouse">
                                        Leader House</label>
                                    <asp:DropDownList ID="ddlFrmHouse" ClientIDMode="Static" CssClass="form-control dropdown"
                                        runat="server" OnSelectedIndexChanged="ddlFrmHouse_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="Please select a leader house" ValueToCompare="0" ControlToValidate="ddlFrmHouse" Display="None" Operator="NotEqual"></asp:CompareValidator>
                                    <asp:RequiredFieldValidator ID="requiredLeaderHouse" runat="server" ErrorMessage="Leader house selection is required" ControlToValidate="ddlFrmHouse" Display="None"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4">
                                    <label for="rbWorkingInArea">
                                        Are you working in the area on or around the requested date?</label>
                                    <asp:RadioButtonList ID="rbWorkingInArea" runat="server" RepeatDirection="Horizontal"
                                        ClientIDMode="Static" CellSpacing="8">
                                        <asp:ListItem Text="Yes - Working&nbsp;&nbsp;&nbsp;&nbsp;" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No - Visiting" Value="0" Selected="True"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                        </div>
                        <asp:Button runat="server" ID="btnSubmitNew" Text="Submit" OnClick="btnSubmitNew_Click"
                            CssClass="btn btn-submit" ClientIDMode="Static" />
                        <asp:Button runat="server" ID="btnCancel" CssClass="btn" OnClick="btnCancel_Click"
                            Text="Cancel" CausesValidation="false" EnableViewState="False" UseSubmitBehavior="False" />

                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    <div runat="server" id="debugging">
    </div>
    <asp:GridView ID="GridView1" runat="server"></asp:GridView>

<%--    <script type="text/javascript">

        function showAddForm() {
            $("#btnAdd2").hide();
            $("#divInputNew").show();
            $("#grdLeaderView").hide();
            $("#ddlLeaders").hide();
        }
    </script>--%>
</asp:Content>
