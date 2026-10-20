import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/state/app_state.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  // Presentation registry tracking layout indexing array configurations
  static const List<Widget> _appScreens = [HomeScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        // Key injection forces the structural engine to run animations cleanly
        child: KeyedSubtree(
          key: ValueKey<int>(appState.activeTabIndex),
          child: _appScreens[appState.activeTabIndex],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: appState.activeTabIndex,
        onDestinationSelected: (index) => appState.updateTabIndex(index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
