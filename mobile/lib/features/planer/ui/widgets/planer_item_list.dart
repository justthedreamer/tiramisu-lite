import 'package:flutter/material.dart';
import 'package:mobile/features/planer/ui/widgets/planer_item_card.dart';
import 'package:provider/provider.dart';

import '../../../../state/planer_state.dart';
import '../../../../state/profile_state.dart';

class PlanerItemList extends StatefulWidget {
  const PlanerItemList({super.key});

  @override
  State<PlanerItemList> createState() => _PlanerItemListState();
}

class _PlanerItemListState extends State<PlanerItemList> {
  late String profileName;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileName = context.read<ProfileState>().activeProfile!.name;
      context.read<PlanerState>().fetchPlaner(profileName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final planerState = context.watch<PlanerState>();
    if (planerState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (planerState.errorMessage != null) {
      return _ErrorView(
        message: planerState.errorMessage!,
        onRetry: () => planerState.fetchPlaner(profileName),
      );
    }

    return RefreshIndicator(
      onRefresh: () => planerState.fetchPlaner(profileName),
      child:
          planerState.items.isEmpty
              ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(
                    height: 200,
                    child: Center(child: Text("No items for this day.")),
                  ),
                ],
              )
              : ListView.builder(
                itemCount: planerState.items.length,
                itemBuilder: (_, index) {
                  final item = planerState.items[index];
                  return PlanerItemCard(planerItem: item);
                },
              ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text("Retry")),
          ],
        ),
      ),
    );
  }
}
