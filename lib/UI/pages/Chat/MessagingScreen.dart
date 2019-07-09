import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:flutter/material.dart';

class MessagingScreen extends StatefulWidget {
  MessagingScreen({Key key}) : super(key: key);

  _MessagingScreenState createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: TopBar(
          title: 'Teacher 1',
          child: kBackBtn,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(32),
                          ),
                        ),
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: 150,
                            // maxWidth: MediaQuery.of(context).size.width - 66,
                          ),
                          // width: MediaQuery.of(context).size.width - 65,
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            // maxLength: 1000,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Type here....',
                              hintStyle: TextStyle(
                                height: 1.5,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Card(
                      elevation: 5,
                      shape: kCardCircularShape,
                      child: Container(
                        width: 50,
                        height: 50,
                        child: MaterialButton(
                          height: 40,
                          shape: kCardCircularShape,
                          onPressed: () {},
                          child: Icon(
                            Icons.send,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
