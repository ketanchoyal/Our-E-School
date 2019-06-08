import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/constants.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: 'Profile',
        child: kBackBtn,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Image(
                    height: 160,
                    width: 160,
                    image: NetworkImage(
                        "https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png"),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Container(
                    height: 40,
                    width: 50,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.edit,
                        size: 25
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
