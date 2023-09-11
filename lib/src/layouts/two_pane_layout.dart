import 'package:flutter/material.dart';
import 'package:material3_layout/src/layouts/enum/fixed_pane_position_enum.dart';
import 'package:material3_layout/src/layouts/layout.dart';
import 'package:material3_layout/src/layouts/layout_utils.dart';

/// A two-pane layout that consists of a fixed pane and a flexible pane.
///
/// The position of the fixed pane can be specified as either left or right.
/// The fixed pane takes up a fixed width of 360 logical pixels and the flexible
/// pane takes up the remaining available space.
///
/// The [fixedPaneChild] and [flexiblePaneChild] widgets are required to be non-null.
class TwoPaneLayout extends StatelessWidget with LayoutUtils, Layout {
  final Widget fixedPaneChild;
  final Widget flexiblePaneChild;

  /// The position of the fixed pane in the layout. Defaults to [FixedPanePositionEnum.left].
  final FixedPanePositionEnum fixedPanePosition;

  /// The amount of vertical padding to apply around the layout.
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

  const TwoPaneLayout({
    super.key,
    required this.fixedPaneChild,
    required this.flexiblePaneChild,
    this.fixedPanePosition = FixedPanePositionEnum.left,
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
      child: Padding(
        padding: layoutSpacing(verticalPadding, context),
        child: Builder(
          builder: (context) {
            if (isFixedPanePositionLeft) {
              return Row(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: 360,
                    child: fixedPaneChild,
                  ),
                  SizedBox(width: paneSpacing),
                  Flexible(child: flexiblePaneChild),
                ],
              );
            } else {
              return Row(
                children: [
                  Flexible(child: flexiblePaneChild),
                  Container(width: paneSpacing),
                  SizedBox(
                    height: double.infinity,
                    width: 360,
                    child: fixedPaneChild,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  /// Returns a boolean value indicating whether the fixed panel position is left.
  bool get isFixedPanePositionLeft {
    return fixedPanePosition == FixedPanePositionEnum.left ? true : false;
  }
}
