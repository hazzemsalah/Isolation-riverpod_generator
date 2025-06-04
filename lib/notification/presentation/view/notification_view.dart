import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_project/core/utils/notification_state_ext.dart';
import '../../../core/di_module/module.dart';
import '../viewmodel/notification_viewmodel.dart';
import '../widgets/notification_list_item.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(notificationNotifierProvider);
        final viewModel = ref.read(notificationViewModelProvider.notifier);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Notifications'),
            actions: [
              IconButton(
                onPressed: viewModel.resetNotifications,
                icon: const Icon(Icons.refresh),
                tooltip: 'Reset',
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: state.maybeWhen(
                      loading: () => null,
                      orElse: () => viewModel.fetchNotifications,
                    ),
                    icon: const Icon(Icons.download),
                    label: const Text('Fetch Notifications'),
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: viewModel.fetchNotifications,
                  child: state.when(
                    initial: () => const _EmptyWidget('Tap to fetch notifications'),
                    loading: () => const _LoadingWidget(),
                    loaded: (notifications) => notifications.isEmpty
                        ? const _EmptyWidget('No notifications available')
                        : NotificationList(notifications: notifications),
                    error: (message) => _ErrorWidget(
                      message: message,
                      onRetry: viewModel.fetchNotifications,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading notifications...'),
        ],
      ),
    );
  }
}

class _EmptyWidget extends StatelessWidget {
  final String message;

  const _EmptyWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.notifications_none, size: 64),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorWidget({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text('Error: $message', textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
