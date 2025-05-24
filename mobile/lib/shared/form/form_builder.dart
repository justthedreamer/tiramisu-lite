import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormBuilder {
  static Widget buildFormHeader(String title) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  static Widget buildFormSubHeader(String title) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  static Widget buildTextInput({
    Key? key,
    required String label,
    required TextEditingController controller,
    required FormFieldValidator validator,
  }) {
    return TextFormField(
      key: key,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      controller: controller,
      validator: validator,
    );
  }

  static Widget buildExpandedSubmitButton({
    required String label,
    required VoidCallback onPressed,
    Color color = Colors.transparent,
    bool loading = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: loading ? null : onPressed,
            icon:
            loading
                ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: color,
              ),
            )
                : const Icon(Icons.save),
            label: Text(label),
          ),
        ),
      ],
    );
  }

  static Widget buildSpacing() => SizedBox(height: 16);
}
