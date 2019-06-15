import 'package:flutter/material.dart';

class TimeTable extends StatefulWidget {
  final Color color;

  TimeTable({this.color});

  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) => buildListTile(index),
      ),
    ));
  }

  Card buildListTile(int index) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              "Subject $index",
              style: TextStyle(fontWeight: FontWeight.bold
                  // fontFamily: 'Ninto',
                  ),
            ),
            subtitle: Text(
              "Teacher $index",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Divider(
            height: 2,
            indent: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25,top: 5),
            child: Text(
              "Time $index",
              style: TextStyle(fontWeight: FontWeight.bold
                  // fontFamily: 'Ninto',
                  ),
            ),
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
