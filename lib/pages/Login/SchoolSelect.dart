import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:acadamicConnect/pages/Home.dart';
import 'package:flutter/material.dart';

class SelectSchoolPage extends StatefulWidget {
  SelectSchoolPage({Key key}) : super(key: key);

  _SelectSchoolPageState createState() => _SelectSchoolPageState();
}

class _SelectSchoolPageState extends State<SelectSchoolPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
        title: 'Select School',
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, i) => Card(
                elevation: 3,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 60,
                  onPressed: () {
                    kopenPage(context, Home());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        null,
                        size: 40,
                        color: Colors.redAccent,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'School Name $i',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '(Area Name $i)',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 50,
                      )
                    ],
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
