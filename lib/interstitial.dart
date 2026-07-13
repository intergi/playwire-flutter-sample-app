import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:playwire_flutter/event_types.dart';
import 'package:playwire_flutter/playwire.dart';

class Interstitial extends StatefulWidget {
  final String adUnitId;

  const Interstitial({super.key, required this.adUnitId});

  @override
  State<Interstitial> createState() => _InterstitialState();
}

class _InterstitialState extends State<Interstitial> {
  StreamSubscription? sub;

  @override
  void initState() {
    super.initState();

    sub = Playwire.events.listen((e) {
      if (e.category != PlaywireEventCategory.interstitial) {
        return;
      }

      switch (e.interstitial) {
        case InterstitialEventType.loaded:
          Logger.root.fine("Interstitial loaded");
          _showInterstitial();
          break;
        case InterstitialEventType.loadFailed:
          Logger.root.fine("Interstitial load failed: ${e.error?.name}");
          break;
        case InterstitialEventType.failedToOpen:
          Logger.root.fine("Interstitial failed to open: ${e.error?.name}");
          break;
        case InterstitialEventType.closed:
          Logger.root.fine("Interstitial closed");
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

  Future<void> _loadInterstitial() async {
    await Playwire.loadInterstitial(adUnitId: widget.adUnitId);
  }

  Future<void> _showInterstitial() async {
    await Playwire.showInterstitial(widget.adUnitId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Interstitial'),
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
          future: _loadInterstitial(),
          builder: (context, asyncSnapshot) {
            return Container(
              color: Theme.of(context).colorScheme.surface,
              child: const Row(),
            );
          }
        )
    );
  }
}
