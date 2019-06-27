library country_code_picker;

import 'custom_country_code.dart';
import 'custom_country_codes.dart';
import 'custom_selected_dialog.dart';
import 'package:flutter/material.dart';

export 'custom_country_code.dart';

class CountryCodePicker extends StatefulWidget {
  final ValueChanged<CountryCode> onChanged;
  final String initialSelection;
  final List<String> favorite;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final bool showCountryOnly;

  CountryCodePicker({
    this.onChanged,
    this.initialSelection,
    this.favorite = const [],
    this.textStyle,
    this.padding = const EdgeInsets.all(0.0),
    this.showCountryOnly = true,
  });

  @override
  State<StatefulWidget> createState() {
    List<Map> jsonList = codes;

    List<CountryCode> elements = jsonList
        .map((s) => new CountryCode(
              name: s['name'],
              code: s['code'],
              dialCode: s['dial_code'],
              flagUri: 'flags/${s['code'].toLowerCase()}.png',
            ))
        .toList();

    return new _CountryCodePickerState(elements);
  }
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  CountryCode selectedItem;
  List<CountryCode> elements = [];
  List<CountryCode> favoriteElements = [];

  _CountryCodePickerState(this.elements);

  @override
  Widget build(BuildContext context) => new FloatingActionButton(
        child: Icon(
          Icons.flag,
          color: Theme.of(context).accentColor,
        ),
        onPressed: _showSelectionDialog,
        shape: RoundedRectangleBorder(
            
            side: Divider.createBorderSide(context,
            color: Theme.of(context).primaryIconTheme.color.withOpacity(0.4),
        )),
        elevation: 4.0,
        backgroundColor: Theme.of(context).canvasColor
        
      );
  @override
  initState() {
    // if (widget.initialSelection != null) {
    //   selectedItem = elements.firstWhere(
    //       (e) =>
    //           (e.code.toUpperCase() == widget.initialSelection.toUpperCase()) ||
    //           (e.dialCode == widget.initialSelection.toString()),
    //       orElse: () => elements[0]);
    // } 
    // else {
    //   selectedItem = elements[0];
    // }

    favoriteElements = elements
        .where((e) =>
            widget.favorite.firstWhere(
                (f) => e.code == f.toUpperCase() || e.dialCode == f.toString(),
                orElse: () => null) !=
            null)

        .toList();
    super.initState();

    if (mounted) {
      _publishSelection(selectedItem);
    }
  }

  void _showSelectionDialog() {
    showDialog(
      context: context,
      builder: (_) => new SelectionDialog(
          elements, favoriteElements, widget.showCountryOnly),
    ).then((e) {
      if (e != null) {
        setState(() {
          selectedItem = e;
        });

        _publishSelection(e);
      }
    });
  }

  void _publishSelection(CountryCode e) {
    if (widget.onChanged != null) {
      widget.onChanged(e);
    }
  }
}
