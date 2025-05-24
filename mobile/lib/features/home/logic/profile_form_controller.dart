import 'package:flutter/material.dart';
import 'package:mobile/model/profile.dart';
import 'package:provider/provider.dart';
import '../../../shared/clients/profile_client.dart';
import '../../../state/profile_state.dart';

class CreateProfileFormController extends ChangeNotifier {
  final nameController = TextEditingController();
  final avatarController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? error;

  Future<bool> submit(BuildContext context) async {
    error = null;
    if (!formKey.currentState!.validate()) return false;

    final profile = Profile(
      name: nameController.text,
      avatarBase64: avatarController.text,
    );

    try {
      await ProfileClient.create(profile);

      if (context.mounted) {
        await context.read<ProfileState>().fetchProfiles();
      }
      return true;
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    avatarController.dispose();
    super.dispose();
  }

  String? validateName(String? name) {
    if (name == null || name.isEmpty) return "Enter name...";
    return null;
  }

  String? validateAvatar(String? avatar) {
    if (avatar == null || avatar.isEmpty) return "Enter avatar...";
    return null;
  }
}
