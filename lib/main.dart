import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_to_do_list/models/event.dart';
import 'package:flutter_app_to_do_list/screens/add_event.dart';
import 'package:flutter_app_to_do_list/screens/profile_page.dart';
import 'package:flutter_app_to_do_list/services/db_service.dart';
import 'package:flutter_app_to_do_list/styleguide/colors.dart';
import 'package:flutter_app_to_do_list/utils/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _calendarController;
  TextEditingController _eventController;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  SharedPreferences prefs;
  DbService dbService;
  DatabaseHelper databaseHelper;
  bool valueFromAddEvent = false;
  bool control = false;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    dbService = DbService();
    databaseHelper = DatabaseHelper();
  }

  Map<DateTime, List<dynamic>> _fromModelToEvent(List<EventModel> events) {
    Map<DateTime, List<dynamic>> data = {};
    events.forEach((event) {
      DateTime date = DateTime(
          event.eventDate.year, event.eventDate.month, event.eventDate.day, 12);
      if (data[date] == null) data[date] = [];
      data[date].add(event);
    });
    return data;
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });

    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  _awaitReturnValueFromAddEvent() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddEvent(),
        ));
    setState(() {
      control = true;
    });
  }

  _awaitReturnValueFromAddEventForUpdate(EventModel event) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddEvent(
            event: event,
          ),
        ));

    setState(() {
      valueFromAddEvent = result;
      if (valueFromAddEvent) {
        _reloadPage();
      }
    });
  }

  _reloadPage() async {
    print("reload");
    await new Future.delayed(const Duration(milliseconds: 0));
    Navigator.of(context, rootNavigator: false).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => HomePage(),
          transitionDuration: Duration(seconds: 0),
        ),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<EventModel>>(
          // future: dbService.getEvents(),
          future: databaseHelper.getTaskList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<EventModel> allEvents = snapshot.data;
              if (allEvents.isNotEmpty) {
                _events = _fromModelToEvent(allEvents);
              }
            }
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [whiteColor,tealColor,]
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 35),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 8,
                            alignment: Alignment.topCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Yaş : 27",
                                  style:
                                      TextStyle(fontSize: 18, color: tealColor),
                                ),
                                Text(
                                  "Firma : X firması",
                                  style:
                                      TextStyle(fontSize: 18, color: tealColor),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 18,
                            width: MediaQuery.of(context).size.width,
                            color: tealColor,
                            alignment: Alignment.center,
                            child: Text(
                              "Oğuzhan KAYA",
                              style: TextStyle(color: whiteColor, fontSize: 24),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                            },
                            child: Hero(
                              tag: "assets/images/photo.jpeg",
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: CircleAvatar(
                                    radius: 44,
                                    backgroundColor: tealColor,
                                    child: CircleAvatar(
                                      minRadius: 30,
                                      maxRadius: 40,
                                      backgroundImage:
                                          AssetImage("assets/images/photo.jpeg"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text("Takvim",
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TableCalendar(
                        events: _events,
                        initialCalendarFormat: CalendarFormat.month,
                        calendarStyle: CalendarStyle(
                          todayColor: Theme.of(context).primaryColor,
                          selectedColor: Theme.of(context).primaryColor,
                          todayStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: whiteColor),
                          weekendStyle:
                              TextStyle(color: blackColor.withOpacity(0.3)),
                          outsideDaysVisible: false,
                        ),
                        headerStyle: HeaderStyle(
                            centerHeaderTitle: true,
                            formatButtonDecoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            formatButtonTextStyle: TextStyle(color: whiteColor),
                            formatButtonShowsNext: false),
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(
                                color: blackColor, fontWeight: FontWeight.bold),
                            weekendStyle: TextStyle(
                                color: blackColor,
                                fontWeight: FontWeight.bold)),
                        onDaySelected: (data, events, _) {
                          setState(() {
                            _selectedEvents = events;
                          });
                        },
                        builders: CalendarBuilders(
                            selectedDayBuilder: (context, date, events) =>
                                Container(
                                    margin: EdgeInsets.all(4),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle),
                                    child: Text(
                                      date.day.toString(),
                                      style: TextStyle(color: whiteColor),
                                    )),
                            todayDayBuilder: (context, date, events) =>
                                Container(
                                    margin: EdgeInsets.all(4),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: tealColor,
                                        shape: BoxShape.circle),
                                    child: Text(
                                      date.day.toString(),
                                      style: TextStyle(color: whiteColor),
                                    ))),
                        calendarController: _calendarController,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(75),
                              topRight: Radius.circular(75))),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.08,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Görevler',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: blackColor),
                      ),
                    ),
                    ..._selectedEvents.map(
                      (event) => Container(
                        color: whiteColor,
                        height: MediaQuery.of(context).size.height * 0.12,
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                child: Text(
                              event.time.format(context),
                              // event.time.toString(),
                              style: TextStyle(fontSize: 16, color: blackColor),
                            )),
                            GestureDetector(
                              onTap: () {
                                _awaitReturnValueFromAddEventForUpdate(event);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                padding: EdgeInsets.all(15),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    color: tealColor,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0, 2),
                                          blurRadius: 2.0)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(
                                        event.title,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: blackColor, fontSize: 12),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(
                                        event.description,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: blackColor, fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              _awaitReturnValueFromAddEvent();
            });
          }),
    );
  }
}
