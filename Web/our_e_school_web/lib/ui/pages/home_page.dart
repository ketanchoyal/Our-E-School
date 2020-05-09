import 'package:flutter/material.dart';
import 'package:oureschoolweb/ui/components/Resources.dart';
import 'package:oureschoolweb/ui/components/color.dart';
import 'package:oureschoolweb/ui/components/footer.dart';
import 'package:oureschoolweb/ui/components/MenuBar/menuBar.dart';
import 'package:oureschoolweb/ui/components/spacing.dart';
import 'package:oureschoolweb/ui/components/text.dart';
import 'package:oureschoolweb/ui/helper/Enums.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> items = [
    MenuBar(
      selectedPage: SelectedPage.NONE,
    ),
    Features(
      imagePath: ImageAssets.parents_welcome,
      backgroundColor: kmainColorParents,
      text: StringConstants.parent_welcome_text,
      duration: Duration(seconds: 1),
    ),
    divider,
    Features(
      imagePath: ImageAssets.student_welcome,
      backgroundColor: kmainColorStudents,
      text: StringConstants.student_welcome_text,
      reversed: true,
      duration: Duration(seconds: 2),
    ),
    divider,
    Features(
      imagePath: ImageAssets.teacher_welcome,
      backgroundColor: kmainColorTeacher,
      text: StringConstants.teacher_welcome_text,
      duration: Duration(seconds: 3),
    ),
    divider,
    Footer()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: items,
          ),
        ),
      ),
    );
  }
}

class Features extends StatefulWidget {
  Features(
      {Key key,
      this.backgroundColor,
      this.imagePath,
      this.text,
      this.duration,
      this.reversed = false})
      : super(key: key);

  @required
  final String text;
  @required
  final String imagePath;
  @required
  final Color backgroundColor;
  final bool reversed;
  final Duration duration;

  @override
  _FeaturesState createState() => _FeaturesState();
}

class _FeaturesState extends State<Features> with TickerProviderStateMixin {
  AnimationController _controllerText;
  AnimationController _controllerImage;
  Animation<Offset> _offsetFloatText;
  Animation<Offset> _offsetFloatImage;

  @override
  void initState() {
    super.initState();
    _controllerText = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _offsetFloatText =
        Tween<Offset>(begin: Offset(0.0, 500.0), end: Offset.zero)
            .animate(_controllerText);
    _offsetFloatText.addListener(() {
      setState(() {});
    });

    _controllerImage = AnimationController(
      vsync: this,
      duration: widget.duration + Duration(milliseconds: 500),
    );
    _offsetFloatImage =
        Tween<Offset>(begin: Offset(0.0, 500.0), end: Offset.zero)
            .animate(_controllerImage);
    _offsetFloatImage.addListener(() {
      setState(() {});
    });
    _controllerImage.forward();
    _controllerText.forward();
  }

  @override
  void dispose() {
    _controllerText.dispose();
    _controllerImage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> elements = <Widget>[
      SlideTransition(
        position: _offsetFloatImage,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 24),
          child: Image.asset(
            widget.imagePath,
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.width / 5,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Expanded(
        child: SlideTransition(
          position: _offsetFloatText,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: TextHeadline(
              text: widget.text,
              color: textWithTransparency,
            ),
          ),
        ),
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 24),
      color: widget.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.reversed ? [elements.last, elements.first] : elements,
      ),
    );
  }
}
