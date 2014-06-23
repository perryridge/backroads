<%@ Control Language="C#" AutoEventWireup="true" CodeFile="navigation2Lbb.ascx.cs" Inherits="LeaderBedBooking_controls_navigation2Lbb" %>
<script type="text/javascript">

<!-- Begin
    var isDOM = false, isNS4 = false;
    if (document.all)
        var isDOM = true, docObj = 'document.all.', styObj = '.style';
    else if (document.layers)
        var isNS4 = true, docObj = 'document.', styObj = '';
    else
        var isDOM = true, docObj = 'document.all.', styObj = '.style';

    //alert('isDOM ' + isDOM);
    //alert('isNS4 ' + isNS4);

    var popTimer = 0;
    var litNow = new Array();

    function popOver(menuNum, itemNum) {
        clearTimeout(popTimer);
        hideAllBut(menuNum);
        litNow = getTree(menuNum, itemNum);
        changeCol(litNow, true);
        targetNum = menu[menuNum][itemNum].target;
        if (targetNum > 0) {
            targetName = menu[targetNum][0].id;
            menuName = menu[menuNum][0].id;
            menuRef = eval(docObj + menuName + styObj);
            thisX = parseInt(menuRef.left);
            thisY = parseInt(menuRef.top);

            itemPath = docObj;
            if (isNS4) itemPath += menuName + '.document.';
            itemRef = eval(itemPath + menuName + itemNum.toString() + styObj);
            thisX += parseInt(itemRef.left);
            thisY += parseInt(itemRef.top);

            with (eval(docObj + targetName + styObj)) {
                left = parseInt(thisX + menu[targetNum][0].x);
                top = parseInt(thisY + menu[targetNum][0].y);
                visibility = 'visible';
            }
        }
    }

    function popOut(menuNum, itemNum) {
        popTimer = setTimeout('hideAllBut(0)', 500);
    }

    function getTree(menuNum, itemNum) {
        itemArray = new Array(menu.length);
        while (1) {
            itemArray[menuNum] = itemNum;
            if (menuNum == 0) return itemArray;
            itemNum = menu[menuNum][0].parentItem;
            menuNum = menu[menuNum][0].parentMenu;
        }
    }

    function changeCol(changeArray, isOver) {
        for (menuCount = 0; menuCount < changeArray.length; menuCount++) {
            if (changeArray[menuCount]) {
                thisMenu = menu[menuCount][0].id;
                thisItem = thisMenu + changeArray[menuCount].toString();
                newCol = isOver ? menu[menuCount][0].overCol : menu[menuCount][0].backCol;
                if (isDOM) document.all[thisItem].style.backgroundColor = newCol;
                if (isNS4) document[thisMenu].document[thisItem].bgColor = newCol;
            }
        }
    }

    function hideAllBut(menuNum) {
        var keepMenus = getTree(menuNum, 1);
        for (count = 0; count < menu.length; count++)
            if (!keepMenus[count])
                eval(docObj + menu[count][0].id + styObj + '.visibility = "hidden"');
        changeCol(litNow, false);
    }

    var endDL = isDOM ? '</div>' : '</layer>';

    function Menu(id, x, y, width, overCol, backCol, borderCol) {
        this.id = id;
        this.x = x;
        this.y = y;
        this.width = width;

        this.overCol = overCol;
        this.backCol = backCol;
        this.borderCol = borderCol;

        this.parentMenu = null;
        this.parentItem = null;
    }

    function Item(text, href, height, target) {
        this.text = text;
        this.href = href;
        this.height = height;
        this.target = target;
    }

    function startDL(id, x, y, width, height, vis, back, border, zIndex, extraProps) {
        // Write a div in IE that resembles a layer's settings, or a layer in NS.
        if (isDOM) {
            str = '<div class="menuWrapper" id="' + id + '" style="position: absolute; left: ' + x + '; top: ' + y +
            '; width: ' + width + '; height: ' + height + '; visibility: ' + vis + '; ';
            if (back) str += 'background: ' + back + '; ';
            if (border) str += 'padding: 3px; border: 1px solid ' + border + '; ';
            if (zIndex) str += 'z-index: ' + zIndex + '; ';

            str += '" ';
        }
        if (isNS4) {
            str = '<layer id="' + id + '" left="' + x + '" top="' + y + '" width="' + width +
            '" height="' + height + '" visibility="' + vis + '" ';
            if (back) str += 'bgcolor="' + back + '" ';
            if (border) str += 'style="border: 1px solid ' + border + '" ';
            if (zIndex) str += 'z-index="' + zIndex + '" ';
        }
        return str + extraProps + '>';
    }

    function mouseProps(currMenu, currItem) {
        return 'onMouseOver="popOver(' + currMenu + ',' + currItem + ')" onMouseOut="popOut(' + currMenu + ',' + currItem + ')"';
    }

    function writeMenus(customRoot, popInd) {
        for (currMenu = 0; currMenu < menu.length; currMenu++) {
            showMenu = true;
            if ((currMenu == 0) && customRoot) {
                document.write(customRoot);
                showMenu = false;
            }
            with (menu[currMenu][0]) {
                menuHTML = startDL(id, x, y, 0, 0, 'hidden', null, null, 100, '');

                var back = backCol, bord = borderCol, currWidth = width - 8;
            }

            itemPos = 0;

            for (currItem = 1; currItem < menu[currMenu].length; currItem++) {

                trigID = menu[currMenu][0].id + currItem.toString();

                with (menu[currMenu][currItem]) {

                    menuHTML += startDL(trigID, 0, itemPos, 0, 0, 'inherit', back, bord, 100, mouseProps(currMenu, currItem)) + '<table class="menuTable" width="' + currWidth + '" border="0" cellspacing="0" cellpadding="0"><tr>' + '<td align="left"><a class="Item" href="' + href + '">' + text + '</a></td>' + '<td class="Item" align="right">' + (target ? popInd : '') + '</td></tr></table>' + endDL;
                    if (target > 0) {

                        menu[target][0].parentMenu = currMenu;
                        menu[target][0].parentItem = currItem;
                    }

                    itemPos += height;
                }
            }

            // Write this menu to the document.
            if (showMenu) document.write(menuHTML + endDL);
            litNow[currMenu] = null;
        }
    }
    //  End -->
