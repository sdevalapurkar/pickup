
Canvas.backgroundColor = "#FCAB53"

Screen.backgroundColor = "#2F80ED"

homepageScreen = new Layer
	name: "homepageScreen"
	visible: true

eventListScreen = new Layer
	name: "eventListScreen"
	visible: false

showEventScreen = new Layer
	name: "showEventScreen"
	visible: false

otherUserProfile = new Layer
	name: "otherUserProfile"
	visible: false
	
myUserProfile = new Layer
	name: "myUserProfile"
	visible: false
	
addEvent = new Layer
	name: "addEvent"
	visible: false

currentScreen = homepageScreen
previousScreen = homepageScreen


switchScreen = (input) ->
	currentScreen.visible = false
	if input == "eventListScreen"
		currentScreen = eventListScreen
	if input == "homepageScreen"
		currentScreen = homepageScreen
	if input == "showEventScreen"
		currentScreen = showEventScreen
	if input == "otherUserProfile"
		currentScreen = otherUserProfile
	if input == "myUserProfile"
		currentScreen = myUserProfile
	if input == "addEvent"
		currentScreen = addEvent
	currentScreen.visible = true


###  --- HOME PAGE SCREEN --- ###
toBasketball = new Layer
	parent: homepageScreen
	opacity: 0
	y: 292
	height:905
	width: 750

toBasketball.on Events.Tap, ->
	switchScreen("eventListScreen")


Category = new Layer
	parent: homepageScreen
	width: 750
	height: 1336
	image: "images/Category.png"

###  ###################  ###
header = new Layer
	y:0
	width: 750
	height: 110
	image: "images/header.png"

back_button = new Layer
	parent: header
	width: 108
	height: 108
	image: "images/Group.png"

back_button.on Events.Tap, ->
	if currentScreen.name == "eventListScreen"
		switchScreen ( "homepageScreen")
	if currentScreen.name == "showEventScreen"
		switchScreen ( "eventListScreen" ) 
	if currentScreen.name == "otherUserProfile"
		switchScreen ("showEventScreen")
	if currentScreen.name == "myUserProfile"
		switchScreen ( previousScreen.name )
	if currentScreen.name == "addEvent"
		switchScreen ( "eventListScreen" ) 
		
account_button = new Layer
	opacity:0 
	x: 640
	width: 110
	height: 110

account_button.on Events.Tap, ->
	previousScreen = currentScreen
	switchScreen ( "myUserProfile")

###  DATE SLIDER ###
dateSlider = new Layer
	parent: eventListScreen
	x: 0
	y: 108
	height: 201
	width: 2000
	backgroundColor: "#012B4B"

date = [] 
clicked = []
currentClicked = 7


for i in [7..20]
	date[i] = new Layer
		parent: dateSlider
		name: "date_" + i
		image: "images/date_" + i + ".png"
		x: 108 * (i-7)
		width: 100

	if i==7 or i==10 or i==11 or i == 15
		clicked[i] = new Layer
			parent: dateSlider
			name: "date_" + i
			image: "images/date_clicked_" + i + ".png"
			x: 108 * (i-7)
			width: 100
			z: -1
		clicked[i].states.add
			clicked:
				name: "date_" + i
				image: "images/date_clicked_" + i + ".png"
				x: 108 * (i-7)
				width: 100
				height:201
				z: 1
				
				

clicked[7].states.switch("clicked")

date[7].on Events.Click, ->
	if ( clicked[7].states.current == "default")
		clicked[7].states.switch("clicked")
		clicked[currentClicked].states.switch ("default")
		eventList.scrollToPoint(
    		x: 200, y: 0
    		true
    		curve: "ease"
		)
		currentClicked = 7

date[10].on Events.Click, ->
	if ( clicked[10].states.current == "default")
		clicked[10].states.switch("clicked")
		clicked[currentClicked].states.switch ("default")
		eventList.scrollToPoint(
    		x: 200, y: 790
    		true
    		curve: "ease"
		)
		currentClicked = 10
	
date[11].on Events.Click, ->
	if ( clicked[11].states.current == "default")
		clicked[11].states.switch("clicked")
		clicked[currentClicked].states.switch ("default")
		currentClicked = 11
		
date[15].on Events.Click, ->
	if ( clicked[15].states.current == "default")
		clicked[15].states.switch("clicked")
		clicked[currentClicked].states.switch ("default")
		currentClicked = 15

dateSlider.states.add
	nextWeek:
		x: -750

dateSlider.on Events.SwipeLeftStart, ->
	if ( dateSlider.states.current == "default" )
		dateSlider.states.switch ("nextWeek")
		
