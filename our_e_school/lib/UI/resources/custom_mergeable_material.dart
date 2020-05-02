// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' show lerpDouble;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

/// The base type for [CustomMaterialSlice] and [CustomMaterialGap].
///
/// All [CustomMergeableMaterialItem] objects need a [LocalKey].
@immutable
abstract class CustomMergeableMaterialItem {
  /// Abstract const constructor. This constructor enables subclasses to provide
  /// const constructors so that they can be used in const expressions.
  ///
  /// The argument is the [key], which must not be null.
  const CustomMergeableMaterialItem(this.key) : assert(key != null);

  /// The key for this item of the list.
  ///
  /// The key is used to match parts of the mergeable material from frame to
  /// frame so that state is maintained appropriately even as slices are added
  /// or removed.
  final LocalKey key;
}

/// A class that can be used as a child to [CustomMergeableMaterial]. It is a slice
/// of [Material] that animates merging with other slices.
///
/// All [CustomMaterialSlice] objects need a [LocalKey].
class CustomMaterialSlice extends CustomMergeableMaterialItem {
  /// Creates a slice of [Material] that's mergeable within a
  /// [CustomMergeableMaterial].
  const CustomMaterialSlice({
    @required LocalKey key,
    @required this.child,
  }) : assert(key != null),
       super(key);

  /// The contents of this slice.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  @override
  String toString() {
    return 'MergeableSlice(key: $key, child: $child)';
  }
}

/// A class that represents a gap within [CustomMergeableMaterial].
///
/// All [CustomMaterialGap] objects need a [LocalKey].
class CustomMaterialGap extends CustomMergeableMaterialItem {
  /// Creates a Material gap with a given size.
  const CustomMaterialGap({
    @required LocalKey key,
    this.size = 16.0
  }) : assert(key != null),
       super(key);

  /// The main axis extent of this gap. For example, if the [CustomMergeableMaterial]
  /// is vertical, then this is the height of the gap.
  final double size;

  @override
  String toString() {
    return 'MaterialGap(key: $key, child: $size)';
  }
}

/// Displays a list of [CustomMergeableMaterialItem] children. The list contains
/// [CustomMaterialSlice] items whose boundaries are either "merged" with adjacent
/// items or separated by a [CustomMaterialGap]. The [children] are distributed along
/// the given [mainAxis] in the same way as the children of a [ListBody]. When
/// the list of children changes, gaps are automatically animated open or closed
/// as needed.
///
/// To enable this widget to correlate its list of children with the previous
/// one, each child must specify a key.
///
/// When a new gap is added to the list of children the adjacent items are
/// animated apart. Similarly when a gap is removed the adjacent items are
/// brought back together.
///
/// When a new slice is added or removed, the app is responsible for animating
/// the transition of the slices, while the gaps will be animated automatically.
///
/// See also:
///
///  * [Card], a piece of material that does not support splitting and merging
///    but otherwise looks the same.
class CustomMergeableMaterial extends StatefulWidget {
  /// Creates a mergeable Material list of items.
  const CustomMergeableMaterial({
    Key key,
    this.mainAxis = Axis.vertical,
    this.elevation = 2,
    this.hasDividers = false,
    this.children = const <CustomMergeableMaterialItem>[]
  }) : super(key: key);

  /// The children of the [CustomMergeableMaterial].
  final List<CustomMergeableMaterialItem> children;

  /// The main layout axis.
  final Axis mainAxis;

  /// The z-coordinate at which to place all the [Material] slices.
  ///
  /// The following elevations have defined shadows: 1, 2, 3, 4, 6, 8, 9, 12, 16, 24
  ///
  /// Defaults to 2, the appropriate elevation for cards.
  final int elevation;

  /// Whether connected pieces of [CustomMaterialSlice] have dividers between them.
  final bool hasDividers;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<Axis>('mainAxis', mainAxis));
    properties.add(DoubleProperty('elevation', elevation.toDouble()));
  }

  @override
  _CustomMergeableMaterialState createState() => _CustomMergeableMaterialState();
}

