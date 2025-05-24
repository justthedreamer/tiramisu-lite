import 'package:flutter/material.dart';
import 'package:mobile/features/common/ui/builders/app_bar_builder.dart';
import 'package:mobile/state/profile_state.dart';
import 'package:provider/provider.dart';
import '../../../../state/planer_item_state.dart';
import '../widgets/planer_item_content.dart';

class PlanerItemPage extends StatefulWidget {
  const PlanerItemPage({super.key});

  @override
  State<PlanerItemPage> createState() => _PlanerItemPageState();
}

class _PlanerItemPageState extends State<PlanerItemPage> {
  late final PlanerItemState planerItemState;

  @override
  void initState() {
    super.initState();
    planerItemState = context.read<PlanerItemState>();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      planerItemState.setActiveItem(null);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileName = context.select<ProfileState, String>(
          (profileState) => profileState.activeProfile!.name,
    );

    return Scaffold(
      appBar: AppBarBuilder().withTitle("Planer item").build(),
      body: PlanerItemContent(profileName: profileName),
    );
  }
}
