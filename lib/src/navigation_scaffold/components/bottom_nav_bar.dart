import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material3_layout/material3_layout.dart';
import 'package:material3_layout/src/navigation_scaffold/navigation_scaffold_controller.dart';

/// A widget that displays a navigation bar with customizable destinations
/// based on the provided [settings] in a [NavigationScaffold].
///
/// The navigation bar automatically updates the selected destination based
/// on the [selectedIndex] value in the [NavigationScaffoldController].
///
/// When a destination is selected, the [onDestinationSelected] callback is called
/// with the index of the selected destination.
class BottomNavBar extends HookConsumerWidget {
  /// The primary navigation settings for the navigation bar.
  final RailAndBottomSettings settings;

  /// A callback function that is called when a destination is selected.
  final void Function(int)? onDestinationSelected;

  const BottomNavBar({
    Key? key,
    required this.settings,
    this.onDestinationSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationScaffoldControllerProvider);
    return NavigationBar(
      destinations: settings.destinations
          .map((e) => (e).toNavigationDestination())
          .toList(),
      selectedIndex: selectedIndex,
      onDestinationSelected: (int index) {
        if (index == selectedIndex) {
          return;
        }
        if (onDestinationSelected != null) {
          onDestinationSelected!(index);
        }
        ref.read(navigationScaffoldControllerProvider.notifier).setIndex =
            index;
      },
    );
  }
}
