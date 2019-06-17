enum QuestionType { MULTIPLE_CHOICE, TRUE_FALSE }
enum QuestionLevel { EASY, MEDIUM, HARD }

class Question {
  String question;
  var answer;
  QuestionType type;
  List<String> options = [];
  String id;
  String description;
  QuestionLevel questionLevel;

  Question(
      {this.question,
      this.answer,
      this.id,
      this.options,
      this.type,
      this.questionLevel,
      this.description});
}

List<Question> questions = [
  Question(
      questionLevel: QuestionLevel.EASY,
      type: QuestionType.MULTIPLE_CHOICE,
      answer: 'A',
      description: 'Some Description',
      id: '1',
      options: ['A', 'B', 'C', 'D'],
      question: '1'),
  Question(
      questionLevel: QuestionLevel.EASY,
      type: QuestionType.MULTIPLE_CHOICE,
      answer: 'A',
      description: 'Some Description',
      id: '2',
      options: ['A', 'B', 'C', 'D'],
      question: '2'),
  Question(
      questionLevel: QuestionLevel.EASY,
      type: QuestionType.MULTIPLE_CHOICE,
      answer: 'B',
      description: 'Some Description',
      id: '3',
      options: ['A', 'B', 'C', 'D'],
      question: '3'),
  Question(
      questionLevel: QuestionLevel.EASY,
      type: QuestionType.MULTIPLE_CHOICE,
      answer: 'C',
      description: 'Some Description',
      id: '4',
      options: ['A', 'B', 'C', 'D'],
      question: '4'),
  Question(
      questionLevel: QuestionLevel.EASY,
      type: QuestionType.MULTIPLE_CHOICE,
      answer: 'D',
      description: 'Some Description',
      id: '5',
      options: ['A', 'B', 'C', 'D'],
      question: '5')
];
