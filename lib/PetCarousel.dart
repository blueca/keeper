import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselDemo extends StatelessWidget {
  CarouselController buttonCarouselController = CarouselController();
  CarouselDemo({this.changeCreatureName});

  int currentPage = 0;
  int totalCreatures = 2;
  Function(String) changeCreatureName;

  changePage(number) {
    currentPage = currentPage + number;
    if (currentPage + 1 > totalCreatures) {
      currentPage = currentPage - totalCreatures;
    } else if (currentPage == -1) {
      currentPage = totalCreatures - 1;
    }
    print(currentPage);
  }

  @override
  Widget build(BuildContext context) => Row(children: <Widget>[
        RaisedButton(
          onPressed: () {
            buttonCarouselController.previousPage(
                duration: Duration(milliseconds: 300), curve: Curves.ease);
            changePage(-1);
          },
          child: Text('←'),
        ),
        Container(
          width: 180,
          child: CarouselSlider(
            items: <Widget>[
              Image.asset('images/pixil-cat.png'),
              Image.asset('images/pixil-bat.png'),
            ],
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: false,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
              initialPage: currentPage,
            ),
          ),
        ),
        RaisedButton(
          onPressed: () {
            buttonCarouselController.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.ease);
            changePage(1);
          },
          child: Text('→'),
        )
      ]);
}
