import 'package:flutter/foundation.dart';

class ViewStateNotifier extends ChangeNotifier {
  bool _isGridView = false;

  bool get isGridView => _isGridView;

  void toggleView() {
    _isGridView = !_isGridView;
    notifyListeners();
  }
}
