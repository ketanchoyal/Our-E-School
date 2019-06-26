import 'package:flutter/widgets.dart';

class ExamTopic {
  String topicName;
  String topicId;
  String topicimageUrl;
  String topicCreatedByTeacherName;
  String topicCreatedByTeacherId;
  String topicCreatedBySchoolName;
  String topicIsForStandard;
  String subject;
  String description;

  ExamTopic({
    @required this.description,
    @required this.subject,
    @required this.topicCreatedBySchoolName,
    @required this.topicCreatedByTeacherName,
    @required this.topicCreatedByTeacherId,
    @required this.topicId,
    this.topicimageUrl,
    @required this.topicIsForStandard,
    @required this.topicName
  });
}

List<ExamTopic> examTopicList = [
  ExamTopic(
    description: 'Simple Maths',
    subject: 'Maths',
    topicCreatedBySchoolName: 'Ambe',
    topicCreatedByTeacherId: 'teacherid',
    topicCreatedByTeacherName: 'teacherName',
    topicId: '0',
    topicIsForStandard: '4',
    topicName: 'Add'
  ),
  ExamTopic(
    description: 'Simple Maths',
    subject: 'Maths',
    topicCreatedBySchoolName: 'Ambe',
    topicCreatedByTeacherId: 'teacherid',
    topicCreatedByTeacherName: 'teacherName',
    topicId: '0',
    topicIsForStandard: '5',
    topicName: 'Multiply'
  ),
  ExamTopic(
    description: 'Simple Maths',
    subject: 'Maths',
    topicCreatedBySchoolName: 'Ambe',
    topicCreatedByTeacherId: 'teacherid',
    topicCreatedByTeacherName: 'teacherName',
    topicId: '0',
    topicIsForStandard: '4',
    topicName: 'Subtraction'
  ),
  ExamTopic(
    description: 'Simple Maths',
    subject: 'Maths',
    topicCreatedBySchoolName: 'Ambe',
    topicCreatedByTeacherId: 'teacherid',
    topicCreatedByTeacherName: 'teacherName',
    topicId: '0',
    topicIsForStandard: '4',
    topicName: 'Add'
  ),
  ExamTopic(
    description: 'Simple Maths',
    subject: 'Maths',
    topicCreatedBySchoolName: 'Ambe',
    topicCreatedByTeacherId: 'teacherid',
    topicCreatedByTeacherName: 'teacherName',
    topicId: '0',
    topicIsForStandard: '2',
    topicName: 'Division'
  ),
];