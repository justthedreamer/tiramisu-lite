import 'package:flutter/material.dart';
import 'package:mobile/features/shopping_list/ui/screens/create_shopping_list_page.dart';
import 'package:mobile/features/shopping_list/ui/screens/shopping_list_details_page.dart';
import 'package:provider/provider.dart';
import '../../../../state/shopping_list_state.dart';
import '../../../../state/profile_state.dart';
import '../widgets/shopping_list_widget.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  ShoppingListState? _state;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_state == null) {
      final profileName = context.read<ProfileState>().activeProfile!.name;
      _state = ShoppingListState(profileName: profileName);
      _state!.fetchLists();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_state == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return ChangeNotifierProvider.value(
      value: _state!,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final profileState = context.read<ProfileState>();

            await Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => ChangeNotifierProvider(
                      create:
                          (_) => ShoppingListState(
                            profileName: profileState.activeProfile!.name,
                          ),
                      child: const CreateShoppingListPage(),
                    ),
              ),
            );
            _state!.fetchLists();
          },
          tooltip: 'New list',
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(title: const Text('Shopping Lists')),
        body: Consumer<ShoppingListState>(
          builder: (context, state, _) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) return Center(child: Text(state.error!));
            if (state.lists.isEmpty) {
              return const Center(child: Text('No shopping lists found.'));
            }

            return ListView.builder(
              itemCount: state.lists.length,
              itemBuilder: (context, index) {
                final list = state.lists[index];
                return ShoppingListWidget(
                  shoppingList: list,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => ShoppingListDetailsPage(
                              shoppingListId: list.id,
                            ),
                      ),
                    ).then((_) => state.fetchLists());
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
