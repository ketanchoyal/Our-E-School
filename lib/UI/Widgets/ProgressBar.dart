import 'package:flutter/material.dart';
import 'countdown/CountDown.dart';

class AnimatedProgressbar extends StatelessWidget {
  final double value;
  final double height;
  final bool start;
  final Duration duration;
  final Function onFinish;

  AnimatedProgressbar({Key key, @required this.value, this.height = 12, this.start = false, @required this.duration, this.onFinish})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints box) {
        return Container(
          padding: EdgeInsets.only(left:0, top: 15, right: 5),
          width: box.maxWidth,
          child: Stack(
            children: [
              
              Align(
                alignment: Alignment.topLeft,
                // top: 10,
                // right: 5,
                // left: 5,
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(height),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                // top: 10,
                // right: 5,
                // left: 5,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeOutCubic,
                  height: height,
                  width: box.maxWidth * _floor(value),
                  decoration: BoxDecoration(
                    color: _colorGen(value),
                    borderRadius: BorderRadius.all(
                      Radius.circular(height),
                    ),
                  ),
                ),
              ),
              start ? Align(
                alignment: Alignment.bottomRight,
                child: CountdownFormatted(
                  onFinish: onFinish,
                  duration: duration,
                  builder: (BuildContext ctx, String remaining) {
                    return Text(remaining, style: TextStyle(fontSize: 15),); // 01:00:00
                  },
                ),
              ) : Container(),
            ],
          ),
        );
      },
    );
  }

  /// Always round negative or NaNs to min value
  _floor(double value, [min = 0.0]) {
    return value.sign <= min ? min : value;
  }

  _colorGen(double value) {
    int rbg = (value * 255).toInt();
    return Colors.deepOrange.withGreen(rbg).withRed(255 - rbg);
  }
}
