import 'package:acadamicConnect/Components/ExamTopicsGridView.dart';
import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Models/ExamTopic.dart';
import 'package:acadamicConnect/Utility/Resources.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:flutter/material.dart';

import 'QuizPage.dart';

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
      body: GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 9 / 13,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0),
        itemCount: examTopicList.length,
        itemBuilder: (context, index) => ExamTopicsGridView(
              examTopic: examTopicList[index],
              onTap: () {
                kopenPageBottom(context, QuizPage());
              },
            ),
      ),
    );
  }
}