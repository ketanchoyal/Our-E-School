import 'package:acadamicConnect/Components/ProgressBar.dart';
import 'package:acadamicConnect/Models/Question.dart';
import 'package:acadamicConnect/Utility/Resources.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:acadamicConnect/blocs/Quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  QuizPage({Key key}) : super(key: key);

  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => QuizStateProvider(),
      child: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot snap) {
          var state = Provider.of<QuizStateProvider>(context);
          return Scaffold(
            appBar: AppBar(
              // leading: state.timer,
              backgroundColor: Colors.green,
              title: AnimatedProgressbar(
                duration: state.duration,
                value: state.progress,
                start: state.showTimer,
                onFinish: () async {
                  state.timeUp(context);
                },
              ),
              leading: CloseButton(),
            ),
            body: SafeArea(
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: state.controller,
                onPageChanged: (int idx) {
                  state.progress = (idx / (state.questions.length));
                },
                // itemCount: questions.length,

                itemBuilder: (BuildContext context, int idx) {
                  if (idx == state.questions.length) {
                    state.lastQuestion = true;
                  }
                  if (idx == 0) {
                    return StartPage();
                  } else if (idx == state.questions.length + 1) {
                    return FinishPage();
                  } else {
                    return QuestionPage(question: state.questions[idx - 1]);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  // final PageController controller;
  // StartPage({this.controller});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizStateProvider>(context);
    state.showTimer = true;
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(string.topic_name, style: Theme.of(context).textTheme.headline),
          Divider(),
          Expanded(
            child: Text(string.topic_description),
          ),
          MaterialButton(
            color: Colors.green,
            // minWidth: 100,
            onPressed: state.nextPage,
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

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizStateProvider>(context);
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(string.topic_name, style: Theme.of(context).textTheme.headline),
          Divider(),
          Expanded(
            child: Text(state.selectedAnswerSet.toString()),
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
    var state = Provider.of<QuizStateProvider>(context);
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
                  if (question.type == QuestionType.MULTIPLE_ANSWERS) {
                    if (state.selectedList.isEmpty ||
                        state.selectedList == null) {
                      state.selectedAnswerSet[question.id] = ['Left'];
                    }
                  } else if (question.type == QuestionType.MULTIPLE_CHOICE) {
                    if (state.selected == '') {
                      state.selectedAnswerSet[question.id] = ['Left'];
                    }
                  }
                  if (question.type == QuestionType.MULTIPLE_CHOICE) {
                    return multipleChoiceQuestions(state, option, context);
                  } else if (question.type == QuestionType.MULTIPLE_ANSWERS) {
                    return multipleAnswersQuestion(state, option, context);
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
                state.nextPage();
              },
              child: Text(
                state.lastQuestion ? string.finish : string.next,
                style: ktitleStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget multipleChoiceQuestions(
      QuizStateProvider state, option, BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(bottom: 10),
      color: Colors.black26,
      child: InkWell(
        onTap: () {
          state.selected = option.toString();
          state.selectedAnswerSet[question.id] = [option.toString()];

          print(state.selectedList.toString());
          print(state.selectedAnswerSet.toString());
          // _bottomSheet(context, opt);
        },
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                state.selected == option.toString()
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
      QuizStateProvider state, option, BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(bottom: 10),
      color: Colors.black26,
      child: InkWell(
        onTap: () {
          state.selectedList = option.toString();
          if (state.selectedAnswerSet == null) {
            state.selectedAnswerSet[question.id] = [option.toString()];
          } else if (state.selectedAnswerSet != null) {
            if (state.selectedAnswerSet.containsKey(question.id)) {
              if (state.selectedAnswerSet[question.id]
                  .contains('Left')) {
                state.selectedAnswerSet[question.id].remove('Left');
              }
              if (state.selectedAnswerSet[question.id]
                  .contains(option.toString())) {
                state.selectedAnswerSet[question.id].remove(option.toString());
              } else {
                state.selectedAnswerSet[question.id].add(option.toString());
              }
            } else {
              state.selectedAnswerSet[question.id] = [option.toString()];
            }
          }
          print(state.selectedList.toString());
          print(state.selectedAnswerSet.toString());

          // _bottomSheet(context, opt);
        },
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                state.selectedList.isNotEmpty
                    ? state.selectedList.contains(option)
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
