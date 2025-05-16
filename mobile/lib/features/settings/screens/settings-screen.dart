import 'package:flutter/material.dart';
import 'package:mobile/features/common/ui/builders/app_bar_builder.dart';
import 'package:mobile/features/settings/widges/setting_options.dart';
import 'package:mobile/shared/helpers/container_helper.dart';

import '../../profile/ui/profile_header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder().build(),
      body: Container(
        constraints: ContainerHelper.getCommonBoxConstrain(),
        padding: ContainerHelper.getCommonEdgeInsets(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              ProfileHeader(),
              SizedBox(height: 16),
              SettingOptions(),
            ],
          ),
        ),
      ),
    );
  }
}
