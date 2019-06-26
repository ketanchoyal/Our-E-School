import 'package:acadamicConnect/Models/ExamTopic.dart';
import 'package:acadamicConnect/Models/Question.dart';
import 'package:flutter/material.dart';


class QuizStateProvider with ChangeNotifier {
  double _progress = 0;
  var _selected = '';
  List<String> _selectedList = [];
  bool _lastQuestion = false;
  var _selectedAnswerSet = Map<String, List<String>>();
  Duration duration = Duration(seconds: 5);
  List<Question> _questions;
  ExamTopic _selectedTopic;

  final PageController controller = PageController();
  bool showTimer = false;

ExamTopic get selectedTopic => _selectedTopic;
  get progress => _progress;
  get selected => _selected;
  get lastQuestion => _lastQuestion;
  List<String> get selectedList => _selectedList;
  Map<String, List<String>> get selectedAnswerSet => _selectedAnswerSet;
  List<Question> get questions => _questions;

  QuizStateProvider() {
    this.questions = questionsList;
  }

  set questions(List<Question> questions) {
    _questions = questions;
    notifyListeners();
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
    await _selectedList.clear();
    _selected = '';
  }

  void timeUp(BuildContext context) async {
    var currentpage = controller.page;
    var totalPage = _questions.length;

    print('TotalPage' + totalPage.toString());
    for (var i = currentpage.toInt() + 1; i <= totalPage +1; i++) {
      print('CurrentPage' + i.toString());
      await controller.animateToPage(i,
          curve: Curves.easeOut, duration: Duration(milliseconds: 50));
    }
  }
}