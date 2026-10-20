import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/state/app_state.dart';
import 'screens/splash_screen.dart';
import 'screens/loading_screen.dart'; // 🔥 Import the new screen
import 'widgets/main_layout.dart';

class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    // 🗺️ Global State Route Switchboard
    if (appState.isSplashActive) {
      return const SplashScreen();
    }

    if (appState.isFetching) {
      return const LoadingScreen(); // 🔥 Seamlessly trap loading state globally
    }

    return const MainLayout();
  }
}
