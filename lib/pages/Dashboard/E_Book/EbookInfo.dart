import 'package:acadamicConnect/Models/E-Book.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:acadamicConnect/pages/common/PDFOpener.dart';
import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';

const double _imageHeight = 230;
const double _buttonHeight = 40;

class EBookInfo extends StatelessWidget {
  final EBook eBook;

  EBookInfo({@required this.eBook, Key key}) : super(key: key);

  // AppBar appBar = AppBar().preferredSize.height;
  // double appBarHeight = AppBar().preferredSize.height;
  // double navigationbarHeight = kBottomNavigationBarHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeDetector(
        onSwipeDown: () {
          kbackBtn(context);
        },
        onSwipeRight: () {
          kbackBtn(context);
        },
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.red,
                    Colors.blue,
                  ],
                  stops: [0.0, 1.0],
                ),
                image: DecorationImage(
                  image: NetworkImage(eBook.imageUrl),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Theme.of(context).canvasColor.withOpacity(0.15),
                      BlendMode.dstATop),
                ),
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              top: MediaQuery.of(context).size.height * 0.09,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: eBook.boodId + 'image',
                    transitionOnUserGestures: true,
                    child: Container(
                      height: _imageHeight,
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
            ),
            Positioned(
              right: 10,
              left: 10,
              top:
                  _imageHeight + MediaQuery.of(context).size.height * 0.08 + 10,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      height: _buttonHeight,
                      child: Text(
                        'Read',
                        style: ktitleStyle,
                      ),
                      onPressed: () {
                        
                      },
                      elevation: 5,
                      color: Colors.blue[300],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: MaterialButton(
                      height: _buttonHeight,
                      child: Text(
                        'Add to Favourite',
                        style: ktitleStyle,
                      ),
                      onPressed: () {},
                      elevation: 5,
                      color: Colors.blue[300],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: 10,
              left: 10,
              top: _imageHeight +
                  _buttonHeight +
                  MediaQuery.of(context).size.height * 0.08 +
                  20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Description: ',
                    style: ktitleStyle.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      eBook.description,
                      style: ksubtitleStyle,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
