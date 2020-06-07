import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/ProgressBar.dart';
import 'package:ourESchool/UI/pages/BaseView.dart';
import 'package:ourESchool/core/Models/ExamTopic.dart';
import 'package:ourESchool/core/Models/Question.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/viewmodel/QuizStateModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourESchool/core/enums/questionType.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  final ExamTopic examTopic;
  QuizPage({@required this.examTopic, Key key}) : super(key: key);

  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<QuizStateModel>(
      onModelReady: (model) => model.getQuestions(forTopic: widget.examTopic),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            // leading: state.timer,
            backgroundColor: Colors.green,
            title: AnimatedProgressbar(
              duration: model.duration,
              value: model.progress,
              start: model.showTimer,
              onFinish: () async {
                model.timeUp(context);
              },
            ),
            leading: CloseButton(),
          ),
          body: model.state == ViewState.Busy
              ? kBuzyPage(color: Theme.of(context).primaryColor)
              : SafeArea(
                  child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    controller: model.controller,
                    onPageChanged: (int idx) {
                      model.progress = (idx / (model.questions.length));
                    },
                    // itemCount: questions.length,

                    itemBuilder: (BuildContext context, int idx) {
                      // if (idx == model.questions.length) {
                      //   model.lastQuestion = true;
                      // }
                      if (idx == 0) {
                        return StartPage();
                      } else if (idx == model.questions.length + 1) {
                        return FinishPage();
                      } else {
                        return QuestionPage(question: model.questions[idx - 1]);
                      }
                    },
                  ),
                ),
        );
      },
    );
  }
}

class StartPage extends StatelessWidget {
  // final PageController controller;
  // StartPage({this.controller});

  // final ExamTopic examTopic;
  // StartPage({@required this.examTopic});

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<QuizStateModel>(context, listen: false);
    model.showTimer = true;
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(model.selectedTopic.topicName,
              style: Theme.of(context).textTheme.headline),
          Divider(),
          Expanded(
            child: Text(model.selectedTopic.description),
          ),
          MaterialButton(
            color: Colors.green,
            // minWidth: 100,
            onPressed: model.nextPage,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.assessment, color: Colors.white),
                SizedBox(
                  width: 6,
                ),
                Text(
                  string.start_quiz,
                  style: ktitleStyle.copyWith(color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FinishPage extends StatelessWidget {
  // final PageController controller;
  // StartPage({this.controller});

  // final ExamTopic examTopic;
  // FinishPage({@required this.examTopic});

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<QuizStateModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: <Widget>[
              Text(
                model.selectedTopic.topicName,
                style: Theme.of(context).textTheme.headline,
              ),
              MaterialButton(
                onPressed: model.checkAnswers,
                child: Text(
                  'Check Answers',
                  style: ksubtitleStyle,
                ),
              )
            ],
          ),
          Divider(),
          Expanded(
            child: model.state2 == ViewState.Busy
                ? kBuzyPage(color: Theme.of(context).primaryColor)
                : ListView.builder(
                    itemCount: model.checkedAnswersMap.length,
                    itemBuilder: (context, index) => Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Question : ',
                                        style: ktitleStyle,
                                      ),
                                      Text(
                                        model.questions[index].question,
                                        style: ksubtitleStyle,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Answer : ',
                                        style: ktitleStyle,
                                      ),
                                      Text(
                                        model.questions[index].answer
                                            .toString(),
                                        style: ksubtitleStyle,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Your Answers : ',
                                        style: ktitleStyle,
                                      ),
                                      Text(
                                        model.selectedAnswerMap[
                                                model.questions[index].id]
                                            .toString(),
                                        style: ksubtitleStyle,
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 4,
                                    indent: 2,
                                  )
                                ],
                              ),
                              Icon(
                                model.checkedAnswersMap[model.questions[index]]
                                    ? Icons.done
                                    : Icons.close,
                                color: Theme.of(context).primaryColor,
                                size: 30,
                              )
                            ],
                          ),
                        ),
                  ),
          ),
          MaterialButton(
            color: Colors.green,
            // minWidth: 100,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.check_circle_outline, color: Colors.white),
                SizedBox(
                  width: 6,
                ),
                Text(
                  string.finish,
                  style: ktitleStyle.copyWith(color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class QuestionPage extends StatelessWidget {
  final Question question;
  QuestionPage({this.question});

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<QuizStateModel>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Text(
                question.question,
                style: ktitleStyle,
              ),
            ),
          ),
          Container(
            // padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: question.options.map(
                (option) {
                  //Mark Question as left initially if user ticks any answer it'll get changed
                  // if (question.type == QuestionType.MULTIPLE_ANSWERS) {
                  //   if (model.selectedList.isEmpty ||
                  //       model.selectedList == null) {
                  //     model.selectedAnswerMap[question.id] = ['Left'];
                  //   }
                  // } else if (question.type == QuestionType.MULTIPLE_CHOICE) {
                  //   if (model.selected == '') {
                  //     model.selectedAnswerMap[question.id] = ['Left'];
                  //   }
                  // }
                  if (question.type == QuestionType.MULTIPLE_CHOICE) {
                    return multipleChoiceQuestions(model, option, context);
                  } else {
                    return multipleAnswersQuestion(model, option, context);
                  }
                },
              ).toList(),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: MaterialButton(
              // color: Colors.green,
              minWidth: 80,
              height: 40,
              onPressed: () async {
                model.nextPage();
              },
              child: Text(
                model.lastQuestion ? string.finish : string.next,
                style: ktitleStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget multipleChoiceQuestions(
      QuizStateModel model, option, BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(bottom: 10),
      color: Colors.black26,
      child: InkWell(
        onTap: () {
          model.selected = option.toString();
          // model.selectedAnswerMap[question.id].clear();
          model.selectedAnswerMap[question.id] = [option.toString()];

          print(model.selectedList.toString());
          print(model.selectedAnswerMap.toString());
          // _bottomSheet(context, opt);
        },
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                model.selected == option.toString()
                    ? FontAwesomeIcons.checkCircle
                    : FontAwesomeIcons.circle,
                size: 30,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(
                    option.toString(),
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget multipleAnswersQuestion(
      QuizStateModel model, option, BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(bottom: 10),
      color: Colors.black26,
      child: InkWell(
        onTap: () {
          model.selectedList = option.toString();
          if (model.selectedAnswerMap == null) {
            model.selectedAnswerMap[question.id] = [option.toString()];
          } else if (model.selectedAnswerMap != null) {
            if (model.selectedAnswerMap.containsKey(question.id)) {
              if (model.selectedAnswerMap[question.id].contains('Left')) {
                model.selectedAnswerMap[question.id].remove('Left');
              }
              if (model.selectedAnswerMap[question.id]
                  .contains(option.toString())) {
                model.selectedAnswerMap[question.id].remove(option.toString());
              } else {
                model.selectedAnswerMap[question.id].add(option.toString());
              }
            } else {
              model.selectedAnswerMap[question.id] = [option.toString()];
            }
          }
          print(model.selectedList.toString());
          print(model.selectedAnswerMap.toString());

          // _bottomSheet(context, opt);
        },
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                model.selectedList.isNotEmpty
                    ? model.selectedList.contains(option)
                        ? FontAwesomeIcons.checkSquare
                        : FontAwesomeIcons.square
                    : FontAwesomeIcons.square,
                size: 30,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(
                    option.toString(),
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
