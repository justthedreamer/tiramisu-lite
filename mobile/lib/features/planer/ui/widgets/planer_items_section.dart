import 'package:flutter/material.dart';
import 'package:mobile/features/planer/ui/widgets/planer_item_card.dart';
import 'package:mobile/state/planer_state.dart';
import 'package:mobile/state/profile_state.dart';
import 'package:provider/provider.dart';

class PlanerItemsSection extends StatefulWidget {
  const PlanerItemsSection({super.key});

  @override
  State<StatefulWidget> createState() => _PlanerItemsSectionState();
}

class _PlanerItemsSectionState extends State<PlanerItemsSection> {
  _PlanerItemsSectionState();

  @override
  Widget build(BuildContext context) {
    var profileState = context.watch<ProfileState>();
    var planerState = context.watch<PlanerState>();

    return Container(
      margin: EdgeInsets.all(10),
      child: RefreshIndicator(
        child: SingleChildScrollView(
          child: Column(
            children:
                planerState.items
                    .map((item) => PlanerItemCard(planerItem: item))
                    .toList(),
          ),
        ),
        onRefresh: () async {
          planerState.fetchPlaner(profileState.activeProfile!.name);
        },
      ),
    );
  }
}