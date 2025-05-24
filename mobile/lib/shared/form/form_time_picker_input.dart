import 'package:flutter/material.dart';

class TimePickerInput extends StatefulWidget {
  final TimeOfDay? initialTime;
  final void Function(TimeOfDay) onTimeChanged;
  final String label;

  const TimePickerInput({
    super.key,
    this.initialTime,
    required this.onTimeChanged,
    this.label = "Time",
  });

  @override
  State<TimePickerInput> createState() => _TimePickerInputState();
}

class _TimePickerInputState extends State<TimePickerInput> {
  late TimeOfDay _selectedTime;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime ?? TimeOfDay.now();
    widget.onTimeChanged(_selectedTime);
    _updateController();
  }

  void _updateController() {
    final hour = _selectedTime.hour.toString().padLeft(2, '0');
    final minute = _selectedTime.minute.toString().padLeft(2, '0');
    _controller.text = "$hour:$minute";
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _updateController();
      });
      widget.onTimeChanged(_selectedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        suffixIcon: const Icon(Icons.access_time),
      ),
      onTap: _pickTime,
      validator:
          (value) =>
              value == null || value.isEmpty ? "Please select a time" : null,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
