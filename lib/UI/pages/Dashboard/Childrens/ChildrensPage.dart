import 'package:flutter/material.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/BottomSheetChildrensWidget.dart';
import 'package:ourESchool/UI/Widgets/ChildrenGridViewCard.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/UI/pages/BaseView.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/viewmodel/ProfilePageModel.dart';

class ChildrensPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfilePageModel>(
        onModelReady: (model) => model.getChildrens(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: TopBar(
              child: kBackBtn,
              onPressed: () {
                kbackBtn(context);
              },
              title: string.childrens,
            ),
            body: model.state == ViewState.Busy
                ? kBuzyPage(color: Theme.of(context).primaryColor)
                : GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 9 / 9,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                    ),
                    itemCount: model.childrens.length,
                    itemBuilder: (context, index) => ChildrenGridViewCard(
                      user: model.childrens[index],
                      onTap: () {
                        if (model.childrens[index].displayName != '')
                          showBottomSheet(
                            elevation: 10,
                            context: context,
                            builder: (context) => BottomSheetChildrensWidget(
                              user: model.childrens[index],
                            ),
                          );
                      },
                    ),
                  ),
          );
        });
  }
}
