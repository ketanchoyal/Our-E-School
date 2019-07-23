import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/core/Models/User.dart';

class ChildrenGridViewCard extends StatelessWidget {
  final User user;
  final Function onTap;

  ChildrenGridViewCard({
    this.onTap,
    @required this.user,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool registerd = user.firebaseUuid == '' ? false : true;
    return InkWell(
      enableFeedback: true,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(2),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          elevation: 5,
          child: Stack(
            children: <Widget>[
              Hero(
                tag: user.firebaseUuid,
                transitionOnUserGestures: true,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                    image: DecorationImage(
                      image: setImage(user),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: new BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        registerd ? user.displayName : "Not Registered Yet",
                        textAlign: TextAlign.center,
                        style: ktitleStyle.copyWith(color: Colors.white),
                      ),
                      Text(
                        registerd
                            ? user.standard + '-' + user.division
                            : user.id,
                        textAlign: TextAlign.center,
                        style: ksubtitleStyle.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider<dynamic> setImage(User user) {
    if (user.photoUrl.contains('https')) {
      return NetworkImage(user.photoUrl);
    } else {
      return NetworkImage(
        "https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png",
      );
    }
  }
}
