import 'package:flutter/cupertino.dart';
import 'package:mobile/shared/helpers/container_helper.dart';

class OptionsWrapperBuilder {
  Widget build({required Widget header, required Widget options}) {
    return Center(
      child: Container(
        constraints: ContainerHelper.getCommonBoxConstrain(),
        padding: ContainerHelper.getCommonEdgeInsets(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16), // top header margin
            header,
            const SizedBox(height: 16), // bottom header margin
            Expanded(child: options), // options
            const SizedBox(height: 16), // bottom margin
          ],
        ),
      ),
    );
  }
}
