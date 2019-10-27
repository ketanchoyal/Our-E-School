import 'package:flutter/material.dart';

class TeachersTimeTable extends StatefulWidget {
  final Color color;
  final bool edit;

  TeachersTimeTable({this.color, this.edit = false});

  _TeachersTimeTableState createState() => _TeachersTimeTableState();
}

class _TeachersTimeTableState extends State<TeachersTimeTable> {
  bool edit = false;
  @override
  Widget build(BuildContext context) {
    edit = widget.edit;
    return Scaffold(
      backgroundColor: widget.color ?? Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) => buildListTile(index),
        ),
      ),
    );
  }

  Card buildListTile(int index) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          ListTile(
            title: !edit
                ? Text(
                    'Lecture ${index + 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : TextField(
                    maxLines: 1,
                    expands: false,
                    controller: TextEditingController(text: 'Subject name'),
                    enableInteractiveSelection: true,
                    keyboardType: TextInputType.text,
                    autocorrect: true,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Lecture ${index + 1}',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            onLongPress: () {
              edit = !edit;
              setState(() {});
            },
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 6,
                ),
                !edit
                    ? Text(
                        "Standard ${index + 1}A",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    : TextField(
                        maxLines: 1,
                        expands: false,
                        controller: TextEditingController(text: 'Standard'),
                        enableInteractiveSelection: true,
                        keyboardType: TextInputType.text,
                        autocorrect: true,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelText: 'Standard + Div',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          ),
          Divider(
            height: 2,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: !edit ? 25 : 15, top: 5, right: !edit ? 25 : 15),
            child: !edit
                ? Text(
                    "$index:00 A.M  to  ${index + 1}:30 A.M",
                    style: TextStyle(fontWeight: FontWeight.bold
                        // fontFamily: 'Ninto',
                        ),
                  )
                : Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          maxLines: 1,
                          expands: false,
                          controller:
                              TextEditingController(text: '$index:00 A.M'),
                          enableInteractiveSelection: true,
                          keyboardType: TextInputType.datetime,
                          autocorrect: true,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: 'Start time',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        " to ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          maxLines: 1,
                          expands: false,
                          controller: TextEditingController(
                              text: '${index + 1}:30 A.M'),
                          enableInteractiveSelection: true,
                          keyboardType: TextInputType.datetime,
                          autocorrect: true,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: 'End time',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          SizedBox(
            height: 5,
          ),
          edit
              ? FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
