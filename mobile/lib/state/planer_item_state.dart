import 'package:flutter/material.dart';
import 'package:mobile/model/planer_item.dart';
import 'package:mobile/shared/clients/planer_item_client.dart';

class PlanerItemState extends ChangeNotifier {
  PlanerItem? _item;

  PlanerItem? get item => _item;

  bool get hasActiveItem => _item != null;

  void setActiveItem(PlanerItem? item) {
    _item = item;
    notifyListeners();
  }

  void clearActiveItem() {
    _item = null;
    notifyListeners();
  }

  Future<String?> updateTitle(String profileName, String title) async {
    if (_item == null) return "No active item.";

    try {
      final updatedItem = _item!.copyWith(title: title);
      await PlanerItemClient.updateItem(profileName, updatedItem);
      _item = updatedItem;
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> updateEatTime(String profileName, DateTime newTime) async {
    if (_item == null) return "No active item.";

    try {
      final updatedItem = _item!.copyWith(eatTime: newTime);
      await PlanerItemClient.updateItem(profileName, updatedItem);
      _item = updatedItem;
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> toggleNotify(String profileName) async {
    if (_item == null) return "No active item.";

    try {
      final updatedItem = _item!.copyWith(notify: !_item!.notify);
      await PlanerItemClient.updateItem(profileName, updatedItem);
      _item = updatedItem;
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> deleteItem(String profileName) async {
    if (_item == null) return "No active item.";

    try {
      await PlanerItemClient.deleteItem(profileName, _item!.id);
      _item = null;
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
