import 'package:ourESchool/UI/Utility/constants.dart';
import 'package:ourESchool/core/Models/E-Book.dart';
import 'package:flutter/material.dart';

class BookGridViewCard extends StatelessWidget {
  final EBook eBook;
  final Function onTap;

  BookGridViewCard({
    this.onTap,
    @required this.eBook,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(2),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          elevation: 5,
          child: ClipRect(
            child: Banner(
              color: Theme.of(context).primaryColor,
              location: BannerLocation.topStart,
              message: eBook.bookIsForStandard == null
                  ? 'Everyone'
                  : eBook.bookIsForStandard,
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: eBook.bookId + 'image',
                    transitionOnUserGestures: true,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            new BorderRadius.all(Radius.circular(10.0)),
                        image: DecorationImage(
                          image: NetworkImage(eBook.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: new BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Hero(
                            tag: eBook.bookId + eBook.bookName + 'ds',
                            transitionOnUserGestures: true,
                            child: Text(
                              eBook.bookName,
                              textAlign: TextAlign.center,
                              style: ktitleStyle,
                            ),
                          ),
                          Hero(
                            tag: eBook.bookId + eBook.bookAuthor + 'sd',
                            transitionOnUserGestures: true,
                            child: Text(
                              eBook.bookAuthor,
                              textAlign: TextAlign.center,
                              style: ksubtitleStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
