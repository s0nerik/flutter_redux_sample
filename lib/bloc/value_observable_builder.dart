// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

/// Builds a [Widget] when given a concrete value of a [ValueObservable<T>].
///
/// If the `child` parameter provided to the [ValueObservableBuilder] is not
/// null, the same `child` widget is passed back to this [ValueWidgetBuilder]
/// and should typically be incorporated in the returned widget tree.
///
/// See also:
///
///  * [ValueObservableBuilder], a widget which invokes this builder each time
///    a [ValueObservable] changes value.
typedef ValueWidgetBuilder<T> = Widget Function(BuildContext context, T value, Widget child);

/// A widget whose content stays sync'ed with a [ValueObservable].
///
/// Given a [ValueObservable<T>] and a [builder] which builds widgets from
/// concrete values of `T`, this class will automatically register itself as a
/// listener of the [ValueObservable] and call the [builder] with updated values
/// when the value changes.
///
/// ## Performance optimizations
///
/// If your [builder] function contains a subtree that does not depend on the
/// value of the [ValueObservable], it's more efficient to build that subtree
/// once instead of rebuilding it on every animation tick.
///
/// If you pass the pre-built subtree as the [child] parameter, the
/// [ValueObservableBuilder] will pass it back to your [builder] function so
/// that you can incorporate it into your build.
///
/// Using this pre-built child is entirely optional, but can improve
/// performance significantly in some cases and is therefore a good practice.
///
/// See also:
///
///  * [AnimatedBuilder], which also triggers rebuilds from a [Listenable]
///    without passing back a specific value from a [ValueObservable].
///  * [NotificationListener], which lets you rebuild based on Notification
///    coming from its descendant widgets rather than a [ValueObservable] that
///    you have a direct reference to.
///  * [StreamBuilder], where a builder can depend on a [Stream] rather than
///    a [ValueObservable] for more advanced use cases.
class ValueObservableBuilder<T> extends StatefulWidget {
  /// Creates a [ValueObservableBuilder].
  ///
  /// The [valueObservable] and [builder] arguments must not be null.
  /// The [child] is optional but is good practice to use if part of the widget
  /// subtree does not depend on the value of the [valueObservable].
  const ValueObservableBuilder({
    @required this.valueObservable,
    @required this.builder,
    this.child,
  })  : assert(valueObservable != null),
        assert(builder != null);

  /// The [ValueObservable] whose value you depend on in order to build.
  ///
  /// This widget does not ensure that the [ValueObservable]'s value is not
  /// null, therefore your [builder] may need to handle null values.
  ///
  /// This [ValueObservable] itself must not be null.
  final ValueObservable<T> valueObservable;

  /// A [ValueWidgetBuilder] which builds a widget depending on the
  /// [valueObservable]'s value.
  ///
  /// Can incorporate a [valueObservable] value-independent widget subtree
  /// from the [child] parameter into the returned widget tree.
  ///
  /// Must not be null.
  final ValueWidgetBuilder<T> builder;

  /// A [valueObservable]-independent widget which is passed back to the [builder].
  ///
  /// This argument is optional and can be null if the entire widget subtree
  /// the [builder] builds depends on the value of the [valueObservable]. For
  /// example, if the [valueObservable] is a [String] and the [builder] simply
  /// returns a [Text] widget with the [String] value.
  final Widget child;

  @override
  State<StatefulWidget> createState() => _ValueObservableBuilderState<T>();
}

class _ValueObservableBuilderState<T> extends State<ValueObservableBuilder<T>> {
  T _value;
  StreamSubscription<T> _sub;

  @override
  void initState() {
    super.initState();
    _value = widget.valueObservable.value;
    _sub = widget.valueObservable.listen(_valueChanged);
  }

  @override
  void didUpdateWidget(ValueObservableBuilder<T> oldWidget) {
    if (oldWidget.valueObservable != widget.valueObservable) {
      _sub.cancel();
      _value = widget.valueObservable.value;
      _sub = widget.valueObservable.listen(_valueChanged);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  void _valueChanged(T newValue) {
    setState(() {
      _value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _value, widget.child);
  }
}
