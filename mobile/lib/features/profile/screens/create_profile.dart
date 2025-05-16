import 'package:flutter/material.dart';
import 'package:mobile/features/profile/widgets/profile_form.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CreateProfileForm(onSuccess: _onSuccess, onFailure: _onFailure),
      ),
    );
  }

  void _onSuccess(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
    Navigator.pop(context, true);
  }

  void _onFailure(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}