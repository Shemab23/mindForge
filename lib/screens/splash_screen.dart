import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/state/app_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🎨 Extracting the centralized design token system from context
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'MINDFORGE',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  CircularProgressIndicator(color: theme.colorScheme.primary),
                  const SizedBox(height: 16),
                  Text(
                    'Initializing Guarded Systems...',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 24,
              right: 24,
              child: TextButton(
                onPressed: () => context.read<AppState>().skipSplash(),
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.secondary,
                ),
                child: const Text('Skip Entry ⚡'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
