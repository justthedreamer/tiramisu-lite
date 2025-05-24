import '../../../shared/clients/profile_client.dart';
import '../../../state/profile_state.dart';

class ProfileDeleteService {
  static Future<String?> deleteProfile({
    required ProfileState profileState,
    required String profileName,
  }) async {
    try {
      await ProfileClient.delete(profileName);
      profileState.setActiveProfile(null);
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}

