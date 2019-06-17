import 'package:acadamicConnect/Components/ProgressBar.dart';
import 'package:acadamicConnect/Models/Question.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class QuizState with ChangeNotifier {
  double _progress = 0;
  String _selected;
  bool _lastQuestion = false;

  final PageController controller = PageController();

  get progress => _progress;
  get selected => _selected;
  get lastQuestion => _lastQuestion;

  set lastQuestion(bool newValue) {
    _lastQuestion = newValue;
    notifyListeners();
  }

  set progress(double newValue) {
    _progress = newValue;
    notifyListeners();
  }

  set selected(String newValue) {
    _selected = newValue;
    notifyListeners();
  }

  void nextPage() async {
    await controller.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}

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
      builder: (_) => QuizState(),
      child: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot snap) {
          var state = Provider.of<QuizState>(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).canvasColor.withOpacity(0.5),
              title: AnimatedProgressbar(value: state.progress),
              leading: CloseButton(),
            ),
            body: SafeArea(
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: state.controller,
                onPageChanged: (int idx) {
                  state.progress = (idx / (questions.length));
                },
                // itemCount: questions.length,

                itemBuilder: (BuildContext context, int idx) {
                  if (idx == 0) {
                    return StartPage();
                  } else {
                    if (idx == questions.length) {
                      state.lastQuestion = true;
                    }
                    return QuestionPage(question: questions[idx - 1]);
                  }
                  // return QuestionPage(
                  //   question: questions[idx],
                  // );
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
  final PageController controller;
  StartPage({this.controller});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Topic Name', style: Theme.of(context).textTheme.headline),
          Divider(),
          Expanded(
            child: Text('Some Description regarding the quiz topic'),
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
                  'Start Quiz',
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
    var state = Provider.of<QuizState>(context);
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
              children: question.options.map((option) {
                return Container(
                  height: 70,
                  margin: EdgeInsets.only(bottom: 10),
                  color: Colors.black26,
                  child: InkWell(
                    onTap: () {
                      state.selected = option;
                      // _bottomSheet(context, opt);
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            state.selected == option
                                ? FontAwesomeIcons.checkCircle
                                : FontAwesomeIcons.circle,
                            size: 30,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 16),
                              child: Text(
                                option,
                                style: Theme.of(context).textTheme.body2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: MaterialButton(
              // color: Colors.green,
              minWidth: 80,
              height: 40,
              onPressed: state.lastQuestion ? null : state.nextPage,
              child: Text(
                'Next',
                style: ktitleStyle,
              ),
            ),
          )
        ],
      ),
    );
  }
}
