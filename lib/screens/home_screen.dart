import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/state/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Type-Safe Architecture')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () => context.read<AppState>().syncVerifiedUsers(),
              icon: const Icon(Icons.shield_outlined),
              label: const Text('Sync Guarded Users'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: state.verifiedUsers.isEmpty
                  ? Center(
                      child: Text(
                        'No users loaded.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.verifiedUsers.length,
                      itemBuilder: (context, index) {
                        // Safe, auto-completed typed item usage
                        final user = state.verifiedUsers[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: CircleAvatar(child: Text('${user.id}')),
                            title: Text(
                              user.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${user.email} • ${user.companyName}',
                            ),
                            trailing: Text(
                              user.city,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
