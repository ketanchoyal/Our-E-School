import 'package:flutter/material.dart';
import 'package:oureschoolweb/components/text.dart';

class Footer extends StatelessWidget {
  // TODO Add additional footer components (i.e. about, links, logos).
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Align(
        alignment: Alignment.center,
        child: TextBody(text: "Copyright © 2020"),
      ),
    );
  }
}