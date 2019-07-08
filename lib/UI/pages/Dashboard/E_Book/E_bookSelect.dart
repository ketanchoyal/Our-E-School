import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/UI/Widgets/BookGridViewCard.dart';
import 'package:ourESchool/UI/Widgets/TopBar.dart';
import 'package:ourESchool/core/Models/E-Book.dart';
import 'package:flutter/material.dart';
import 'package:ourESchool/UI/Utility/Resources.dart';
import 'EbookInfo.dart';

class EBookSelect extends StatelessWidget {
  const EBookSelect({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
        title: string.e_book,
      ),
      body: GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 9 / 13,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemCount: ebooks.length,
        itemBuilder: (context, index) => BookGridViewCard(
              eBook: ebooks[index],
              onTap: () {
                kopenPage(
                  context,
                  EBookInfo(
                    eBook: ebooks[index],
                  ),
                );
              },
            ),
      ),
    );
  }
}