dateSlider.on Events.SwipeRightStart, ->
	if ( dateSlider.states.current == "nextWeek")
		dateSlider.states.switch ("default")





### Event List  ###
eventList = new ScrollComponent
	parent: eventListScreen
	backgroundColor: "#EAEAEA"
	y: 309
	width: 750
	height: 1050
	scrollHorizontal: false


eventList.contentInset = 
	top: 0
	bottom: 0


list_date_7 = new Layer
	parent: eventList.content
	width: 280
	height: 34
	x: 50
	y: 50
	image: "images/list_date_7.png"


event = []
for i in [0..3]
	event[i] = new Layer
		name: "event" + i
		parent: eventList.content
		width: 750
		height: 166
		y: 120 + 169 * i
		image: "images/event.png"
		
list_date_10 = new Layer
	parent: eventList.content
	width: 320
	height: 34
	x: 50
	y: 840
	image: "images/list_date_10.png"
	
	
sevent = []
for i in [0..8]
	sevent[i] = new Layer
		parent: eventList.content
		width: 750
		height: 166
		y: 920 + 169 * i
		image: "images/event.png"
		
		
		
eventList.on Events.Move,  ->
	if eventList.scrollY > 790 and clicked[10].states.current == "default"
		clicked[10].states.switch("clicked")
		clicked[currentClicked].states.switch ("default")
		currentClicked = 10
	if eventList.scrollY < 690 and clicked[7].states.current == "default"
		clicked[7].states.switch("clicked")
		clicked[currentClicked].states.switch ("default")
		currentClicked = 7


sevent[0].on Events.Tap, ->
	switchScreen ("showEventScreen")


add_buttonA = new Layer
	parent: eventListScreen
	x: 560
	y: 1150
	width: 140
	height: 140
	image: "images/add_button.png"

add_buttonA.on Events.Tap, ->
	switchScreen ("addEvent")

### ######################################### ###


showEvent = new Layer
	parent: showEventScreen
	y: 110
	width: 750
	height: 1228
	image: "images/showEvent.png"

goToOtherProfile = new Layer
	parent: showEventScreen
	opacity: 0
	width: 750
	y: 784
	height: 149


joinEvent = new Layer
	parent: showEventScreen
	opacity: 0
	y: 1220
	width: 750
	height: 114

EventJoined = new Layer
	backgroundColor: "#222"
	opacity: 0
	x: 120
	y: 452
	height: 332
	width: 510
	borderRadius: 8
EventJoined.states.add
	active:
		opacity: 0.9

checked = new Layer
	parent: EventJoined
	image: "images/checked.svg"
	x: 174
	y: 67
	height: 162
	width: 162


showEventScreen.states.add
	blur:
		blur: 6
	notblur:
		blur: 0

clickToExitFeedback = new Layer
	parent: showEventScreen
	z:5
	opacity: 0
	visible: false
	height: 1224
	width: 750
	y: 110


clickToExitFeedback.on Events.Tap, ->
	showEventScreen.states.switch ( "notblur")
	EventJoined.states.switch ( "default" )
	clickToExitFeedback.visible = false


joinEvent.on Events.Tap, ->
	showEventScreen.states.switch ( "blur")
	EventJoined.states.switch ( "active" )
	clickToExitFeedback.visible = true


goToOtherProfile.on Events.Tap, ->
	switchScreen ( "otherUserProfile")
	
	
otherProfile = new Layer
	parent: otherUserProfile
	y: 110
	width: 750
	height: 282
	image: "images/other_user.png"
	
otherProfileLine = new Layer
	parent: otherUserProfile
	x: 45
	backgroundColor: "#2F80ED"
	y: 382
	height: 8
	width: 260

otherProfileLine.states.add
	report_user:
		x: 430

otherProfileEvents = new Layer
	parent: otherUserProfile
	y:390
	width: 750
	height: 950
	image: "images/Group(1).png"
otherProfileEvents.states.add
	inactive:
		x: -750
otherUserReport = new Layer
	parent: otherUserProfile
	y: 390
	x: 750
	width: 752
	height: 952
	image: "images/otherUserReport.png"

otherUserReport.states.add
	active:
		x:0
	
otherProfileEvents.on Events.SwipeLeft, ->
	otherProfileLine.states.switch ("report_user")
	otherProfileEvents.states.switch ( "inactive")
	otherUserReport.states.switch ( "active")
otherUserReport.on Events.SwipeRight, ->
	otherProfileLine.states.switch ("default")
	otherProfileEvents.states.switch ( "default")
	otherUserReport.states.switch ( "default")
	
