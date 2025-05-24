import 'package:flutter/material.dart';
import 'package:mobile/features/home/screens/home_page.dart';
import 'package:mobile/state/planer_item_state.dart';
import 'package:mobile/state/planer_state.dart';
import 'package:mobile/state/profile_state.dart';
import 'package:mobile/state/shopping_list_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileState()),
        ChangeNotifierProvider(create: (_) => PlanerState()),
        ChangeNotifierProvider(create: (_) => PlanerItemState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiramisu-lite',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const HomePage(),
    );
  }
}
