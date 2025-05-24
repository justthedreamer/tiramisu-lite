import 'package:flutter/cupertino.dart';

import '../model/planer.dart';
import '../model/planer_item.dart';
import '../shared/clients/planer_client.dart';

class PlanerState extends ChangeNotifier {
  Planer? _planer;
  List<PlanerItem> _filteredItems = [];
  DateTime _currentDate = DateTime.now();
  bool _isLoading = false;
  String? _errorMessage;

  Planer? get planer => _planer;
  List<PlanerItem> get items => _filteredItems;
  DateTime get currentDate => _currentDate;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPlaner(String profileName) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _planer = await PlanerClient.fetchPlaner(profileName);
      _updateFilteredItems();
    } catch (e) {
      _errorMessage = e.toString();
      _filteredItems = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void incrementDate() {
    _setCurrentDate(_currentDate.add(const Duration(days: 1)));
  }

  void decrementDate() {
    _setCurrentDate(_currentDate.subtract(const Duration(days: 1)));
  }

  void _setCurrentDate(DateTime date) {
    _currentDate = date;
    _updateFilteredItems();
    notifyListeners();
  }

  void _updateFilteredItems() {
    if (_planer == null) {
      _filteredItems = [];
      return;
    }

    _filteredItems = _planer!.items
        .where((item) => _isSameDay(item.eatTime, _currentDate))
        .toList();
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}