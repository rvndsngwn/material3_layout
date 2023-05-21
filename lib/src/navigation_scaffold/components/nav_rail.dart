import 'package:flutter/material.dart';
import 'package:material3_layout/material3_layout.dart';

import 'theme_switcher_button.dart';

/// Widget that builds the navigation rail of the NavigationScaffold.
class NavRail extends StatefulWidget {
  /// The primary navigation settings for the navigation rail.
  final RailAndBottomSettings settings;

  /// A callback function that is called when a destination is selected.
  final void Function(int)? onDestinationSelected;

  final void Function()? onTapThemeSwitcherButton;

  final int selectedIndex;

  const NavRail({
    Key? key,
    required this.settings,
    required this.onDestinationSelected,
    required this.onTapThemeSwitcherButton,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<NavRail> createState() => _NavRailState();
}

class _NavRailState extends State<NavRail> {
  ValueNotifier<bool> isExtended = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        ValueListenableBuilder<bool>(
            valueListenable: isExtended,
            builder: (context, value, child) {
              return NavigationRail(
                backgroundColor: ElevationOverlay.applySurfaceTint(
                  theme.colorScheme.surface,
                  theme.colorScheme.surfaceTint,
                  2,
                ),
                groupAlignment: widget.settings.groupAlignment,
                labelType: widget.settings.labelType,
                leading: _buildLeading(isExtended),
                trailing: widget.settings.trailing,
                extended: value,
                destinations: railDestinations,
                selectedIndex: widget.selectedIndex,
                onDestinationSelected: widget.onDestinationSelected,
              );
            }),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Visibility(
            visible: widget.settings.addThemeSwitcherTrailingIcon,
            child: ThemeSwitcherButton(
              onTap: widget.onTapThemeSwitcherButton,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the leading widget of the navigation rail.
  ///
  /// If [widget.settings.leading] is not null, it returns that widget. Otherwise, it
  /// returns an IconButton with the menu or menu_open icon depending on the
  /// state of the [state].
  Widget? _buildLeading(ValueNotifier<bool> state) {
    if (widget.settings.leading != null) {
      return widget.settings.leading!;
    } else if (widget.settings.showMenuIcon) {
      return IconButton(
        onPressed: () => state.value = !state.value,
        icon: Icon(!state.value ? Icons.menu : Icons.menu_open),
      );
    } else {
      return null;
    }
  }

  /// Converts the [widget.settings.destinations] into a list of
  /// [NavigationRailDestination]s.
  ///
  /// This method maps each destination in [widget.settings.destinations] to a
  /// [NavigationRailDestination] using the
  /// [toNavigationRailDestination] extension method. If the index of the
  /// destination is 0 and [widget.settings.groupAlignment] is -1, it sets the top
  /// margin to 28. If the index is the last in the list and
  /// [widget.settings.groupAlignment] is 1.0, it sets the bottom margin to 56. If
  /// neither of these conditions is met, it does not set a margin.
  List<NavigationRailDestination> get railDestinations {
    return List.generate(widget.settings.destinations.length, (index) {
      if (index == 0 && widget.settings.groupAlignment == -1) {
        return (widget.settings.destinations[index])
            .toNavigationRailDestination(const EdgeInsets.only(top: 28));
      } else if (index == widget.settings.destinations.length - 1 &&
          widget.settings.groupAlignment == 1.0) {
        return (widget.settings.destinations[index])
            .toNavigationRailDestination(
          const EdgeInsets.only(bottom: 56),
        );
      } else {
        return (widget.settings.destinations[index])
            .toNavigationRailDestination(null);
      }
    });
  }
}
