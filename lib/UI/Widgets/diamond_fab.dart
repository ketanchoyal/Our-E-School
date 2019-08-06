library diamond_fab;

import 'package:flutter/material.dart';

/// Normal Size specification based on the Posivibe specification
///
/// On Material Design spec, the normal sized diamond FAB is 68.0 logical Pixels compared
/// to the normal sized circle FAB which is 56.0 logical pixels.
const BoxConstraints _kSizeConstraints = const BoxConstraints.tightFor(
  width: 68.0,
  height: 68.0,
);

/// Mini specification based on the mini specification of the [FloatingActionButton]
///
/// Normal mini FAB specification is 40.0 logical pixels.
const BoxConstraints _kMiniSizeConstraints = const BoxConstraints.tightFor(
  width: 52.0,
  height: 52.0,
);

class _DefaultHeroTag {
  const _DefaultHeroTag();
  @override
  String toString() => '<default FloatingActionButton tag>';
}

Path getDiamondPath(Rect rect) {
  return Path()
    ..moveTo(rect.top , rect.top)
    ..lineTo(rect.right, rect.top + rect.top)
    ..lineTo(rect.bottom, rect.bottom)
    ..lineTo(rect.left, rect.top + rect.height)
    ..close();
}

/// A material design diamond shaped floating action button.
///
/// Unlike the basic floating action button, this button is diamond shaped by default.
/// It is commonly used in the [Scaffold.floatingActionButton] field.
///
/// Use a single floating action button per screen. Floating action
/// buttons are used for primary and positive actions.
///
/// if [onPressed] is null, then button will be disabled and will
/// not react to touch.
///
/// As with the normal [FloatingActionButton] the [DiamondFab] also will include
/// a notch inn the [BottomAppBar] if there is one and the [FloatingActionButtonLocation]
/// is docked.  In this case, the edges of the notch are a triangle or Rhombus
/// rather then a circle.
/// See also:
///
/// * [Scaffold]
/// * [FloatingActionButton]
/// * [FloatingActionButtonLocation]
class DiamondFab extends StatefulWidget {
  static final NotchedShape notchedShape = const _DiamondNotchedShape();

  /// The widget that is below this widget on the tree.
  ///
  /// Ussually an [Icon]
  final Widget child;

  /// The margin of the notch around the floating action button
  ///
  /// The larger this margin, the less trianular the notch will become
  /// and the larger the shape.
  ///
  /// Must be in a docked position to show the notch.  Either [centerDocked]
  /// or [endDocked] and must have a [BottomAppBar] present in the [Scaffold].
  final double notchMargin;

  /// The color to use when filling the button.
  ///
  /// Defaults to [ThemeData.accentColor] for the current theme.
  final Color backgroundColor;

  /// The default icon and text color.
  ///
  /// Defaults to [ThemeData.accentIconTheme.color] for the current theme.
  final Color foregroundColor;

  /// The z-coordinate at which to place this button. This controls the size of
  /// the shadow below the floating action button.
  ///
  /// Defaults to 6.0, based on the Material Design Spec.
  final double elevation;

  /// Text that will describe the action that happens [onPressed]
  ///
  /// This text is displayed to the user when they long press the
  /// floating action button.  It is used for accessability.
  final String tooltip;

  /// The callback function that is called when the button is tapped.
  ///
  /// If set to null, the button will be disabled.
  final VoidCallback onPressed;

  /// A tag for the button's [Hero] widget.
  ///
  /// Defaults to a tag that matches a normal FAB
  ///
  /// set this to null if you don't want the button to
  /// have a hero tag.
  ///
  /// If not set to a unique value, then you may only have one single
  /// [DiamondFab] or [FloatingActionButton] per route or screen.
  /// Multiple hero tags will cause a tag conflict.
  final Object heroTag;

  /// The z-coordinate at which to place this button when the user is touching
  /// the button. This controls the size of the shadow below the floating action
  /// button.
  ///
  /// Defaults to 12.0 which is based on the Material Design spec
  final double highlightElevation;

  /// Controls the size of this button.
  ///
  /// By default, floating action buttons are non-mini and have a height and
  /// width of 68.0 pixels. Mini floating action buttons have a height
  /// and width of 52.0 pixels.
  final bool mini;

  /// Created the diamond shaped floating action button.
  ///
  /// The [elevation], [highlightElevation], [mini], and [notchMargin]
  /// arguments must not be null.
  ///
  /// The shape property can not be set unlike the [FloatingActionButton].

  DiamondFab({
    Key key,
    this.child,
    this.notchMargin: 8.0,
    this.backgroundColor,
    @required this.onPressed,
    this.foregroundColor,
    this.tooltip,
    this.heroTag: const _DefaultHeroTag(),
    this.highlightElevation: 12.0,
    this.mini: false,
    this.elevation: 6.0,
  })  : assert(elevation != null),
        assert(highlightElevation != null),
        assert(mini != null),
        assert(notchMargin != null),
        _sizeConstraints = mini ? _kMiniSizeConstraints : _kSizeConstraints,
        super(key: key);

  final BoxConstraints _sizeConstraints;

  @override
  DiamondFabState createState() => DiamondFabState();
}

class DiamondFabState extends State<DiamondFab> {
  bool _hightlight = false;
  VoidCallback _notchChange;

  void _handleHightlightChanged(bool value) {
    setState(() => _hightlight = value);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color foregroundColor =
        widget.foregroundColor ?? theme.accentIconTheme.color;
    Widget result;

    if (widget.child != null) {
      result = IconTheme.merge(
        data: IconThemeData(
          color: foregroundColor,
        ),
        child: widget.child,
      );
    }

    if (widget.tooltip != null) {
      final Widget tooltip = Tooltip(
        message: widget.tooltip,
        child: result,
      );
      result = widget.child != null ? tooltip : SizedBox.expand(child: tooltip);
    }

    result = RawMaterialButton(
      onPressed: widget.onPressed,
      onHighlightChanged: _handleHightlightChanged,
      elevation: _hightlight ? widget.highlightElevation : widget.elevation,
      constraints: widget._sizeConstraints,
      fillColor: widget.backgroundColor ?? theme.accentColor,
      textStyle: theme.accentTextTheme.button.copyWith(
        color: foregroundColor,
        letterSpacing: 1.2,
      ),
      shape: _DiamondBorder(),
      child: result,
    );

    if (widget.heroTag != null) {
      result = Hero(
        tag: widget.heroTag,
        child: result,
      );
    }

    return result;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    if (_notchChange != null) {
      _notchChange();
    }
    super.deactivate();
  }
}

class _DiamondNotchedShape implements NotchedShape {
  const _DiamondNotchedShape();

  @override
  Path getOuterPath(Rect host, Rect guest) {
    var diamondPath = getDiamondPath(guest);
    var hostPath = Path()
        ..moveTo(host.left, host.top)
        ..lineTo(host.right, host.top)
        ..lineTo(host.right, host.bottom)
        ..lineTo(host.left, host.bottom)
        ..close();

    return Path.combine(PathOperation.difference, hostPath, diamondPath);
  }
}

/// [_DiamondBorder] for the [DiamondFab], this is what draws the shape.

class _DiamondBorder extends ShapeBorder {
  const _DiamondBorder();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only();

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return getDiamondPath(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return null;
  }
}