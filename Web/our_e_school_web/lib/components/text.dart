import 'package:flutter/widgets.dart';
import 'package:oureschoolweb/components/spacing.dart';
import 'package:oureschoolweb/components/typography.dart';

class TextBody extends StatelessWidget {
  final String text;

  const TextBody({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginBottom24,
      child: Text(
        text,
        style: bodyTextStyle,
      ),
    );
  }
}

class TextBodySecondary extends StatelessWidget {
  final String text;

  const TextBodySecondary({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginBottom24,
      child: Text(
        text,
        style: subtitleTextStyle,
      ),
    );
  }
}

class TextHeadlineSecondary extends StatelessWidget {
  final String text;

  const TextHeadlineSecondary({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginBottom12,
      child: Text(
        text,
        style: headlineSecondaryTextStyle,
      ),
    );
  }
}

class TextBlockquote extends StatelessWidget {
  final String text;

  const TextBlockquote({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginBottom24,
      decoration: BoxDecoration(
          border: Border(left: BorderSide(width: 2, color: Color(0xFF333333)))),
      padding: EdgeInsets.only(left: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: bodyTextStyle,
        ),
      ),
    );
  }
}
