import 'package:flutter/material.dart';

class DayTitleWidget extends StatefulWidget {
  final DateTime? dateTime;
  DayTitleWidget({
    Key? key,
    this.dateTime,
  }) : super(key: key);

  @override
  State<DayTitleWidget> createState() => _DayTitleWidgetState();
}

class _DayTitleWidgetState extends State<DayTitleWidget> {
  List<String>? daysOfWeek;
  Map<String, dynamic> mapDate = {};
  int? selectedDate;
  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now().day;
    daysOfWeek = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    datesOfWeek(widget.dateTime);
  }

  void datesOfWeek(DateTime? dataTime) {
    int firstDayOfWeek = widget.dateTime!
        .subtract(Duration(days: widget.dateTime!.weekday - 1))
        .day;
    int lastDayOfWeek = widget.dateTime!
        .add(Duration(days: DateTime.daysPerWeek - widget.dateTime!.weekday))
        .day;
    List<int> datesOfWeek = [];
    int x = 0;
    for (int i = firstDayOfWeek; i <= lastDayOfWeek; ++i) {
      datesOfWeek.add(firstDayOfWeek);
      mapDate[daysOfWeek![x].toString()] = i;
      x++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 70,
        child: Row(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.20,
            child: const Center(
              child: Icon(
                Icons.today_outlined,
                size: 40,
              ),
            ),
          ),
          ListView.builder(
              padding: const EdgeInsets.all(0),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: mapDate.keys.length,
              itemExtent: 40,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    children: [
                      Text(
                          mapDate.keys
                              .toList()[index]
                              .toString()
                              .substring(0, 1),
                          style: const TextStyle(fontSize: 16)),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: InkWell(
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: (selectedDate ==
                                          mapDate.values.toList()[index])
                                      ? Colors.green.shade600
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(40)),
                              child: Center(
                                child: Text(
                                  mapDate.values.toList()[index].toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: (selectedDate ==
                                            mapDate.values.toList()[index])
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              )),
                          onTap: () {
                            setState(() {
                              selectedDate = mapDate.values.toList()[index];
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ]),
      ),
    );
  }
}
