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
                      image: registerd
                          ? NetworkImage(user.photoUrl)
                          : AssetImage(assetsString.no_image_available),
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
                        registerd ? user.standard + '-' + user.division : user.id,
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
}