OtherProfileEventButton = new Layer
	parent: otherUserProfile
	opacity:0
	y: 292
	width: 350
	height: 98

OtherProfileEventButton.on Events.Tap, ->
	otherProfileLine.states.switch ("default")
	otherProfileEvents.states.switch ( "default")
	otherUserReport.states.switch ( "default")

OtherProfileReportButton = new Layer
	parent: otherUserProfile
	opacity:0
	y: 292
	x: 390
	width: 359
	height: 98
	
OtherProfileReportButton.on Events.Tap, ->
	otherProfileLine.states.switch ("report_user")
	otherProfileEvents.states.switch ( "inactive")
	otherUserReport.states.switch ( "active")

### --------------- ###


my_profile = new Layer
	parent: myUserProfile
	y: 110
	width: 750
	height: 280
	image: "images/my_profile.png"


my_event = new Layer
	parent: myUserProfile
	width: 750
	height: 950
	image: "images/my_event.png"
	y: 390
	x: 0
my_event.states.add
	inactive:
		x: -750

my_setting = new Layer
	parent: myUserProfile
	y: 390
	x: 745
	width: 750
	height: 950
	image: "images/my_setting.png"
my_setting.states.add
	active:
		x: 0
	toleft:
		x:-750



my_map = new Layer
	parent: myUserProfile
	y: 390
	x: 750
	width: 750
	height: 950
	image: "images/my_map.png"
my_map.states.add
	active:
		x: 0

myEventButton = new Layer
	parent: myUserProfile
	opacity: 0
	y: 292
	width: 216
	height: 98
mySettingButton = new Layer
	parent: myUserProfile
	opacity: 0
	y: 292
	x:262
	width: 216
	height: 98
myLocationButton = new Layer
	parent: myUserProfile
	opacity: 0
	y: 292
	x:519
	width: 216
	height: 98

mySettingButton.on Events.Tap, ->
	myProfileLine.states.switch ("setting")
	my_setting.states.switch ( "active")
	my_event.states.switch ("inactive")
	my_map.states.switch ("default")

myEventButton.on Events.Tap, ->
	myProfileLine.states.switch ("default")
	my_setting.states.switch ( "default")
	my_event.states.switch ("default")
	
myLocationButton.on Events.Tap, ->
	myProfileLine.states.switch ("location")
	my_setting.states.switch ("toleft")
	my_map.states.switch ("active")


myProfileLine = new Layer
	parent: myUserProfile
	x: 0
	backgroundColor: "#2F80ED"
	y: 382
	height: 8
	width: 240

myProfileLine.states.add
	setting:
		x: 260
	location:
		x: 500
		

add_event = new Layer
	parent: addEvent
	y:110
	width: 750
	height: 1228
	image: "images/add_event.png"





# The buttton



addEventButton = new Layer
	parent: addEvent
	opacity: 0
	y: 1220
	width: 750
	height: 114

addEventButton.on Events.Tap, ->
	addEvent.states.switch ( "blur")
	EventJoined.states.switch ( "active" )
	clickToExitFeedback2.visible = true

addEvent.states.add
	blur:
		blur: 6
	notblur:
		blur: 0

clickToExitFeedback2 = new Layer
    parent: addEvent
    visible: false
    y: 108
    width: 750
    height: 1226
    opacity: 0
	z:5


clickToExitFeedback2.on Events.Tap, ->
	addEvent.states.switch ( "notblur")
	EventJoined.states.switch ( "default" )
	clickToExitFeedback2.visible = false
	
	
	

reportUserButton = new Layer
	parent: otherUserReport
	opacity: 0
	y: 839
	width: 750
	height: 105
	x: -5

reportUserButton.on Events.Tap, ->
	otherUserReport.states.switch ( "blur")
	EventJoined.states.switch ( "active" )
	clickToExitFeedback3.visible = true

otherUserReport.states.add
	blur:
		blur: 6
	notblur:
		blur: 0

clickToExitFeedback3 = new Layer
    parent: otherUserReport
    visible: false
    y: 108
    width: 750
    height: 933
    opacity: 0
	z:5


clickToExitFeedback3.on Events.Tap, ->
	otherUserReport.states.switch ( "notblur")
	EventJoined.states.switch ( "default" )
	clickToExitFeedback3.visible = false


goToEventToReport = new Layer
	parent: myUserProfile
	opacity: 0
	y: 728
	width: 750
	height: 171

goToEventToReport.on Events.Tap, ->
	switchScreen ( "showEventScreen" )






