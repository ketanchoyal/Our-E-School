import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/ExamTopicsGridView.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/core/Models/ExamTopic.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'QuizPage.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';

class TopicSelectPage extends StatelessWidget {
  const TopicSelectPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
        title: string.exam_topic,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 9 / 13,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0),
              itemCount: examTopicList.length + 1,
              itemBuilder: (context, index) {
                if (index == examTopicList.length) {
                  return Parent(
                    gesture: Gestures()..onTap(() {}),
                    style: ParentStyle()
                      ..ripple(true)
                      ..background.color(Colors.redAccent[700])
                      ..margin(all: 5)
                      ..borderRadius(all: 10)
                      ..alignment.center()
                      ..elevation(5),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.receipt,
                                  size: 60,
                                ),
                                Text(
                                  string.quiz_results,
                                  textAlign: TextAlign.center,
                                  style: ktitleStyle.copyWith(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return ExamTopicsGridView(
                  examTopic: examTopicList[index],
                  onTap: () {
                    kopenPageBottom(
                        context,
                        QuizPage(
                          examTopic: examTopicList[index],
                        ));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
