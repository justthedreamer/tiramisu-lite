import 'package:flutter/material.dart';
import 'package:mobile/features/planer/ui/widgets/planer_item_card_header.dart';
import 'package:mobile/features/planer/ui/widgets/planer_item_card_meals.dart';
import 'package:mobile/features/planer/ui/widgets/planer_item_card_summary.dart';
import 'package:mobile/shared/helpers/container_helper.dart';
import 'package:mobile/state/planer_item_state.dart';
import 'package:provider/provider.dart';

import '../../../../model/planer_item.dart';
import 'planer_item_card_navigation_button.dart';

class PlanerItemCard extends StatelessWidget {
  final PlanerItem planerItem;
  final VoidCallback? onTap;

  const PlanerItemCard({super.key, required this.planerItem, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ContainerHelper.getCommonEdgeInsets(),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          PlanerItemCardHeader(
            title: planerItem.title,
            eatTime: planerItem.eatTime,
            notify: planerItem.notify,
          ),
          PlanerItemCardMeals(meals: planerItem.meals),
          const Divider(),
          PlanerItemCardSummary(kcalSummary: planerItem.kcalSummary),
          PlanerItemCardNavigationButton(planerItem: planerItem),
        ],
      ),
    );
  }
}
