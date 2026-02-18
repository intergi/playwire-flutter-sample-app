import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:playwire_flutter/playwire.dart';

class Banner extends StatelessWidget {
  final String adUnitId;
  final int width;
  final int height;

  const Banner({super.key, required this.adUnitId, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Banner'),
            backgroundColor: Colors.grey,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 20.0,
              onPressed: () {
                context.pop();
              },
            )
        ),
        body: Align(
          alignment: Alignment.center,
          child: PlaywireBannerView(
            adUnitId: adUnitId,
            autoload: true,
            onAdLoaded: () {
              Logger.root.fine("Banner loaded");
            },
            onAdFailedToLoad: ({code, message}) {
              Logger.root.fine("Banner failed to loaded $message");
            },
            onAdImpression: () {
              Logger.root.fine("Banner impression");
            },
            onAdClicked: () {
              Logger.root.fine("Banner ad clicked");
            },
            width: width,
            height: height
          ),
        )
    );
  }
}