import 'package:flutter/material.dart';
import 'package:mobile/shared/helpers/date_helper.dart';
import 'package:mobile/state/planer_state.dart';
import 'package:mobile/state/profile_state.dart';
import 'package:provider/provider.dart';

import '../../../../shared/helpers/container_helper.dart';

class PlanerHeader extends StatefulWidget {
  const PlanerHeader({super.key});

  @override
  State<StatefulWidget> createState() => _PlanerHeaderState();
}

class _PlanerHeaderState extends State<PlanerHeader> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileState = context.read<ProfileState>();
      final planerState = context.read<PlanerState>();

      if (profileState.activeProfile == null) {
        throw Exception(
          "Cannot create date header because active profile is null.",
        );
      }

      planerState.fetchPlaner(profileState.activeProfile!.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final planerState = context.watch<PlanerState>();

    return Container(
      constraints: ContainerHelper.getCommonBoxConstrain(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 16),
            Text(
              "Planer",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: () => planerState.decrementDate(),
                  icon: Icon(Icons.arrow_left, color: Colors.white70, size: 32),
                ),
                Expanded(
                  child: Text(
                    DateHelper.getDateWithoutTime(planerState.currentDate),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                IconButton(
                  onPressed: () => planerState.incrementDate(),
                  icon: Icon(Icons.arrow_right, color: Colors.white70, size: 32),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
