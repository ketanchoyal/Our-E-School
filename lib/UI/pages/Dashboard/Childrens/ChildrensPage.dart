import 'package:flutter/material.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/ChildrenGridViewCard.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/core/Models/User.dart';

class ChildrensPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
        title: string.childrens,
      ),
      body: GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 9 / 9,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemCount: users.length,
        itemBuilder: (context, index) => ChildrenGridViewCard(
              user: users[index],
              onTap: () {},
            ),
      ),
    );
  }
}
