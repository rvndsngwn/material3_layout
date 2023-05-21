import 'package:flutter/material.dart';
import 'package:material3_layout/material3_layout.dart';

/// A custom navigation drawer for the Material3 layout.
class CustomNavigationDrawer extends StatelessWidget {
  /// The primary navigation settings for the modal drawer.
  final DrawerSettings settings;

  /// A callback function that is called when a destination is selected.
  final void Function(int)? onDestinationSelected;

  final int selectedIndex;

  /// A custom navigation drawer for the Material3 layout.
  const CustomNavigationDrawer({
    Key? key,
    required this.settings,
    this.onDestinationSelected,
    this.selectedIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      children: settings.destinations,
    );
  }

  /// Returns a widget for the drawer title.
  static Widget drawerTitle(String title) {
    return _NavigationDrawerTitle(title);
  }

  /// Returns a widget for a section header.
  static Widget sectionHeader(String title) {
    return _NavigationDraweHeader(title);
  }

  /// Returns a widget for a section divider.
  static Widget sectionDivider() {
    return const _NavigationDrawerDivider();
  }
}

/// Widget for the navigation drawer title.
class _NavigationDrawerTitle extends StatelessWidget {
  final String title;
  const _NavigationDrawerTitle(this.title);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(28.0, 18.0, 8.0, 18.0),
      child: Text(
        title,
        style: theme.textTheme.titleSmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/// Widget for a section header in the navigation drawer.
class _NavigationDraweHeader extends StatelessWidget {
  final String label;
  const _NavigationDraweHeader(this.label);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(28.0, 18.0, 8.0, 18.0),
      child: Text(
        label,
        style: theme.textTheme.titleSmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/// Widget for a section divider in the navigation drawer.
class _NavigationDrawerDivider extends StatelessWidget {
  const _NavigationDrawerDivider();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Divider(
      indent: 28,
      endIndent: 28,
      height: 1,
      thickness: 1,
      color: theme.colorScheme.outlineVariant,
    );
  }
}
