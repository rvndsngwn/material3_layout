import 'package:flutter/material.dart';
import 'package:material3_layout/material3_layout.dart';

/// A widget that displays a navigation bar with customizable destinations
/// based on the provided [settings] in a [NavigationScaffold].
///
/// The navigation bar automatically updates the selected destination based
/// on the [selectedIndex] value in the [NavigationScaffoldController].
///
/// When a destination is selected, the [onDestinationSelected] callback is called
/// with the index of the selected destination.
class BottomNavBar extends StatelessWidget {
  /// The primary navigation settings for the navigation bar.
  final RailAndBottomSettings settings;

  /// A callback function that is called when a destination is selected.
  final void Function(int)? onDestinationSelected;

  final int selectedIndex;

  const BottomNavBar({
    Key? key,
    required this.settings,
    this.onDestinationSelected,
    this.selectedIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: settings.destinations
          .map((e) => (e).toNavigationDestination())
          .toList(),
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
    );
  }
}
