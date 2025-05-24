import 'package:flutter/material.dart';
import 'package:mobile/features/planer_item/ui/screens/planer_item_page.dart';
import 'package:mobile/model/planer_item.dart';
import 'package:mobile/state/planer_item_state.dart';
import 'package:provider/provider.dart';

import '../../../../state/planer_state.dart';
import '../../../../state/profile_state.dart';

class PlanerItemCardNavigationButton extends StatelessWidget {
  final PlanerItem planerItem;

  const PlanerItemCardNavigationButton({super.key, required this.planerItem});

  @override
  Widget build(BuildContext context) {
    final planerItemState = context.read<PlanerItemState>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(8),
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          onPressed: () async {
            final profileName = context.read<ProfileState>().activeProfile!.name;
            context.read<PlanerItemState>().setActiveItem(planerItem);

            // 🧭 Navigate and wait
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PlanerItemPage()),
            );

            // 🔄 Refresh after returning
            if (context.mounted) {
              await context.read<PlanerState>().fetchPlaner(profileName);
            }
          },
          child: const Text("Manage", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
