import 'package:flutter/material.dart';
import 'package:material3_layout/src/layouts/layout.dart';
import 'package:material3_layout/src/layouts/layout_utils.dart';

/// A split-pane layout with two child widgets: one on the left and one on the right.
/// The child widgets are separated by a `SizedBox` with a width equal to `paneSpacing`.
class SplitPaneLayout extends StatelessWidget with LayoutUtils, Layout {
  final Widget leftChild;
  final Widget rightChild;
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

  SplitPaneLayout({
    super.key,
    required this.leftChild,
    required this.rightChild,
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
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Use a Material widget as the container to apply a shadow and background color.
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
        child: Row(
          children: [
            // Use Flexible to allow the left child to take up as much space as possible.
            Flexible(child: leftChild),
            SizedBox(width: paneSpacing),
            // Use Flexible to allow the right child to take up as much space as possible.
            Flexible(child: rightChild),
          ],
        ),
      ),
    );
  }
}
