import 'package:flutter/material.dart';
import 'package:material3_layout/src/breakpoints.dart';
import 'package:material3_layout/src/layouts/layout.dart';
import 'package:material3_layout/src/layouts/layout_utils.dart';

/// A layout that displays a single pane on the screen.
class SinglePaneLayout extends StatelessWidget with LayoutUtils, Layout {
  /// The child widget to display within this layout.
  final Widget child;

  /// The amount of vertical padding to apply to the layout.
  final double verticalPadding;
  final MaterialType type;
  final double elevation;
  final Color? color;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final TextStyle? textStyle;
  final BorderRadiusGeometry? borderRadius;
  final ShapeBorder? shape;
  final bool borderOnForeground;
  final Clip clipBehavior;
  final Duration animationDuration;

  SinglePaneLayout({
    super.key,
    this.verticalPadding = 0,
    this.type = MaterialType.card,
    this.elevation = 2.0,
    this.color,
    this.shadowColor = Colors.transparent,
    this.surfaceTintColor,
    this.textStyle,
    this.borderRadius,
    this.shape,
    this.borderOnForeground = true,
    this.clipBehavior = Clip.none,
    this.animationDuration = kThemeChangeDuration,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final layout = Breakpoints.getLayout(context);
    if (layout == LayoutEnum.compact) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        margin: layoutSpacing(verticalPadding, context),
        child: child,
      );
    }
    return Material(
      color: color ?? theme.colorScheme.surface,
      surfaceTintColor: surfaceTintColor ?? theme.colorScheme.surfaceTint,
      shadowColor: shadowColor,
      elevation: elevation,
      textStyle: textStyle,
      borderRadius: borderRadius,
      shape: shape,
      borderOnForeground: borderOnForeground,
      clipBehavior: clipBehavior,
      animationDuration: animationDuration,
      type: type,
      child: Container(
        margin: layoutSpacing(verticalPadding, context),
        width: double.infinity,
        height: double.infinity,
        child: child,
      ),
    );
  }
}
