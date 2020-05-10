import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oureschoolweb/ui/components/typography.dart';

class TextBody extends StatelessWidget {
  final String text;
  final Color color;

  const TextBody({Key key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: bodyTextStyle(context, color: color),
      ),
    );
  }
}

class TextBodyExtraLarge extends StatelessWidget {
  final String text;
  final Color color;

  const TextBodyExtraLarge({Key key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: extraLargeTextStyle(context, color: color),
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
      child: Text(
        text,
        style: subtitleTextStyle(context),
      ),
    );
  }
}

class TextHeadline extends StatelessWidget {
  final String text;
  final Color color;

  const TextHeadline({Key key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: headlineTextStyle(context, color: color),
      ),
    );
  }
}

class TextHeadlineSecondary extends StatelessWidget {
  final String text;
  final Color color;

  const TextHeadlineSecondary({Key key, this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: headlineSecondaryTextStyle(context, color: color),
      ),
    );
  }
}

class TextButton extends StatelessWidget {
  final String text;
  final Color color;

  const TextButton({Key key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: buttonTextStyle(color: color).copyWith(color: color),
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
      decoration: BoxDecoration(
          border: Border(left: BorderSide(width: 2, color: Color(0xFF333333)))),
      padding: EdgeInsets.only(left: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: bodyTextStyle(context),
        ),
      ),
    );
  }
}
