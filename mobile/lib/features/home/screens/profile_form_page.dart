import 'package:flutter/material.dart';

import '../widgets/profile_form.dart';

class CreateProfilePage extends StatelessWidget {
  const CreateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New profile')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: CreateProfileForm(),
      ),
    );
  }
}