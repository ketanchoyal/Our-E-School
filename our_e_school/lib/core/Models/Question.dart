import 'package:flutter/material.dart';
import 'package:ourESchool/core/enums/questionLevel.dart';
import 'package:ourESchool/core/enums/questionType.dart';

class Question {
  final String question;
  final List answer;
  final QuestionType type;
  final List options;
  final String id;
  final String description;
  final QuestionLevel questionLevel;
  final String by;
  final String bySchool;
  final String subject;
  final String standard;

  Question({
    @required this.question,
    @required this.answer,
    @required this.type,
    @required this.options,
    @required this.id,
    @required this.description,
    @required this.questionLevel,
    this.standard,
    this.subject,
    this.by,
    this.bySchool,
  });

  // Question(
  //     {this.question,
  //     this.answer,
  //     this.id,
  //     this.options,
  //     this.type,
  //     this.questionLevel,
  //     this.description});
}

List<Question> questionsList = [
  Question(
      questionLevel: QuestionLevel.EASY,
      type: QuestionType.MULTIPLE_CHOICE,
      answer: [true.toString()],
      description: 'Some Description',
      id: '0',
      options: [true.toString(), false.toString()],
      question: '1'),
  Question(
      questionLevel: QuestionLevel.EASY,
      type: QuestionType.MULTIPLE_ANSWERS,
      answer: ['Z', 'CD1'],
      description: 'Some Description',
      id: '1',
      options: ['Z', 'B1S', 'CD1', 'DA1'],
      question: '2'),
  Question(
      questionLevel: QuestionLevel.EASY,
      type: QuestionType.MULTIPLE_ANSWERS,
      answer: ['A1', 'D1'],
      description: 'Some Description',
      id: '2',
      options: ['A1', 'B1', 'C1', 'D1'],
      question: '3'),
  Question(
      questionLevel: QuestionLevel.EASY,
      type: QuestionType.MULTIPLE_CHOICE,
      answer: ['A2'],
      description: 'Some Description',
      id: '3',
      options: ['A2', 'B2', 'C2', 'D2'],
      question: '4'),
  Question(
      questionLevel: QuestionLevel.EASY,
      type: QuestionType.MULTIPLE_CHOICE,
      answer: ['B3'],
      description: 'Some Description',
      id: '4',
      options: ['A3', 'B3', 'C3', 'D3'],
      question: '5'),
  Question(
      questionLevel: QuestionLevel.EASY,
      type: QuestionType.MULTIPLE_CHOICE,
      answer: ['C4'],
      description: 'Some Description',
      id: '5',
      options: ['A4', 'B4', 'C4', 'D4'],
      question: '6'),
  Question(
      questionLevel: QuestionLevel.EASY,
      type: QuestionType.MULTIPLE_CHOICE,
      answer: ['D'],
      description: 'Some Description',
      id: '6',
      options: ['A5', 'B5', 'C5', 'D'],
      question: '7'),
  // Question(
  //     questionLevel: QuestionLevel.EASY,
  //     type: QuestionType.MULTIPLE_CHOICE,
  //     answer: 'A2',
  //     description: 'Some Description',
  //     id: '2',
  //     options: ['A2', 'B2', 'C2', 'D2'],
  //     question: '4'),
  // Question(
  //     questionLevel: QuestionLevel.EASY,
  //     type: QuestionType.MULTIPLE_CHOICE,
  //     answer: 'B3',
  //     description: 'Some Description',
  //     id: '3',
  //     options: ['A3', 'B3', 'C3', 'D3'],
  //     question: '5'),
  // Question(
  //     questionLevel: QuestionLevel.EASY,
  //     type: QuestionType.MULTIPLE_CHOICE,
  //     answer: 'C4',
  //     description: 'Some Description',
  //     id: '4',
  //     options: ['A4', 'B4', 'C4', 'D4'],
  //     question: '6'),
  // Question(
  //     questionLevel: QuestionLevel.EASY,
  //     type: QuestionType.MULTIPLE_CHOICE,
  //     answer: 'D',
  //     description: 'Some Description',
  //     id: '5',
  //     options: ['A5', 'B5', 'C5', 'D'],
  //     question: '7')
];
