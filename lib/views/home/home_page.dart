import 'package:flutter/material.dart';
import 'package:palette_generator/controllers/controllers.dart';
import 'package:palette_generator/views/views.dart';
import 'package:palette_generator/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PaletteGeneratorController(),
      child: const Scaffold(
        body: Row(
          children: [
            HomeSidebar(),
            Expanded(
              child: HomeShowcase(),
            ),
          ],
        ),
      ),
    );
  }
}
