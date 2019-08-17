import 'package:flutter/material.dart';
import 'package:ourESchool/UI/Utility/constants.dart';

class CustomRadioButton extends StatefulWidget {
  CustomRadioButton(
      {this.buttonLables,
      this.buttonValues,
      this.radioButtonValue,
      this.buttonColor,
      this.selectedColor,
      this.hight = 35,
      this.width = 100,
      this.horizontal = false,
      this.shape})
      : assert(buttonLables.length == buttonValues.length),
        assert(buttonColor != null),
        assert(selectedColor != null);

  final bool horizontal;

  final List buttonValues;

  final double hight;
  final double width;

  final List<String> buttonLables;

  final Function(dynamic) radioButtonValue;

  final Color selectedColor;

  final Color buttonColor;
  final ShapeBorder shape;

  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  int currentSelected = 0;
  String currentSelectedLabel;

  @override
  void initState() {
    super.initState();
    currentSelectedLabel = widget.buttonLables[0];
  }

  List<Widget> buildButtonsColumn() {
    List<Widget> buttons = [];
    for (int index = 0; index < widget.buttonLables.length; index++) {
      var button = Expanded(
        // flex: 1,
        child: Card(
          color: currentSelectedLabel == widget.buttonLables[index]
              ? widget.selectedColor
              : widget.buttonColor,
          elevation: 10,
          shape: widget.shape == null
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                )
              : widget.shape,
          child: Container(
            height: widget.hight,
            // width: widget.width,
            // constraints: BoxConstraints(maxWidth: 250),
            child: MaterialButton(
              // minWidth: 300,
              // elevation: 10,
              shape: widget.shape == null
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    )
                  : widget.shape,
              onPressed: () {
                widget.radioButtonValue(widget.buttonValues[index]);
                setState(() {
                  currentSelected = index;
                  currentSelectedLabel = widget.buttonLables[index];
                });
              },
              child: Text(
                widget.buttonLables[index],
                style: TextStyle(
                  color: currentSelectedLabel == widget.buttonLables[index]
                      ? Colors.white
                      : Theme.of(context).textTheme.body1.color,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      );
      buttons.add(button);
    }
    return buttons;
  }

  List<Widget> buildButtonsRow() {
    List<Widget> buttons = [];
    for (int index = 0; index < widget.buttonLables.length; index++) {
      var button = Expanded(
        // flex: 1,
        child: Card(
          color: currentSelectedLabel == widget.buttonLables[index]
              ? widget.selectedColor
              : widget.buttonColor,
          elevation: 10,
          shape: kRoundedButtonShape,
          child: Container(
            height: widget.hight,
            // width: 200,
            constraints: BoxConstraints(maxWidth: 250),
            child: MaterialButton(
              // minWidth: 300,
              // elevation: 10,
              shape: kRoundedButtonShape,
              onPressed: () {
                widget.radioButtonValue(widget.buttonValues[index]);
                setState(() {
                  currentSelected = index;
                  currentSelectedLabel = widget.buttonLables[index];
                });
              },
              child: Text(
                widget.buttonLables[index],
                style: TextStyle(
                  color: currentSelectedLabel == widget.buttonLables[index]
                      ? Colors.white
                      : Theme.of(context).textTheme.body1.color,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      );
      buttons.add(button);
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.horizontal
          ? widget.hight * (widget.buttonLables.length + 0.5)
          : null,
      child: Center(
        child: widget.horizontal
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buildButtonsColumn(),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: buildButtonsRow(),
              ),
      ),
    );

    // return Container(
    //   height: 50,
    //   child: ListView.builder(
    //     itemCount: widget.buttonLables.length,
    //     scrollDirection: Axis.horizontal,
    //     itemBuilder: (context, index) => Card(
    //       color: index == currentSelected
    //           ? widget.selectedColor
    //           : widget.buttonColor,
    //       elevation: 10,
    //       shape: kRoundedButtonShape,
    //       child: Container(
    //         height: 40,
    //         // width: 200,
    //         constraints: BoxConstraints(maxWidth: 250),
    //         child: MaterialButton(
    //           // minWidth: 300,
    //           // elevation: 10,
    //           shape: kRoundedButtonShape,
    //           onPressed: () {
    //             widget.radioButtonValue(widget.buttonValues[index]);
    //             setState(() {
    //               currentSelected = index;
    //             });
    //           },
    //           child: Text(
    //             widget.buttonLables[index],
    //             style: TextStyle(
    //               color: index == currentSelected
    //                   ? Colors.white
    //                   : Theme.of(context).textTheme.body1.color,
    //               fontSize: 15,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
