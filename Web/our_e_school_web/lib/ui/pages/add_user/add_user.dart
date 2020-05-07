import 'package:flutter/material.dart';
import 'package:oureschoolweb/ui/components/footer.dart';
import 'package:oureschoolweb/ui/components/logedInMenuBar.dart';
import 'package:oureschoolweb/ui/helper/Enums.dart';

class AddUser extends StatelessWidget {
  const AddUser({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          LogedInMenuBar(selectedPage: SelectedPage.ADDUSER),
          Footer(),
        ],
      ),
    ));
  }
}
