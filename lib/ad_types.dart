import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:playwire_flutter/playwire.dart';

class AdTypes extends StatefulWidget {
  const AdTypes({super.key});

  @override
  State<AdTypes> createState() => _AdTypesState();
}

class _AdTypesState extends State<AdTypes> {
  static const _publisherId = '1024407';
  static final _appId = Platform.isIOS ? '702' : '703';
  static var _isLoading = false;

  @override
  void initState() {
    super.initState();

    Logger.root.onRecord.listen((record) {
      if (kDebugMode) {
        print('[ROOT] ${record.message}');
      }
    });

    if(kDebugMode) {
      Logger.root.level = Level.ALL;

      Logger.root.fine("Running on debug mode");

      Playwire.startConsoleLogger();
      Playwire.setTest(false);
    }

    _initializeSDK();
  }

  @override
  Widget build(BuildContext context) {
    if(_isLoading) {
      return Center(
        child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator()),
      );
    } else {
      return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ListTile(
              title: Text('App Open - GAM'),
              onTap: () {
                context.push(Uri(path: '/app_open', queryParameters: {'adUnitId': 'app-open-gam'}).toString());
              },
            ),
            ListTile(
              title: Text('App Open - MAX'),
              onTap: () {
                context.push(Uri(path: '/app_open', queryParameters: {'adUnitId': 'app-open-max'}).toString());
              },
            ),

            ListTile(
              title: Text('Banner 320x50 - GAM'),
              onTap: () {
                context.push(Uri(path: '/banner', queryParameters: {'adUnitId': 'banner-320x50-gam', 'width': '320', 'height': '50'}).toString());
              },
            ),
            ListTile(
              title: Text('Banner 320x50 - MAX'),
              onTap: () {
                context.push(Uri(path: '/banner', queryParameters: {'adUnitId': 'banner-320x50-max', 'width': '320', 'height': '50'}).toString());
              },
            ),

            ListTile(
              title: Text('Banner 300x250 - GAM'),
              onTap: () {
                context.push(Uri(path: '/banner', queryParameters: {'adUnitId': 'banner-300x250-gam', 'width': '300', 'height': '250'}).toString());
              },
            ),
            ListTile(
              title: Text('Banner 300x250 - MAX'),
              onTap: () {
                context.push(Uri(path: '/banner', queryParameters: {'adUnitId': 'banner-300x250-max', 'width': '300', 'height': '250'}).toString());
              },
            ),

            ListTile(
              title: Text('Interstitial - GAM'),
              onTap: () {
                context.push(Uri(path: '/interstitial', queryParameters: {'adUnitId': 'interstitial-gam'}).toString());
              },
            ),
            ListTile(
              title: Text('Interstitial - MAX'),
              onTap: () {
                context.push(Uri(path: '/interstitial', queryParameters: {'adUnitId': 'interstitial-max'}).toString());
              },
            ),

            ListTile(
              title: Text('Rewarded - GAM'),
              onTap: () {
                final adUnitId = Platform.isIOS ? 'rewarded-video-gam' : 'rewarded-gam';
                context.push(Uri(path: '/rewarded', queryParameters: {'adUnitId': adUnitId}).toString());
              },
            ),
            ListTile(
              title: Text('Rewarded - MAX'),
              onTap: () {
                context.push(Uri(path: '/rewarded', queryParameters: {'adUnitId': 'rewarded-video-max'}).toString());
              },
            )
          ],
      );
    }
  }

  Future<void> _initializeSDK() async {
    setState(() {
      _isLoading = true;
    });
    await Playwire.initialize(publisherId: _publisherId, appId: _appId);
    setState(() {
      _isLoading = false;
    });
  }
}