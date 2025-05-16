import 'package:flutter/material.dart';
import 'package:mobile/model/profile.dart';

import '../../../shared/clients/profile_client.dart';

class CreateProfileForm extends StatefulWidget {
  final void Function(String result) onSuccess; // Callback to parent
  final void Function(String result) onFailure; // Callback to parent

  const CreateProfileForm({
    super.key,
    required this.onSuccess,
    required this.onFailure,
  });

  @override
  State<CreateProfileForm> createState() => _CreateProfileFormState();
}

class _CreateProfileFormState extends State<CreateProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _avatarBase64Controller = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _avatarBase64Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: _buildInputDecoration(label: "Name"),
            validator: (value) => _validateName(value),
          ),
          TextFormField(
            controller: _avatarBase64Controller,
            decoration: _buildInputDecoration(label: "Avatar (Base64)"),
            validator: (value) => _validateAvatar(value),
          ),
          ElevatedButton.icon(
            onPressed: _submitting ? null : _submit,
            icon: _submitIcon(),
            label: const Text('Create'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _submitting = true;
    });

    final profile = Profile(
      name: _nameController.text,
      avatarBase64: _avatarBase64Controller.text,
    );

    final result = await ProfileClient.create(profile);

    setState(() {
      _submitting = false;
    });

    if (!mounted) {
      return;
    }

    if (result) {
      widget.onSuccess("Profile created");
    } else {
      widget.onFailure("Failed to create profile");
    }
  }

  String? _validateName(String? name) {
    if (name == null || name.isEmpty) {
      return "Enter name...";
    }
    return null;
  }

  String? _validateAvatar(String? avatar) {
    if (avatar == null || avatar.isEmpty) {
      return "Enter avatar...";
    }
    return null;
  }

  InputDecoration _buildInputDecoration({required String label}) {
    return InputDecoration(labelText: label, border: OutlineInputBorder());
  }

  Widget _submitIcon() {
    if (_submitting) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
      );
    } else {
      return const Icon(Icons.save);
    }
  }
}
