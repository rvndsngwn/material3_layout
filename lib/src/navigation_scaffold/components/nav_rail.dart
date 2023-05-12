import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material3_layout/material3_layout.dart';

import '../navigation_scaffold_controller.dart';
import 'theme_switcher_button.dart';

/// Widget that builds the navigation rail of the NavigationScaffold.
class NavRail extends HookConsumerWidget {
  /// The primary navigation settings for the navigation rail.
  final RailAndBottomSettings settings;

  /// A callback function that is called when a destination is selected.
  final void Function(int)? onDestinationSelected;

  final void Function()? onTapThemeSwitcherButton;

  const NavRail({
    Key? key,
    required this.settings,
    required this.onDestinationSelected,
    required this.onTapThemeSwitcherButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationScaffoldControllerProvider);
    final controller = ref.watch(navigationScaffoldControllerProvider.notifier);
    final state = useState(false);
    return Stack(
      children: [
        NavigationRail(
          backgroundColor: ElevationOverlay.applySurfaceTint(
            controller.theme.colorScheme.surface,
            controller.theme.colorScheme.surfaceTint,
            2,
          ),
          groupAlignment: settings.groupAlignment,
          labelType: settings.labelType,
          leading: _buildLeading(state),
          trailing: settings.trailing,
          extended: state.value,
          destinations: railDestinations,
          selectedIndex: selectedIndex,
          onDestinationSelected: (int index) {
            if (onDestinationSelected != null) {
              onDestinationSelected!(index);
            }
            controller.setIndex = index;
          },
        ),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Visibility(
            visible: settings.addThemeSwitcherTrailingIcon,
            child: ThemeSwitcherButton(
              onTap: onTapThemeSwitcherButton,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the leading widget of the navigation rail.
  ///
  /// If [settings.leading] is not null, it returns that widget. Otherwise, it
  /// returns an IconButton with the menu or menu_open icon depending on the
  /// state of the [state].
  Widget? _buildLeading(ValueNotifier<bool> state) {
    if (settings.leading != null) {
      return settings.leading!;
    } else if (settings.showMenuIcon) {
      return IconButton(
        onPressed: () => state.value = !state.value,
        icon: Icon(!state.value ? Icons.menu : Icons.menu_open),
      );
    } else {
      return null;
    }
  }

  /// Converts the [settings.destinations] into a list of
  /// [NavigationRailDestination]s.
  ///
  /// This method maps each destination in [settings.destinations] to a
  /// [NavigationRailDestination] using the
  /// [toNavigationRailDestination] extension method. If the index of the
  /// destination is 0 and [settings.groupAlignment] is -1, it sets the top
  /// margin to 28. If the index is the last in the list and
  /// [settings.groupAlignment] is 1.0, it sets the bottom margin to 56. If
  /// neither of these conditions is met, it does not set a margin.
  List<NavigationRailDestination> get railDestinations {
    return List.generate(settings.destinations.length, (index) {
      if (index == 0 && settings.groupAlignment == -1) {
        return (settings.destinations[index])
            .toNavigationRailDestination(const EdgeInsets.only(top: 28));
      } else if (index == settings.destinations.length - 1 &&
          settings.groupAlignment == 1.0) {
        return (settings.destinations[index]).toNavigationRailDestination(
          const EdgeInsets.only(bottom: 56),
        );
      } else {
        return (settings.destinations[index]).toNavigationRailDestination(null);
      }
    });
  }
}
