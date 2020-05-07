import 'package:ourESchool/core/Models/ExamTopic.dart';
import 'package:ourESchool/core/Models/Question.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/viewmodel/BaseModel.dart';

class QuizStateModel extends BaseModel {
  double _progress = 0;
  var _selected = '';
  List<String> _selectedList = [];
  bool _lastQuestion = false;
  var _selectedAnswerMap = Map<String, List<String>>();
  Duration duration = Duration(seconds: 10);
  List<Question> _questions;
  ExamTopic _selectedTopic;
  var _checkedAnswersMap = Map<Question, bool>();

  final PageController controller = PageController();
  bool showTimer = false;

  ExamTopic get selectedTopic => _selectedTopic;
  get progress => _progress;
  get selected => _selected;
  get lastQuestion => _lastQuestion;
  List<String> get selectedList => _selectedList;
  Map<String, List<String>> get selectedAnswerMap => _selectedAnswerMap;
  List<Question> get questions => _questions;
  Map<Question, bool> get checkedAnswersMap => _checkedAnswersMap;

  QuizStateModel() {
    setState2(ViewState.Busy);
    print('QuizModelCreated');
  }

  void setLeft() async {
    for (var question in _questions) {
      _selectedAnswerMap[question.id] = ['Left'];
    }
  }

  void getQuestions({ExamTopic forTopic}) async {
    print('In QuizStateModel');
    setState(ViewState.Busy);
    selectedTopic = forTopic;
    this._questions = questionsList;
    await Future.delayed(const Duration(seconds: 3), () {});
    setLeft();
    setState(ViewState.Idle);
  }

  set selectedTopic(ExamTopic newValue) {
    _selectedTopic = newValue;
    notifyListeners();
  }

  set selectedList(var newValue) {
    if (_selectedList.contains(newValue.toString())) {
      _selectedList.remove(newValue.toString());
    } else {
      _selectedList.add(newValue.toString());
    }
    notifyListeners();
  }

  set lastQuestion(bool newValue) {
    _lastQuestion = newValue;
    notifyListeners();
  }

  set progress(double newValue) {
    _progress = newValue;
    notifyListeners();
  }

  set selected(var newValue) {
    _selected = newValue;
    notifyListeners();
  }

  void nextPage() async {
    await controller.nextPage(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
    _selectedList.clear();
    _selected = '';
  }

  void timeUp(BuildContext context) async {
    var currentpage = controller.page;
    var totalPage = _questions.length;

    print('TotalPage' + totalPage.toString());
    for (var i = currentpage.toInt() + 1; i <= totalPage + 1; i++) {
      print('CurrentPage' + i.toString());
      await controller.animateToPage(i,
          curve: Curves.easeOut, duration: Duration(milliseconds: 50));
    }
  }

  void checkAnswers() {
    print(_selectedAnswerMap.toString());
// setState2(ViewState.Busy);
    showTimer = false;
// await Future.delayed(const Duration(seconds: 3), () {});
// notifyListeners();
    for (var question in _questions) {
      List correctAnswers = question.answer;

      List<String> selectedAnswers = _selectedAnswerMap[question.id];
      bool isCorrect = false;
      print(
          'Selected Answer: ' + question.id + ' ' + selectedAnswers.toString());

      for (String selectedAnswer in selectedAnswers) {
        // for (var answer in correctAnswers) {
        //   if (selectedAnswer == answer.toString()) {
        //     isCorrect = true;
        //   } else {
        //     isCorrect = false;
        //   }
        // }
        if (correctAnswers.contains(selectedAnswer.toString())) {
          isCorrect = true;
        } else {
          isCorrect = false;
        }
      }
      _checkedAnswersMap[question] = isCorrect;
    }
    setState2(ViewState.Idle);
    notifyListeners();
  }
}
