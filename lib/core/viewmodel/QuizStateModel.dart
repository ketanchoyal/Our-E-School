import 'package:ourESchool/core/Models/ExamTopic.dart';
import 'package:ourESchool/core/Models/Question.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/viewmodel/BaseModel.dart';

class QuizStateModel extends BaseModel {
  double _progress = 0;
  // var _selected = '';
  List<String> _selectedList = [];
  var _selectedAnswerMap = Map<Question, List<String>>();
  Duration duration = Duration(seconds: 100);
  List<Question> _questions;
  ExamTopic _selectedTopic;
  var _checkedAnswersMap = Map<Question, bool>();

  final PageController controller = PageController();
  bool showTimer = false;

  ExamTopic get selectedTopic => _selectedTopic;
  get progress => _progress;
  // get selected => _selected;
  Map<Question, bool> get checkedAnswersMap => _checkedAnswersMap;
  List<String> get selectedList => _selectedList;
  Map<Question, List<String>> get selectedAnswerMap => _selectedAnswerMap;
  List<Question> get questions => _questions;

  QuizStateModel() {
    print('QuizModelCreated');
  }

  void getQuestions() async {
    print('In QuizStateModel');
    setState(ViewState.Busy);
    await Future.delayed(const Duration(seconds: 3), () {});
    this._questions = questionsList;
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

  set progress(double newValue) {
    _progress = newValue;
    notifyListeners();
  }

  // set selected(var newValue) {
  //   _selected = newValue;
  //   notifyListeners();
  // }

  void nextPage() async {
    await controller.nextPage(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
    _selectedList.clear();
    // _selected = '';
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

  void checkAnswers() async {
    // setState2(ViewState.Busy);
    showTimer = false;
    await Future.delayed(const Duration(seconds: 3), () {});
    // notifyListeners();
    for (var question in _questions) {
      List correctAnswers = question.answer;

      List<String> selectedAnswers = _selectedAnswerMap[question];
      bool isCorrect = false;

      for (var selectedAnswer in selectedAnswers) {
        if (correctAnswers.contains(selectedAnswer)) {
          isCorrect = true;
        } else {
          isCorrect = false;
        }
      }
      _checkedAnswersMap[question] = isCorrect;
    }
    // setState2(ViewState.Idle);
    // notifyListeners();
  }
}
