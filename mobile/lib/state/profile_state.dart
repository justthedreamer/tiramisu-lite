import 'package:flutter/cupertino.dart';
import 'package:mobile/model/profile.dart';

import '../shared/clients/profile_client.dart';

class ProfileState extends ChangeNotifier {
  List<Profile> _profiles = [];
  Profile? _activeProfile;

  List<Profile> get profiles => _profiles;

  Profile? get activeProfile => _activeProfile;

  void setProfiles(List<Profile> profiles) {
    _profiles = profiles;
    notifyListeners();
  }

  void setActiveProfile(Profile profile) {
    _activeProfile = profile;
    notifyListeners();
  }

  Future<void> fetchProfiles() async {
    List<Profile> profiles = await ProfileClient.fetch();
    setProfiles(profiles);
  }
}
