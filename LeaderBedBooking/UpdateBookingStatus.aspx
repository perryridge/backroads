<%@ Page Title="" Language="C#" MasterPageFile="~/LeaderBedBooking/LBB.master" AutoEventWireup="true" CodeFile="UpdateBookingStatus.aspx.cs" Inherits="LeaderBedBooking_UpdateBookingStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

	<title>Bed Bookings</title>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/bacon.js/0.7.12/bacon.js"></script>
    <script src="http://fb.me/react-0.10.0.js"></script>
    <script src="http://fb.me/JSXTransformer-0.10.0.js"></script>
	<script src="UpdateBookingStatus.js" type="text/jsx"></script>
	<style>
		#edit-bookings-wrapper {
			font-family : Arial;
			font-size 	: 10pt;
		}
		#edit-bookings-column-wrapper {
			margin 		: 0 auto;
			max-width 	: 30em;
		}
		#edit-bookings-wrapper h1 {
			text-align 	: center;
		}
		#edit-bookings-wrapper h2 {			
			font 			: inherit;
			font-weight 	: bold;
			text-transform  : uppercase;
		}
		#edit-bookings-wrapper h2,
		#edit-bookings-wrapper button {
			position 		: relative;
			left 			: -2em;			
		}
		.guestDragger {
			cursor 	: pointer;
		}
		.leader-name {
			display 	: inline-block;
			width 		: 10em;
		}
		.leader-row + .leader-row {
			margin-top: .25em;
		}
		.notification {
			color 		: green;
			font-weight : bold;
			height 		: 5em;
			left 		: -2em;
			position 	: relative;
		}
		select[data-leader-status="Confirmed"] {
			background-color : lightgreen;
		}
		select[data-leader-status="Overflow"] {
			background-color : orange;
		}
		select[data-leader-status="Tentative"] {
			background-color : lightyellow;
		}
		select[data-leader-status="Cancelled"] {
			background-color : lightgray;
		}
	</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

	<div id="bookingsApp"></div>

</asp:Content>

