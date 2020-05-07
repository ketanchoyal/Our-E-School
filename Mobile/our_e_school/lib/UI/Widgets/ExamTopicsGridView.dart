import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/core/Models/ExamTopic.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';

class ExamTopicsGridView extends StatelessWidget {
  final ExamTopic examTopic;
  final Function onTap;

  ExamTopicsGridView({
    this.onTap,
    @required this.examTopic,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: ClipRect(
            child: Banner(
              color: Theme.of(context).primaryColor,
              location: BannerLocation.topStart,
              message: examTopic.topicIsForStandard,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          new BorderRadius.all(Radius.circular(10.0)),
                      image: DecorationImage(
                        image: AssetImage(assetsString.no_image_available),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: new BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            examTopic.topicName,
                            textAlign: TextAlign.center,
                            style: ktitleStyle,
                          ),
                          Text(
                            examTopic.subject,
                            textAlign: TextAlign.center,
                            style: ksubtitleStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
