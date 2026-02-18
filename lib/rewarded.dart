import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:playwire_flutter/event_types.dart';
import 'package:playwire_flutter/playwire.dart';

class Rewarded extends StatefulWidget {
  final String adUnitId;

  const Rewarded({super.key, required this.adUnitId});

  @override
  State<Rewarded> createState() => _RewardedState();
}

class _RewardedState extends State<Rewarded> {
  StreamSubscription? sub;

  @override
  void initState() {
    super.initState();

    sub = Playwire.events.listen((e) {
      if (e.category != PlaywireEventCategory.rewarded) {
        return;
      }

      switch (e.rewarded) {
        case RewardedEventType.loaded:
          Logger.root.fine("Rewarded loaded");
          _showRewarded();
          break;
        case RewardedEventType.loadFailed:
          Logger.root.fine("Rewarded failed to load");
          break;
        case RewardedEventType.failedToOpen:
          Logger.root.fine("Rewarded failed to open");
          break;
        case RewardedEventType.closed:
          Logger.root.fine("Rewarded closed");
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

  Future<void> _loadRewarded() async {
    await Playwire.loadRewarded(adUnitId: widget.adUnitId);
  }

  Future<void> _showRewarded() async {
    await Playwire.showRewarded(widget.adUnitId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Rewarded'),
            backgroundColor: Colors.grey,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 20.0,
              onPressed: () {
                context.pop();
              },
            )
        ),
        body:  FutureBuilder(
            future: _loadRewarded(),
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