</script>


<%--<head>
	<link href="styles.css" type="text/css" rel="stylesheet">
</head>

--%>

<script type="text/javascript">
    function StartHelp() {
        window.open

    ("/#Root#/documents/Help/HelpFile.cfm", "HelpWindow", "toolbar=no,width=600,height=400,left=30,top=10,innerwidth=350,innerheight=550,directories=no,status=no,scrollbars=yes,resize=no,menubar=no");
    }
</script>


<script  type="text/javascript">
    var menu = new Array();
    //var defOver = '#993333', defBack = '#999966', defBorder = '#000000', defBase = null;
    var defOver = '#b0c4de', defBack = '#b0c4de', defBorder = '#000000', defBase = '#b0c4de';
    var defHeight = 22;
    menu[0] = new Array();
    menu[0][0] = new Menu('rootMenu', 0, 0, 130, '#b0c4de', defBase, defBorder);
    menu[0][1] = new Item('Home','../mainmenu.aspx', defHeight, 1);
    menu[0][2] = new Item('Logout','./logout.aspx', defHeight, 2);
    menu[0][3] = new Item('Leader Profile','#', defHeight, 3);
    menu[0][4] = new Item('View Schedule','#', defHeight, 4);
    menu[0][5] = new Item('Leader House Bed Booking','#', 52, 5);
    menu[0][6] = new Item('Payroll Info','#', defHeight, 6);
    menu[0][7] = new Item('Employee Handbooks', '#', defHeight, 9);


    menu[1] = new Array();
    menu[1][0] = new Menu('homeMenu', 0, 22, 130, defOver, defBack, defBorder);

    menu[2] = new Array();
    menu[2][0] = new Menu('logoutMenu', 0, 22, 130, defOver, defBack, defBorder);

    menu[3] = new Array();
    menu[3][0] = new Menu('profileMenu', 0, 22, 145, defOver, defBack, defBorder);
    menu[3][1] = new Item('Name and Address','./LeaderProfile.aspx', defHeight, 0);
    menu[3][2] = new Item('Leader Certifications','/LeaderCertifications.aspx', defHeight, 0);
    menu[3][3] = new Item('Availability','/LeaderAvailability.aspx', defHeight, 0);
    menu[3][4] = new Item('Schedule Preferences','#', 35, 6);
    menu[3][5] = new Item('Training','/LeaderTraining.aspx', defHeight, 0);
    menu[3][6] = new Item('Portfolio','#', defHeight, 7);
    menu[3][7] = new Item('Global Travel Preferences','/LeaderTravelProfile.aspx', defHeight, 0);


    menu[4] = new Array();
    menu[4][0] = new Menu('scheduleMenu', 0, 22, 130, defOver, defBack, defBorder);
    menu[4][1] = new Item('Leader Schedule','/ViewLeaderSchedule.aspx', defHeight, 0);
    menu[4][2] = new Item('Trip Schedule','/ViewTripSchedule.aspx', defHeight, 0);
    menu[4][3] = new Item('Unit Schedule','/ViewUnitSchedule.aspx', defHeight, 0);
    menu[4][4] = new Item('Area Schedule','/ViewAreaSchedule.aspx', defHeight, 0);

    menu[5] = new Array();
    menu[5][0] = new Menu('bedBookingMenu', 0, 38, 145, defOver, defBack, defBorder);
    menu[5][1] = new Item('Bed Booking Schedule', 'Default.aspx', defHeight, 0);
    menu[5][2] = new Item('Leader House', 'LeaderHouse.aspx', defHeight, 0);
    //menu[5][1] = new Item('', '', defHeight, 0);
    //menu[5][1] = new Item('', '', defHeight, 0);


    menu[6] = new Array();
    menu[6][0] = new Menu('payrollMenu', 0, 22, 130, defOver, defBack, defBorder);
    menu[6][1] = new Item('Current Payroll','/PayrollCurrent.aspx', defHeight, 0);
    menu[6][2] = new Item('Past Payroll','/PayrollPast.aspx', defHeight, 0);
