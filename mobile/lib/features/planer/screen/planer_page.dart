import 'package:flutter/material.dart';
import 'package:mobile/features/common/ui/builders/app_bar_builder.dart';

import '../../../shared/helpers/container_helper.dart';

class PlanerPage extends StatefulWidget {
  const PlanerPage({super.key});

  @override
  State<StatefulWidget> createState() => _PlanerPageState();
}

class _PlanerPageState extends State<PlanerPage> {
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
              Text("Planer"),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
