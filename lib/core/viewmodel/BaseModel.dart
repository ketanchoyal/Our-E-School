import 'package:flutter/widgets.dart';
import 'package:ourESchool/core/enums/ViewState.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  ViewState _state2 = ViewState.Idle;

  ViewState get state => _state;
  ViewState get state2 => _state2;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setState2(ViewState viewState) {
    _state2 = viewState;
    notifyListeners();
  }
}