<% if (Session["ATLAS_PayStub_Available"] != null){%>
    menu[6][3] = new Item('Pay Stubs','/PayStubs.aspx', defHeight, 0);
    menu[6][4] = new Item('ATLAS Pay Sheets','/PaySheet.aspx', defHeight, 0);
    <% } %>
<% if (Session["ATLAS_PaySheet_Can"] != null) { %>
    menu[6][3] = new Item('ATLAS Pay Sheets', '/PaySheetCan.aspx', defHeight, 0);
<% } %>

    menu[7] = new Array();
    // This is across but not down... a horizontal popout (with crazy colours :)...
    menu[7][0] = new Menu('preferenceMenu', 145, 0, 110, defOver, defBack, defBorder);
    menu[7][1] = new Item('Area','/LeaderAreaPreference.aspx', defHeight, 0);
    menu[7][2] = new Item('Co-Leader','/LeaderPersonPreference.aspx', defHeight, 0);
    menu[7][3] = new Item('Amount of Work','/LeaderPreferenceAmountOfWork.aspx', defHeight, 0);
    menu[7][4] = new Item('Scheduling Preference Summary','/Scheduling.aspx', defHeight, 0);


    menu[8] = new Array();
    menu[8][0] = new Menu('portfolioMenu', 145, 0, 110, defOver, defBack, defBorder);
    menu[8][1] = new Item('Activity','/LPActivity.aspx', defHeight, 0);
    menu[8][2] = new Item('Travel','/LPTravel.aspx', defHeight, 0);
    menu[8][3] = new Item('Other Experience','/LPOtherExperience.aspx', defHeight, 0);

    menu[9] = new Array();
    menu[9][0] = new Menu('EmployeeHandbookMenu', 0, 22, 130, defOver, defBack, defBorder);


    // this is what actually displays the menu
    // startDL(id, x, y, width, height, vis, back, border, zIndex, extraProps) 
    newRoot = startDL('rootMenu', 35, 100, 680, 15, 'hidden', defBase, null, 100, '');

    newRoot += startDL('rootMenu1', 35, 1, 115, 15, 'inherit', defBase, null, 100, mouseProps(0, 1));
    newRoot += '<span class="Item"> <a href="/mainmenu.aspx">Home</a></span>' + endDL;

    newRoot += startDL('rootMenu2', 155, 1, 115, 15, 'inherit', defBase, null, 100, mouseProps(0, 2));
    newRoot += '<span class="Item">  <a href="/logout.aspx">Logout</a></span>' + endDL;

    newRoot += startDL('rootMenu3', 265, 1, 115, 15, 'inherit', defBase, null, 100, mouseProps(0, 3));
    newRoot += '<span class="Item">  Leader Profile</span>' + endDL;

    newRoot += startDL('rootMenu4', 375, 1, 115, 15, 'inherit', defBase, null, 100, mouseProps(0, 4));
    newRoot += '<span class="Item">  View Schedule</span>' + endDL;

      newRoot += startDL('rootMenu5', 485, 1, 115, 15, 'inherit', defBase, null, 100, mouseProps(0, 5));
      newRoot += '<span class="Item"> Leader House Bed Booking</span>' + endDL;

   newRoot += startDL('rootMenu6', 625, 1, 115, 15, 'inherit', defBase, null, 100, mouseProps(0, 6));
    newRoot += '<span class="Item">  Payroll Info</span>' + endDL;


   //newRoot += startDL('rootMenu8', 595, 1, 115, 15, 'inherit', defBase, null, 100, '');
    newRoot += startDL('rootMenu9', 770, 1, 215, 15, 'inherit', defBase, null, 100, '');
    newRoot += '<span class="Item"> <a href="EmployeeHandbook.aspx">Employee Handbook</a></span>' + endDL;



    newRoot += endDL;

    writeMenus(newRoot, '>');


    if (isNS4) document.captureEvents(Event.CLICK);
    document.onclick = clickHandle;

    function clickHandle(evt) {
        if (isNS4) document.routeEvent(evt);
        hideAllBut(0);
    }

    eval(docObj + menu[0][0].id + styObj + '.visibility = "visible"');

    function moveRoot() {
        rM = eval(docObj + menu[0][0].id + styObj);
        if (parseInt(rM.top) < 110)
            rM.top = 110;
        else
            rM.top = 0;
    }
</script>