class _AnimationTuple {
  _AnimationTuple({
    this.controller,
    this.startAnimation,
    this.endAnimation,
    this.gapAnimation,
    this.gapStart = 0.0
  });

  final AnimationController controller;
  final CurvedAnimation startAnimation;
  final CurvedAnimation endAnimation;
  final CurvedAnimation gapAnimation;
  double gapStart;
}

class _CustomMergeableMaterialState extends State<CustomMergeableMaterial> with TickerProviderStateMixin {
  List<CustomMergeableMaterialItem> _children;
  final Map<LocalKey, _AnimationTuple> _animationTuples =
      <LocalKey, _AnimationTuple>{};

  @override
  void initState() {
    super.initState();
    _children = List<CustomMergeableMaterialItem>.from(widget.children);

    for (int i = 0; i < _children.length; i += 1) {
      if (_children[i] is CustomMaterialGap) {
        _initGap(_children[i]);
        _animationTuples[_children[i].key].controller.value = 1.0; // Gaps are initially full-sized.
      }
    }
    assert(_debugGapsAreValid(_children));
  }

  void _initGap(CustomMaterialGap gap) {
    final AnimationController controller = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: this,
    );

    final CurvedAnimation startAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn
    );
    final CurvedAnimation endAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn
    );
    final CurvedAnimation gapAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn
    );

    controller.addListener(_handleTick);

    _animationTuples[gap.key] = _AnimationTuple(
      controller: controller,
      startAnimation: startAnimation,
      endAnimation: endAnimation,
      gapAnimation: gapAnimation
    );
  }

  @override
  void dispose() {
    for (CustomMergeableMaterialItem child in _children) {
      if (child is CustomMaterialGap)
        _animationTuples[child.key].controller.dispose();
    }
    super.dispose();
  }

  void _handleTick() {
    setState(() {
      // The animation's state is our build state, and it changed already.
    });
  }

  bool _debugHasConsecutiveGaps(List<CustomMergeableMaterialItem> children) {
    for (int i = 0; i < widget.children.length - 1; i += 1) {
      if (widget.children[i] is CustomMaterialGap &&
          widget.children[i + 1] is CustomMaterialGap)
        return true;
    }
    return false;
  }

  bool _debugGapsAreValid(List<CustomMergeableMaterialItem> children) {
    // Check for consecutive gaps.
    if (_debugHasConsecutiveGaps(children))
      return false;

    // First and last children must not be gaps.
    if (children.isNotEmpty) {
      if (children.first is CustomMaterialGap || children.last is CustomMaterialGap)
        return false;
    }

    return true;
  }

  void _insertChild(int index, CustomMergeableMaterialItem child) {
    _children.insert(index, child);

    if (child is CustomMaterialGap)
      _initGap(child);
  }

  void _removeChild(int index) {
    final CustomMergeableMaterialItem child = _children.removeAt(index);

    if (child is CustomMaterialGap)
      _animationTuples[child.key] = null;
  }

  bool _isClosingGap(int index) {
    if (index < _children.length - 1 && _children[index] is CustomMaterialGap) {
      return _animationTuples[_children[index].key].controller.status ==
          AnimationStatus.reverse;
    }

    return false;
  }

  void _removeEmptyGaps() {
    int j = 0;

    while (j < _children.length) {
      if (
        _children[j] is CustomMaterialGap &&
        _animationTuples[_children[j].key].controller.status == AnimationStatus.dismissed
      ) {
        _removeChild(j);
      } else {
        j += 1;
      }
    }
  }

  @override
  void didUpdateWidget(CustomMergeableMaterial oldWidget) {
    super.didUpdateWidget(oldWidget);

    final Set<LocalKey> oldKeys = oldWidget.children.map<LocalKey>(
      (CustomMergeableMaterialItem child) => child.key
    ).toSet();
    final Set<LocalKey> newKeys = widget.children.map<LocalKey>(
      (CustomMergeableMaterialItem child) => child.key
    ).toSet();
    final Set<LocalKey> newOnly = newKeys.difference(oldKeys);
    final Set<LocalKey> oldOnly = oldKeys.difference(newKeys);

    final List<CustomMergeableMaterialItem> newChildren = widget.children;
    int i = 0;
    int j = 0;

    assert(_debugGapsAreValid(newChildren));

    _removeEmptyGaps();

    while (i < newChildren.length && j < _children.length) {
      if (newOnly.contains(newChildren[i].key) ||
          oldOnly.contains(_children[j].key)) {
        final int startNew = i;
        final int startOld = j;

        // Skip new keys.
        while (newOnly.contains(newChildren[i].key))
          i += 1;

        // Skip old keys.
        while (oldOnly.contains(_children[j].key) || _isClosingGap(j))
          j += 1;

        final int newLength = i - startNew;
        final int oldLength = j - startOld;

        if (newLength > 0) {
          if (oldLength > 1 ||
              oldLength == 1 && _children[startOld] is CustomMaterialSlice) {
            if (newLength == 1 && newChildren[startNew] is CustomMaterialGap) {
              // Shrink all gaps into the size of the new one.
              double gapSizeSum = 0.0;

              while (startOld < j) {
                if (_children[startOld] is CustomMaterialGap) {
                  final CustomMaterialGap gap = _children[startOld];
                  gapSizeSum += gap.size;
                }

                _removeChild(startOld);
                j -= 1;
              }

              _insertChild(startOld, newChildren[startNew]);
              _animationTuples[newChildren[startNew].key]
                ..gapStart = gapSizeSum
                ..controller.forward();

              j += 1;
            } else {
              // No animation if replaced items are more than one.
              for (int k = 0; k < oldLength; k += 1)
                _removeChild(startOld);
              for (int k = 0; k < newLength; k += 1)
                _insertChild(startOld + k, newChildren[startNew + k]);

              j += newLength - oldLength;
            }
          } else if (oldLength == 1) {
            if (newLength == 1 && newChildren[startNew] is CustomMaterialGap &&
                _children[startOld].key == newChildren[startNew].key) {
              /// Special case: gap added back.
              _animationTuples[newChildren[startNew].key].controller.forward();
            } else {
              final double gapSize = _getGapSize(startOld);

              _removeChild(startOld);

              for (int k = 0; k < newLength; k += 1)
                _insertChild(startOld + k, newChildren[startNew + k]);

              j += newLength - 1;
              double gapSizeSum = 0.0;

              for (int k = startNew; k < i; k += 1) {
                if (newChildren[k] is CustomMaterialGap) {
                  final CustomMaterialGap gap = newChildren[k];
                  gapSizeSum += gap.size;
                }
              }

              // All gaps get proportional sizes of the original gap and they will
              // animate to their actual size.
              for (int k = startNew; k < i; k += 1) {
                if (newChildren[k] is CustomMaterialGap) {
                  final CustomMaterialGap gap = newChildren[k];

                  _animationTuples[gap.key].gapStart = gapSize * gap.size /
                      gapSizeSum;
                  _animationTuples[gap.key].controller
                    ..value = 0.0
                    ..forward();
                }
              }
            }
          } else {
            // Grow gaps.
            for (int k = 0; k < newLength; k += 1) {
              _insertChild(startOld + k, newChildren[startNew + k]);

              if (newChildren[startNew + k] is CustomMaterialGap) {
                final CustomMaterialGap gap = newChildren[startNew + k];
                _animationTuples[gap.key].controller.forward();
              }
            }

            j += newLength;
          }
        } else {
          // If more than a gap disappeared, just remove slices and shrink gaps.
          if (oldLength > 1 ||
              oldLength == 1 && _children[startOld] is CustomMaterialSlice) {
            double gapSizeSum = 0.0;

            while (startOld < j) {
              if (_children[startOld] is CustomMaterialGap) {
                final CustomMaterialGap gap = _children[startOld];
                gapSizeSum += gap.size;
              }

              _removeChild(startOld);
              j -= 1;
            }

            if (gapSizeSum != 0.0) {
              final CustomMaterialGap gap = CustomMaterialGap(
                key: UniqueKey(),
                size: gapSizeSum
              );
              _insertChild(startOld, gap);
              _animationTuples[gap.key].gapStart = 0.0;
              _animationTuples[gap.key].controller
                ..value = 1.0
                ..reverse();

              j += 1;
            }
          } else if (oldLength == 1) {
            // Shrink gap.
            final CustomMaterialGap gap = _children[startOld];
            _animationTuples[gap.key].gapStart = 0.0;
            _animationTuples[gap.key].controller.reverse();
          }
        }
      } else {
        // Check whether the items are the same type. If they are, it means that
        // their places have been swaped.
        if ((_children[j] is CustomMaterialGap) == (newChildren[i] is CustomMaterialGap)) {
          _children[j] = newChildren[i];

          i += 1;
          j += 1;
        } else {
          // This is a closing gap which we need to skip.
          // assert(_children[j] is CustomMaterialGap);
          j += 1;
        }
      }
    }

    // Handle remaining items.
    while (j < _children.length)
      _removeChild(j);
    while (i < newChildren.length) {
      _insertChild(j, newChildren[i]);

      i += 1;
      j += 1;
    }
  }

  BorderRadius _borderRadius(int index, bool start, bool end) {
    assert(kMaterialEdges[MaterialType.card].topLeft == kMaterialEdges[MaterialType.card].topRight);
    assert(kMaterialEdges[MaterialType.card].topLeft == kMaterialEdges[MaterialType.card].bottomLeft);
    assert(kMaterialEdges[MaterialType.card].topLeft == kMaterialEdges[MaterialType.card].bottomRight);
    final Radius cardRadius = kMaterialEdges[MaterialType.card].topLeft;

    Radius startRadius = Radius.zero;
    Radius endRadius = Radius.zero;

    if (index > 0 && _children[index - 1] is CustomMaterialGap) {
      startRadius = Radius.lerp(
        Radius.zero,
        cardRadius,
        _animationTuples[_children[index - 1].key].startAnimation.value
      );
    }
    if (index < _children.length - 2 && _children[index + 1] is CustomMaterialGap) {
      endRadius = Radius.lerp(
        Radius.zero,
        cardRadius,
        _animationTuples[_children[index + 1].key].endAnimation.value
      );
    }

    if (widget.mainAxis == Axis.vertical) {
      return BorderRadius.vertical(
        top: start ? cardRadius : startRadius,
        bottom: end ? cardRadius : endRadius
      );
    } else {
      return BorderRadius.horizontal(
        left: start ? cardRadius : startRadius,
        right: end ? cardRadius : endRadius
      );
    }
  }

  double _getGapSize(int index) {
    final CustomMaterialGap gap = _children[index];

    return lerpDouble(
      _animationTuples[gap.key].gapStart,
      gap.size,
      _animationTuples[gap.key].gapAnimation.value
    );
  }

  bool _willNeedDivider(int index) {
    if (index < 0)
      return false;
    if (index >= _children.length)
      return false;
    return _children[index] is CustomMaterialSlice || _isClosingGap(index);
  }

  @override
  Widget build(BuildContext context) {
    _removeEmptyGaps();

    final List<Widget> widgets = <Widget>[];
    List<Widget> slices = <Widget>[];
    int i;

    for (i = 0; i < _children.length; i += 1) {
      if (_children[i] is CustomMaterialGap) {
        assert(slices.isNotEmpty);
        widgets.add(
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: _borderRadius(i - 1, widgets.isEmpty, false),
              shape: BoxShape.rectangle
            ),
            child: ListBody(
              mainAxis: widget.mainAxis,
              children: slices
            )
          )
        );
        slices = <Widget>[];

        widgets.add(
          SizedBox(
            width: widget.mainAxis == Axis.horizontal ? _getGapSize(i) : null,
            height: widget.mainAxis == Axis.vertical ? _getGapSize(i) : null
          )
        );
      } else {
        final CustomMaterialSlice slice = _children[i];
        Widget child = slice.child;

        if (widget.hasDividers) {
          final bool hasTopDivider = _willNeedDivider(i - 1);
          final bool hasBottomDivider = _willNeedDivider(i + 1);

          Border border;
          final BorderSide divider = Divider.createBorderSide(
            context,
            width: 0.5, // TODO(ianh): This probably looks terrible when the dpr isn't a power of two.
          );

          if (i == 0) {
            border = Border(
              bottom: hasBottomDivider ? divider : BorderSide.none
            );
          } else if (i == _children.length - 1) {
            border = Border(
              top: hasTopDivider ? divider : BorderSide.none
            );
          } else {
            border = Border(
              top: hasTopDivider ? divider : BorderSide.none,
              bottom: hasBottomDivider ? divider : BorderSide.none
            );
          }

          assert(border != null);

          child = AnimatedContainer(
            key: _MergeableMaterialSliceKey(_children[i].key),
            decoration: BoxDecoration(border: border),
            duration: kThemeAnimationDuration,
            curve: Curves.fastOutSlowIn,
            child: child
          );
        }

        slices.add(
          Material(
            type: MaterialType.transparency,
            child: child
          )
        );
      }
    }

    if (slices.isNotEmpty) {
      widgets.add(
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: _borderRadius(i - 1, widgets.isEmpty, true),
            shape: BoxShape.rectangle
          ),
          child: ListBody(
            mainAxis: widget.mainAxis,
            children: slices
          )
        )
      );
      slices = <Widget>[];
    }

    return _MergeableMaterialListBody(
      mainAxis: widget.mainAxis,
      boxShadows: kElevationToShadow[widget.elevation],
      items: _children,
      children: widgets
    );
  }
}

