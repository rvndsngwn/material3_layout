import 'package:flutter/material.dart';
import 'package:material3_layout/src/models/navigation_settings.dart';

/// A model class that contains the settings for a navigation drawer.
class DrawerSettings extends NavigationSettings<Widget> {
  /// Creates a new [DrawerSettings] instance.
  ///
  /// The [body] are required must be the not empty.
  /// The [type] parameter specifies the type of navigation settings to use.
  DrawerSettings({
    required super.body,
    required super.destinations,
    required super.type,
  });
}
