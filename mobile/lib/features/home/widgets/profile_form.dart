import 'package:flutter/material.dart';
import '../logic/profile_form_controller.dart';

class CreateProfileForm extends StatefulWidget {
  const CreateProfileForm({super.key});

  @override
  State<CreateProfileForm> createState() => _CreateProfileFormState();
}

class _CreateProfileFormState extends State<CreateProfileForm> {
  late final CreateProfileFormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CreateProfileFormController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _controller.formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: _controller.nameController,
            decoration: _inputDecoration("Name"),
            validator: _controller.validateName,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controller.avatarController,
            decoration: _inputDecoration("Avatar (Base64)"),
            validator: _controller.validateAvatar,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => _handleSubmit(context),
            icon: const Icon(Icons.save),
            label: const Text("Create"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    );
  }

  Future<void> _handleSubmit(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final success = await _controller.submit(context);

    if (!context.mounted) return;

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? "Profile created" : "Failed to create profile"),
      ),
    );

    if (success) Navigator.pop(context);
  }
}
