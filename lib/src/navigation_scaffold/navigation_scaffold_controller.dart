import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_scaffold_controller.g.dart';

@Riverpod(keepAlive: true)
class NavigationScaffoldController extends _$NavigationScaffoldController {
  @override
  int build() => 0;

  /// * The [ThemeData] used in the NavigationScaffold.
  late ThemeData _theme;

  /// * The [ThemeData] used in the NavigationScaffold.
  ThemeData get theme => _theme;

  /// * The [ThemeData] used in the NavigationScaffold.
  setTheme(ThemeData value) => _theme = value;

  /// * The current selected index of the primary navigation.
  int get selectedIndex => state;

  /// * Sets the current selected index of the primary navigation.
  set setIndex(int value) => state = value;
}
