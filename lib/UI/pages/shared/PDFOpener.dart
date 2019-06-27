import 'package:acadamicConnect/UI/Utility/constants.dart';
import 'package:acadamicConnect/UI/Widgets/TopBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class PDFOpener extends StatefulWidget {
  final String url;
  final String title;

  PDFOpener({@required this.url, @required this.title});

  @override
  _PDFOpenerState createState() => _PDFOpenerState();
}

class _PDFOpenerState extends State<PDFOpener> {
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
          title: widget.title ?? 'PDF',
        ),
        body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(document: doc)),
    );
  }
}