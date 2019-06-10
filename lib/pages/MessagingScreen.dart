import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/constants.dart';
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
          body: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.blue,
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ],
          )),
    );
  }
}
