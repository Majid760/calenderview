import 'package:calendar_view/calendar_view.dart';
import 'package:calenderview/constants.dart';
import 'package:calenderview/widgets/day_titile_widget.dart';
import 'package:calenderview/widgets/popup_widget.dart';
import 'package:flutter/material.dart';

class CalenderScreen extends StatefulWidget {
  final GlobalKey<MonthViewState>? monthState;
  final GlobalKey<DayViewState>? dayState;

  const CalenderScreen({Key? key, this.monthState, this.dayState})
      : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  var items = [
    'Day',
    'Weekly',
    'Monthly',
  ];
  // Initial Selected Value
  String dropdownvalue = 'Day';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: DropdownButton(
          // Initial Value
          value: dropdownvalue,
          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),
          // Array list of items
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
            });
          },
        )),
        body: viewBuilder()
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.add),
        //   elevation: 8,
        //   onPressed: _addEvent(context),
        // ),
        );
  }

  // _addEvent(context) async {
  // final event = await context.pushRoute<CalendarEventData>();
  // if (event == null) return;
  // CalendarControllerProvider.of(context).controller.add(event);
  // }

  Widget viewBuilder() {
    switch (dropdownvalue) {
      case 'Day':
        return DayView(
          key: widget.dayState,
          // hourIndicatorSettings:
          // const HourIndicatorSettings(color: Colors.red,),
          controller: CalendarControllerProvider.of(context).controller,
          verticalLineOffset: 20,
          // timeLineOffset: 5,
          liveTimeIndicatorSettings:
              const HourIndicatorSettings(offset: 10, color: Colors.green),

          // timeLineBuilder: (date) => ,
          dayTitleBuilder: (date) {
            return DayTitleWidget(
              dateTime: date,
            );
          },
          // eventArranger: EventArranger(),
          // backgroundColor: Colors.amber,
          eventTileBuilder: (date, events, boundry, start, end) {
            // Return your widget to display as event tile.
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, item) => InkWell(
                child: Container(
                    width: double.infinity,
                    height: 0.7 * Constants.minutePerHour * Constants.hoursADay,
                    decoration: BoxDecoration(color: events[item].color),
                    child: ListTile(
                      subtitle: Text(events[item].title,
                          style: const TextStyle(color: Colors.white)),
                      // subtitle: Text(
                      //   events[item].description,
                      //   style: const TextStyle(color: Colors.white),
                      // ),
                      title: Row(
                        // mainAxisAlignment: MainAxisAlignment.sp,
                        children: [
                          Text(
                              '${events[item].startTime!.hour}'
                              ':'
                              '${events[item].startTime!.minute} ',
                              style: const TextStyle(color: Colors.white)),
                          Text(
                              '${events[item].endTime!.hour}'
                              ':'
                              '${events[item].endTime!.minute}',
                              style: const TextStyle(color: Colors.white))
                        ],
                      ),
                    )),
                onTap: () {
                  showAlertDialog(context, events[item]);
                },
              ),
            );
          },
          showVerticalLine: true, // To display live time line in day view.
          showLiveTimeLineInAllDays:
              true, // To display live time line in all pages in day view.
          heightPerMinute: 0.7, // height occupied by 1 minute time span.
          // eventArranger:
          //     SideEventArranger(), // To define how simultaneous events will be arranged.
          onEventTap: (events, date) => print(events),
        );
      case 'Weekly':
        return WeekView(
          controller: CalendarControllerProvider.of(context).controller,
          eventTileBuilder: (date, events, boundry, start, end) {
            // Return your widget to display as event tile.
            return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, item) => InkWell(
                      onTap: () {
                        showAlertDialog(context, events[item]);
                      },
                      child: Container(
                          height: 1.0 *
                              Constants.minutePerHour *
                              Constants.hoursADay,
                          decoration: BoxDecoration(color: events[item].color),
                          child: Text(events[item].title)),
                    ));
          },
          liveTimeIndicatorSettings:
              const HourIndicatorSettings(color: Colors.green),
          showLiveTimeLineInAllDays:
              true, // To display live time line in all pages in week view.

          heightPerMinute: 1, // height occupied by 1 minute time span.
          // eventArranger:
          //     SideEventArranger(), // To define how simultaneous events will be arranged.
          onEventTap: (events, date) => debugPrint(events.toString()),
        );

      case 'Monthly':
        return MonthView(
          controller: CalendarControllerProvider.of(context).controller,
          // key: widget.state,
          cellBuilder: (date, events, isToday, isInMonth) {
            // Return your widget to display as month cell.
            return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, item) => InkWell(
                    child: Container(
                        decoration: BoxDecoration(color: events[item].color),
                        child: Text(events[item].title)),
                    onTap: () {
                      showAlertDialog(context, events[item]);
                    }));
          },
        );

      default:
        return MonthView(
          controller: CalendarControllerProvider.of(context).controller,
          // key: widget.state,
          cellBuilder: (date, events, isToday, isInMonth) {
            // Return your widget to display as month cell.
            return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, item) => Column(
                      children: [
                        Text(events[item].date.toString()),
                        Container(
                            decoration: const BoxDecoration(color: Colors.red),
                            child: Text(events[item].title)),
                      ],
                    ));
          },
        );
    }
  }
}
