import 'package:flutter/material.dart' hide Banner;
import 'package:go_router/go_router.dart';
import 'package:flutter_sample_app/banner.dart';
import 'package:flutter_sample_app/interstitial.dart';
import 'package:flutter_sample_app/rewarded.dart';

import 'ad_types.dart';
import 'app_open.dart';

void main() => runApp(const PlaywireFlutterSampleApp());

class PlaywireFlutterSampleApp extends StatefulWidget {
  const PlaywireFlutterSampleApp({super.key});

  @override
  State<PlaywireFlutterSampleApp> createState() => _PlaywireFlutterSampleAppState();
}

class _PlaywireFlutterSampleAppState extends State<PlaywireFlutterSampleApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Main());
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MaterialApp.router(
          routerConfig: _router,
          debugShowCheckedModeBanner: false
        )
      )
    );
  }

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => AdTypes(),
        routes: <RouteBase>[
          GoRoute(
            path: 'app_open',
            builder: (BuildContext context, GoRouterState state) {
              final adUnitId = state.uri.queryParameters['adUnitId']!;
              return AppOpen(adUnitId: adUnitId);
            },
          ),
          GoRoute(
            path: 'banner',
            builder: (BuildContext context, GoRouterState state) {
              final adUnitId = state.uri.queryParameters['adUnitId']!;
              final width = int.parse(state.uri.queryParameters['width']!);
              final height = int.parse(state.uri.queryParameters['height']!);
              return Banner(adUnitId: adUnitId, width: width, height: height);
            },
          ),
          GoRoute(
            path: 'interstitial',
            builder: (BuildContext context, GoRouterState state) {
              final adUnitId = state.uri.queryParameters['adUnitId']!;
              return Interstitial(adUnitId: adUnitId);
            },
          ),
          GoRoute(
            path: 'rewarded',
            builder: (BuildContext context, GoRouterState state) {
              final adUnitId = state.uri.queryParameters['adUnitId']!;
              return Rewarded(adUnitId: adUnitId);
            },
          ),
        ],
      ),
    ],
  );

  Main({super.key});
}