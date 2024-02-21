import 'dart:async';

import 'package:flutter/material.dart';

class CacheClearNotifierWidget extends StatefulWidget with ChangeNotifier {
  final Duration clearPersistentCacheEvery;
  final Widget child;

  const CacheClearNotifierWidget({
    super.key,
    required this.clearPersistentCacheEvery,
    required this.child,
  });

  @override
  State<CacheClearNotifierWidget> createState() =>
      _CacheClearNotifierWidgetState();

  static CacheClearNotifierWidget? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_CacheClearNotifierInherited>()
        ?.config;
  }

  static Config of(BuildContext context) {
    final Config? result = maybeOf(context);
    assert(result != null, "No config data found in context.");
    return result!;
  }
}

class _CacheClearNotifierWidgetState extends State<CacheClearNotifierWidget> {
  late Timer clearPersistentCacheTimer;
  late CacheClearNotifier clearPersistentCache;

  @override
  void initState() {
    super.initState();

    clearPersistentCacheTimer = Timer.periodic(
      widget.clearPersistentCacheEvery,
      (_) => clearPersistentCache.notifyListeners(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _CacheClearNotifierInherited(
      parent: widget,
      child: widget.child,
    );
  }
}

class _CacheClearNotifierInherited extends InheritedWidget {
  final CacheClearNotifierWidget parent;

  const _CacheClearNotifierInherited({
    required this.parent,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
