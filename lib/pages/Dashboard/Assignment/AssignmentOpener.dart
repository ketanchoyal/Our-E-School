import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class AssignmentOpener extends StatefulWidget {
  final String url;
  final String chapterNo;

  AssignmentOpener({@required this.url, @required this.chapterNo});

  @override
  _AssignmentOpenerState createState() => _AssignmentOpenerState();
}

class _AssignmentOpenerState extends State<AssignmentOpener> {
  PDFDocument doc;

  bool _isLoading = true;

  loadPDF() async {
    doc = await PDFDocument.fromURL(widget.url);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPDF();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(
          child: kBackBtn,
          onPressed: (){
            Navigator.pop(context);
          },
          title: widget.chapterNo,
        ),
        body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(document: doc)),
    );
  }
}