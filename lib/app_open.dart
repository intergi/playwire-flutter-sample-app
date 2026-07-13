import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:playwire_flutter/event_types.dart';
import 'package:playwire_flutter/playwire.dart';

class AppOpen extends StatefulWidget {
  final String adUnitId;

  const AppOpen({super.key, required this.adUnitId});

  @override
  State<AppOpen> createState() => _AppOpenState();
}

class _AppOpenState extends State<AppOpen> {
  StreamSubscription? sub;

  @override
  void initState() {
    super.initState();

    sub = Playwire.events.listen((e) {
      if (e.category != PlaywireEventCategory.appOpen) {
        return;
      }

      switch (e.appOpen) {
        case AppOpenEventType.loaded:
          Logger.root.fine("App Open loaded");
          _showAppOpen();
          break;
        case AppOpenEventType.loadFailed:
          Logger.root.fine("App Open load failed: ${e.error?.name}");
          break;
        case AppOpenEventType.failedToOpen:
          Logger.root.fine("App Open failed to open: ${e.error?.name}");
          break;
        case AppOpenEventType.closed:
          Logger.root.fine("App Open closed");
          break;
        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  Future<void> _loadAppOpen() async {
    Playwire.loadAppOpen(adUnitId: widget.adUnitId);
  }

  Future<void> _showAppOpen() async {
    Playwire.showAppOpen(widget.adUnitId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('App Open'),
          backgroundColor: Colors.grey,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              context.pop();
            },
          )
      ),
      body: FutureBuilder(
          future: _loadAppOpen(),
          builder: (context, asyncSnapshot) {
            return Container(
              color: Theme.of(context).colorScheme.surface,
              child: const Row(),
            );
          }
      ),
    );
  }
}
