import 'custom_country_code.dart';
import 'package:flutter/material.dart';

/// selection dialog used for selection of the country code
class SelectionDialog extends StatefulWidget {
  final List<CountryCode> elements;
  final bool showCountryOnly;

  /// elements passed as favorite
  final List<CountryCode> favoriteElements;

  SelectionDialog(this.elements, this.favoriteElements, this.showCountryOnly);

  @override
  State<StatefulWidget> createState() => new _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  /// this is useful for filtering purpose
  List<CountryCode> showedElements = [];

  @override
  Widget build(BuildContext context) => new SimpleDialog(
      title: new Column(
        children: <Widget>[
          new TextField(
            decoration: new InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                )),
                prefixIcon: new Icon(
                  Icons.search,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                )),
            onChanged: _filterElements,
          ),
        ],
      ),
      children: [
        widget.favoriteElements.isEmpty
            ? new Container()
            : new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[]
                  ..addAll(widget.favoriteElements
                      .map(
                        (f) => new SimpleDialogOption(
                              child: Flex(
                                direction: Axis.horizontal,
                                children: <Widget>[
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: new Text(
                                        widget.showCountryOnly
                                            ? f.toCountryString()
                                            : f.toLongString(),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.fade,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline
                                            .copyWith(fontSize: 14.0)),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                _selectItem(f);
                              },
                            ),
                      )
                      .toList())
                  ..add(new Divider())),
      ]..addAll(showedElements
          .map(
            (e) => new SimpleDialogOption(
                  key: Key(e.toLongString()),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                            widget.showCountryOnly
                                ? e.toCountryString()
                                : e.toLongString(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                            style: Theme.of(context)
                                .textTheme
                                .headline
                                .copyWith(fontSize: 14.0)),
                      ),
                    ],
                  ),
                  onPressed: () {
                    _selectItem(e);
                  },
                ),
          )
          .toList()));

  @override
  void initState() {
    showedElements = widget.elements;
    super.initState();
  }

  void _filterElements(String s) {
    s = s.toUpperCase();
    setState(() {
      showedElements = widget.elements
          .where((e) =>
              e.code.contains(s) ||
              e.dialCode.contains(s) ||
              e.name.toUpperCase().contains(s))
          .toList();
    });
  }

  void _selectItem(CountryCode e) {
    Navigator.pop(context, e);
  }
}
