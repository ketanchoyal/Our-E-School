import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EBook {
  String boodId;
  String imageUrl;
  String pdfUrl;
  String bookName;
  String bookAuthor;
  String bookIsForStandard;
  String subject;
  String description;

  EBook({
    @required this.boodId,
    @required this.bookAuthor,
    this.bookIsForStandard = 'N.A',
    this.subject = 'N.A',
    this.description = 'N.A',
    @required this.bookName,
    @required this.imageUrl,
    @required this.pdfUrl,
  });
}

List<EBook> ebooks = [
  EBook(
    boodId: '1',
    bookAuthor: 'R. J. Palacio',
    bookName: 'Wonder eBook',
    imageUrl: 'https://kbimages1-a.akamaihd.net/792207e2-bd6e-4de4-acce-c6d39fb0445f/353/569/90/False/wonder-4.jpg',
    pdfUrl: 'http://pb03.twirpx.net/2094/2094484_1703F69E/palacio_r_j_wonder.pdf',
    bookIsForStandard: '10',
    subject: 'English',
    description: 'SOON TO BE A MAJOR MOTION PICTURE STARRING JULIA ROBERTS, OWEN WILSON, AND JACOB TREMBLAY! Over 5 million people have read the #1 New York Times bestseller WONDER and have fallen in love with Auggie Pullman, an ordinary boy with an extraordinary face. The book that inspired the Choose Kind movement.'
  ),
  EBook(
    boodId: '2',
    bookAuthor: 'R. J. Palacio',
    bookName: 'Wonder eBook',
    imageUrl: 'https://kbimages1-a.akamaihd.net/792207e2-bd6e-4de4-acce-c6d39fb0445f/353/569/90/False/wonder-4.jpg',
    pdfUrl: 'http://pb03.twirpx.net/2094/2094484_1703F69E/palacio_r_j_wonder.pdf',
    bookIsForStandard: '9',
    subject: 'Maths',
    description: 'SOON TO BE A MAJOR MOTION PICTURE STARRING JULIA ROBERTS, OWEN WILSON, AND JACOB TREMBLAY! Over 5 million people have read the #1 New York Times bestseller WONDER and have fallen in love with Auggie Pullman, an ordinary boy with an extraordinary face. The book that inspired the Choose Kind movement.'
  ),
  EBook(
    boodId: '3',
    bookAuthor: 'R. J. Palacio',
    bookName: 'Wonder eBook',
    imageUrl: 'https://kbimages1-a.akamaihd.net/792207e2-bd6e-4de4-acce-c6d39fb0445f/353/569/90/False/wonder-4.jpg',
    pdfUrl: 'http://pb03.twirpx.net/2094/2094484_1703F69E/palacio_r_j_wonder.pdf',
    bookIsForStandard: '5',
    subject: 'Env'
  ),
  EBook(
    boodId: '4',
    bookAuthor: 'R. J. Palacio',
    bookName: 'Wonder eBook',
    imageUrl: 'https://kbimages1-a.akamaihd.net/792207e2-bd6e-4de4-acce-c6d39fb0445f/353/569/90/False/wonder-4.jpg',
    pdfUrl: 'http://pb03.twirpx.net/2094/2094484_1703F69E/palacio_r_j_wonder.pdf',
    bookIsForStandard: '8',
    subject: 'Social Studies'
  ),
  EBook(
    boodId: '5',
    bookAuthor: 'R. J. Palacio',
    bookName: 'Wonder eBook',
    imageUrl: 'https://kbimages1-a.akamaihd.net/792207e2-bd6e-4de4-acce-c6d39fb0445f/353/569/90/False/wonder-4.jpg',
    pdfUrl: 'http://pb03.twirpx.net/2094/2094484_1703F69E/palacio_r_j_wonder.pdf',
    bookIsForStandard: '7',
    subject: 'Science'
  ),
  EBook(
    boodId: '6',
    bookAuthor: 'R. J. Palacio',
    bookName: 'Wonder eBook',
    imageUrl: 'https://kbimages1-a.akamaihd.net/792207e2-bd6e-4de4-acce-c6d39fb0445f/353/569/90/False/wonder-4.jpg',
    pdfUrl: 'http://pb03.twirpx.net/2094/2094484_1703F69E/palacio_r_j_wonder.pdf',
    description: 'SOON TO BE A MAJOR MOTION PICTURE STARRING JULIA ROBERTS, OWEN WILSON, AND JACOB TREMBLAY! Over 5 million people have read the #1 New York Times bestseller WONDER and have fallen in love with Auggie Pullman, an ordinary boy with an extraordinary face. The book that inspired the Choose Kind movement.',
    // bookIsForStandard: '7',
    // subject: 'Science'
  ),
];
