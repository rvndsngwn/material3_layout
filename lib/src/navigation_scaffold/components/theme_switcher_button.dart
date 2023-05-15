import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../navigation_scaffold_controller.dart';

/// A button widget that toggles the theme mode of the app.
///
/// This widget uses GetX for state management and changes the theme mode of the app
/// based on the current theme mode when it is pressed.
///
/// Example usage:
/// ```dart
/// ThemeSwitcherButton()
/// ```
class ThemeSwitcherButton extends HookConsumerWidget {
  final void Function()? onTap;
  const ThemeSwitcherButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(navigationScaffoldControllerProvider.notifier);
    final Brightness brightness = Theme.of(context).brightness;
    final bool isDarkMode = brightness == Brightness.dark;
    return onTap == null
        ? const SizedBox.shrink()
        : IconButton(
            icon: isDarkMode
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
            onPressed: onTap,
            style: IconButton.styleFrom(
              shape: const CircleBorder(),
              side: BorderSide(
                color: controller.theme.colorScheme.outline,
              ),
            ),
          );
  }
}
