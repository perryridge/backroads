/** @jsx React.DOM */

// CONSTANTS //

function leaderHouseNamesUrl(leaderHouseId, bookDate){
	return '/LeaderBedBooking/GetLeaderHouseInfo.ashx?t=Names&leaderHouseId='+leaderHouseId+'&bookDate='+bookDate;
}

function guestStatusPostUrl(leaderHouseId, bookDate, leaderId, status){
	return '/LeaderBedBooking/GetLeaderHouseInfo.ashx?t=Update&leaderHouseId='+leaderHouseId+'&bookDate='+bookDate+'&leaderId='+leaderId+'&status='+status;
}

function leaderHouseMainUrl(leaderHouseId){
	return '/LeaderBedBooking/LeaderHouse.aspx?leaderHouseId=' + leaderHouseId;
}

function leaderHouseId(){
	return getParameterByName('leaderHouseId');	
}

function bookDate(){
	return getParameterByName('bookDate');
}

// UTILITY FNS //

function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

function xhrStream(url){
	return Bacon.fromCallback(function(callback){
		var xhr = new XMLHttpRequest();
		xhr.onload = function(){
			callback(JSON.parse(this.response));
		};
		xhr.open('get', url);
		xhr.send();
	});
}

// MODELS //

var LeaderHouse = Object.create(null);

// Streams

var initialGuestsStream = buildInitialGuestsStream();
var guestChangesStream	= new Bacon.Bus();
var statusChangesStream = new Bacon.Bus();
var guestsStream 		= Bacon.mergeAll(initialGuestsStream, guestChangesStream).toProperty();
var notificationsStream = new Bacon.Bus();

function buildInitialGuestsStream(){
	return xhrStream(leaderHouseNamesUrl(leaderHouseId(), bookDate()))
		.map(function(namesData){
			console.log(namesData);
			return namesData.map(function(guest){
				return { id : guest.iPartyID, name : guest.cname, status : guest.cStatus };
			});
		});
}

statusChangesStream.onValue(function(statusChange){
	var xhr = new XMLHttpRequest();
	xhr.onload = function(){
		notificationsStream.push({ notification : 'Successfully changed status' })
	};
	xhr.open('post', guestStatusPostUrl(leaderHouseId(), bookDate(), statusChange.leaderId, statusChange.status, true));
	xhr.send();
});

var filterGuestStatus = function(guests, status){
	return guests.filter(function(guest){
		return guest.status === status;
	});
};

var BookingsApp = React.createClass({
	getInitialState: function(){
		return {
			guests 			: [],
			notification 	: { message : '' }
		};
	},
	componentWillMount: function(){
		guestsStream.onValue(function(guests){
			this.setState({ guests: guests });
		}.bind(this));
		notificationsStream.flatMapLatest(function(notification){
			return Bacon.once(notification)
				.concat(Bacon.later(5000, { message: '' }));
		}).onValue(function(notification){
			this.setState({ notification: notification });
		}.bind(this));
	},

	render: function(){
		return (
			<div id="edit-bookings-wrapper">
				<h1>Bed Bookings for California Leader House</h1>
				<div id="edit-bookings-column-wrapper">
					<h2>Date</h2>
					<a href="#">{bookDate()}</a>
					<GuestRow guests={this.state.guests} status="Confirmed" />
					<GuestRow guests={this.state.guests} status="Tentative" />
					<GuestRow guests={this.state.guests} status="Overflow" />
					<GuestRow guests={this.state.guests} status="Cancelled" />
					<p className="notification">{this.state.notification}</p>
					<a href={leaderHouseMainUrl(leaderHouseId())}>Back to main Leader House page</a>
				</div>
			</div>
		);
	}
})

var GuestRow = React.createClass({
	render: function(){
		var guestsWithStatus = filterGuestStatus(this.props.guests, this.props.status);
		var guestRows = guestsWithStatus.map(function(guest){
			var handleStatusChange = function(e){
				guest.status = e.currentTarget.value;
				guestChangesStream.push(this.props.guests);
				statusChangesStream.push({leaderId: guest.id, status: guest.status});
			}.bind(this);
			return (
				<div className="leader-row">
					<div className="leader-name">{guest.name}</div>
					<select className="leader-status" value={guest.status} data-leader-status={guest.status} onChange={handleStatusChange}>
						<option value="Confirmed">Confirmed</option>
						<option value="Overflow">Overflow</option>
						<option value="Tentative">Tentative</option>
						<option value="Cancelled">Cancelled</option>
					</select>
				</div>
			);
		}, this)
		return (
			<div>
				<h2>{this.props.status} ({guestsWithStatus.length})</h2>
				{guestRows}
			</div>
		);
	}
});

React.renderComponent(
	<BookingsApp />,
	document.getElementById('bookingsApp')
)

