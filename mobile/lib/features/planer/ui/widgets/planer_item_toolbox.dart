import 'package:flutter/material.dart';
import 'package:mobile/features/planer/ui/screens/planer_form.dart';
import 'package:mobile/state/planer_state.dart';
import 'package:provider/provider.dart';

class PlanerItemToolBox extends StatefulWidget {
  const PlanerItemToolBox({super.key});

  @override
  State<StatefulWidget> createState() => _PlanerItemToolBoxState();
}

class _PlanerItemToolBoxState extends State<PlanerItemToolBox> {
  _PlanerItemToolBoxState();

  @override
  Widget build(BuildContext context) {
    var planerState = context.watch<PlanerState>();
    return Row(
      children: [
        SizedBox(width: 8),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _navigateToForm(context, planerState),
            label: Text("Add new items"),
            icon: Icon(Icons.add),
          ),
        ),
        SizedBox(width: 8),
      ],
    );
  }

  Future<void> _navigateToForm(
    BuildContext context,
    PlanerState planerState,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PlanerForm()),
    );
  }
}
