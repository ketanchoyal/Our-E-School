import 'package:acadamicConnect/Components/ColumnReusableCardButton.dart';
import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:acadamicConnect/pages/PDFOpener.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  static String pageLabel = 'Results';

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool isTeacher = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: TopBar(
            title: ResultPage.pageLabel,
            child: kBackBtn,
            onPressed: () {
              kbackBtn(context);
            }),
        floatingActionButton: Visibility(
          visible: isTeacher,
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
            backgroundColor: Colors.red,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, i) => ColumnReusableCardButton(
                  label: 'Semester $i',
                  icon: Icons.receipt,
                  onPressed: () {
                    kopenPage(
                      context,
                      PDFOpener(
                        url: 'http://www.pdf995.com/samples/pdf.pdf',
                        title: 'Sem $i',
                      ),
                    );
                  },
                  height: 70,
                ),
          ),
        ),
      ),
    );
  }
}