// The parent hierarchy can change and lead to the slice being
// rebuilt. Using a global key solves the issue.
class _MergeableMaterialSliceKey extends GlobalKey {
  const _MergeableMaterialSliceKey(this.value) : super.constructor();

  final LocalKey value;

  @override
  bool operator ==(dynamic other) {
    if (other is! _MergeableMaterialSliceKey)
      return false;
    final _MergeableMaterialSliceKey typedOther = other;
    return value == typedOther.value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return '_MergeableMaterialSliceKey($value)';
  }
}

class _MergeableMaterialListBody extends ListBody {
  _MergeableMaterialListBody({
    List<Widget> children,
    Axis mainAxis = Axis.vertical,
    this.items,
    this.boxShadows
  }) : super(children: children, mainAxis: mainAxis);

  final List<CustomMergeableMaterialItem> items;
  final List<BoxShadow> boxShadows;

  AxisDirection _getDirection(BuildContext context) {
    return getAxisDirectionFromAxisReverseAndDirectionality(context, mainAxis, false);
  }

  @override
  RenderListBody createRenderObject(BuildContext context) {
    return _RenderMergeableMaterialListBody(
      axisDirection: _getDirection(context),
      boxShadows: boxShadows,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderListBody renderObject) {
    final _RenderMergeableMaterialListBody materialRenderListBody = renderObject;
    materialRenderListBody
      ..axisDirection = _getDirection(context)
      ..boxShadows = boxShadows;
  }
}

class _RenderMergeableMaterialListBody extends RenderListBody {
  _RenderMergeableMaterialListBody({
    List<RenderBox> children,
    AxisDirection axisDirection = AxisDirection.down,
    this.boxShadows
  }) : super(children: children, axisDirection: axisDirection);

  List<BoxShadow> boxShadows;

  void _paintShadows(Canvas canvas, Rect rect) {
    for (BoxShadow boxShadow in boxShadows) {
      final Paint paint = boxShadow.toPaint();
      // TODO(dragostis): Right now, we are only interpolating the border radii
      // of the visible Material slices, not the shadows; they are not getting
      // interpolated and always have the same rounded radii. Once shadow
      // performance is better, shadows should be redrawn every single time the
      // slices' radii get interpolated and use those radii not the defaults.
      canvas.drawRRect(kMaterialEdges[MaterialType.card].toRRect(rect), paint);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox child = firstChild;
    int i = 0;

    while (child != null) {
      final ListBodyParentData childParentData = child.parentData;
      final Rect rect = (childParentData.offset + offset) & child.size;
      if (i % 2 == 0)
        // _paintShadows(context.canvas, rect);
      child = childParentData.nextSibling;

      i += 1;
    }

    defaultPaint(context, offset);
  }
}
