import 'package:flutter/material.dart';
import 'package:mobile/features/common/ui/builders/app_bar_builder.dart';
import 'package:mobile/features/planer/ui/widgets/planer_date_navigation.dart';
import 'package:mobile/features/planer/ui/widgets/planer_item_list.dart';
import 'package:mobile/features/planer/ui/screens/planer_form.dart';
import 'package:mobile/state/planer_state.dart';
import 'package:mobile/state/profile_state.dart';
import 'package:provider/provider.dart';

class PlanerPage extends StatelessWidget {
  const PlanerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder().withTitle("Planer").build(),
      body: Column(
        children: const [
          PlanerDateNavigation(),
          Expanded(child: PlanerItemList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const PlanerForm()),
          );

          final profileName =
              context.read<ProfileState>().activeProfile?.name;
          if (profileName != null && context.mounted) {
            context.read<PlanerState>().fetchPlaner(profileName);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}