import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material3_layout/material3_layout.dart';

import '../navigation_scaffold_controller.dart';

/// A custom navigation drawer for the Material3 layout.
class CustomNavigationDrawer extends HookConsumerWidget {
  /// The primary navigation settings for the modal drawer.
  final DrawerSettings settings;

  /// A callback function that is called when a destination is selected.
  final void Function(int)? onDestinationSelected;

  /// A custom navigation drawer for the Material3 layout.
  const CustomNavigationDrawer({
    Key? key,
    required this.settings,
    this.onDestinationSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationScaffoldControllerProvider);
    return NavigationDrawer(
      selectedIndex: selectedIndex,
      onDestinationSelected: (int index) {
        if (onDestinationSelected != null) {
          onDestinationSelected!(index);
        }
        ref.read(navigationScaffoldControllerProvider.notifier).setIndex =
            index;
        Navigator.pop(context);
      },
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
class _NavigationDrawerTitle extends HookConsumerWidget {
  final String title;
  const _NavigationDrawerTitle(this.title);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(navigationScaffoldControllerProvider.notifier);
    return Padding(
      padding: const EdgeInsets.fromLTRB(28.0, 18.0, 8.0, 18.0),
      child: Text(
        title,
        style: controller.theme.textTheme.titleSmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/// Widget for a section header in the navigation drawer.
class _NavigationDraweHeader extends HookConsumerWidget {
  final String label;
  const _NavigationDraweHeader(this.label);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(navigationScaffoldControllerProvider.notifier);
    return Padding(
      padding: const EdgeInsets.fromLTRB(28.0, 18.0, 8.0, 18.0),
      child: Text(
        label,
        style: controller.theme.textTheme.titleSmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

/// Widget for a section divider in the navigation drawer.
class _NavigationDrawerDivider extends HookConsumerWidget {
  const _NavigationDrawerDivider();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(navigationScaffoldControllerProvider.notifier);
    return Divider(
      indent: 28,
      endIndent: 28,
      height: 1,
      thickness: 1,
      color: controller.theme.colorScheme.outlineVariant,
    );
  }
}
