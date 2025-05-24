import 'package:flutter/cupertino.dart';

import '../model/profile.dart';
import '../shared/clients/profile_client.dart';

class ProfileState extends ChangeNotifier {
  List<Profile> _profiles = [];
  Profile? _activeProfile;
  String? error;
  bool loading = false;

  List<Profile> get profiles => _profiles;
  Profile? get activeProfile => _activeProfile;

  void setProfiles(List<Profile> profiles) {
    _profiles = profiles;
    notifyListeners();
  }

  void setActiveProfile(Profile? profile) {
    _activeProfile = profile;
    notifyListeners();
  }

  Future<void> fetchProfiles() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      final fetched = await ProfileClient.fetch();
      _profiles = fetched;
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }
}
