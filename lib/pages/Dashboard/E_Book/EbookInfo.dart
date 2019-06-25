import 'package:acadamicConnect/Components/BookGridViewCard.dart';
import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Models/E-Book.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:flutter/material.dart';

class EBookInfo extends StatelessWidget {
  final EBook eBook;

  EBookInfo({@required this.eBook, Key key}) : super(key: key);

  // AppBar appBar = AppBar().preferredSize.height;
  double appBarHeight = AppBar().preferredSize.height;
  double navigationbarHeight = kBottomNavigationBarHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        child: kBackBtn,
        onPressed: () {
          kbackBtn(context);
        },
        title: eBook.bookName,
      ),
      body: Stack(
        children: <Widget>[
          // Column(
          //   children: <Widget>[
          //     Container(
          //       height: MediaQuery.of(context).size.height * 0.25 -
          //           navigationbarHeight,
          //       color: Colors.red,
          //     ),
          //     Container(
          //       height:
          //           MediaQuery.of(context).size.height * 0.75 - appBarHeight,
          //       color: Colors.blue,
          //     ),
          //   ],
          // ),
          Container(
            decoration: BoxDecoration(
              // borderRadius: new BorderRadius.all(Radius.circular(10.0)),
              image: DecorationImage(
                image: NetworkImage(eBook.imageUrl),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            top: MediaQuery.of(context).size.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: eBook.boodId + 'image',
                  transitionOnUserGestures: true,
                  child: Container(
                    height: 230,
                    child: AspectRatio(
                      aspectRatio: 9 / 13,
                      child: Card(
                        elevation: 10,
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(eBook.imageUrl),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // SizedBox(height: 20,),
                    Hero(
                      tag: eBook.boodId + eBook.bookName,
                      transitionOnUserGestures: true,
                      child: Text(
                        eBook.bookName,
                        textAlign: TextAlign.center,
                        style: ktitleStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                    ),
                    Text(
                      'By',
                      textAlign: TextAlign.center,
                      style: ktitleStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Hero(
                      tag: eBook.boodId + eBook.bookAuthor,
                      transitionOnUserGestures: true,
                      child: Text(
                        eBook.bookAuthor,
                        textAlign: TextAlign.center,
                        style: ksubtitleStyle.copyWith(fontSize: 18),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'for:',
                          textAlign: TextAlign.center,
                          style: ksubtitleStyle.copyWith(fontSize: 18),
                        ),
                        Text(
                          eBook.bookIsForStandard == 'N.A'
                              ? ' ' + eBook.bookIsForStandard
                              : ' ' + eBook.bookIsForStandard + 'th Standard',
                          textAlign: TextAlign.center,
                          style: ksubtitleStyle.copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
