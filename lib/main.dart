import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/components/screen_darken.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/painters/nysse_wave_painter.dart';
import 'package:nysse_asemanaytto/core/request_info.dart';
import 'package:nysse_asemanaytto/core/routes.dart';
import 'package:nysse_asemanaytto/digitransit/mqtt/mqtt.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import 'package:nysse_asemanaytto/main/error_layout.dart';
import 'package:nysse_asemanaytto/main/main_layout.dart';
import 'package:nysse_asemanaytto/main/stopinfo.dart';
import 'package:nysse_asemanaytto/main/stoptimes.dart';
import 'package:nysse_asemanaytto/settings/settings_layout.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;
import 'dart:developer' as developer;
import 'dart:math' as math;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MainApp(prefs: prefs));
}

class MainApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MainApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return ConfigWidget(
      prefs: prefs,
      child: const _Asemanaytto(),
    );
  }
}

class _Asemanaytto extends StatelessWidget {
  const _Asemanaytto();

  @override
  Widget build(BuildContext context) {
    final Config config = Config.of(context);

    Widget app = MaterialApp(
      title: "Nysse Asemanäyttö",
      initialRoute: Routes.home,
      showPerformanceOverlay: config.debugEnabled,
      routes: {
        Routes.home: (context) => const _HomeRouter(child: AppServices()),
        Routes.settings: (context) => const SettingsWidget(),
      },
    );

    if (config.digitransitMqttProviderEnabled) {
      app = DigitransitMqtt(child: app);
    }

    if (config.digitransitSubscriptionKey != null) {
      app = GraphQLProvider(
        client: ValueNotifier<GraphQLClient>(
          GraphQLClient(
            link: HttpLink(
              config.endpoint.getEndpoint(),
              defaultHeaders: {
                "digitransit-subscription-key":
                    config.digitransitSubscriptionKey!,
                "User-Agent": RequestInfo.userAgent,
              },
              httpResponseDecoder: _handleGraphQLResponse,
            ),
            cache: GraphQLCache(),
            queryRequestTimeout: RequestInfo.qlTimeout,
          ),
        ),
        child: app,
      );
    }

    return app;
  }
}

class _HomeRouter extends StatefulWidget {
  final Widget child;

  const _HomeRouter({required this.child});

  @override
  State<_HomeRouter> createState() => _HomeRouterState();
}

class _HomeRouterState extends State<_HomeRouter> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.keyboard.addHandler(_onKey);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.keyboard.removeHandler(_onKey);
    super.dispose();
  }

  bool _onKey(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.physicalKey == PhysicalKeyboardKey.f1) {
        Navigator.pushNamed(context, Routes.settings);
      } else if (event.physicalKey == PhysicalKeyboardKey.f3) {
        final config = Config.of(context);
        config.debugEnabled = !config.debugEnabled;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final Config config = Config.of(context);
    if (config.digitransitSubscriptionKey == null) {
      return const ErrorLayout(
        message: "No Digitransit subscription key provided",
        description: "Open settings by pressing F1",
      );
    }

    return widget.child;
  }
}

class AppServices extends StatelessWidget {
  const AppServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      info: LayoutData(mediaQueryData: MediaQuery.of(context)),
      child: ScreenDarkenWidget(
        child: const StopInfo(
          child: Stoptimes(
            child: AppCanvas(),
          ),
        ),
      ),
    );
  }
}

Map<String, dynamic>? _handleGraphQLResponse(http.Response response) {
  developer.log("Decoding GraphQL response...", name: "Digitransit");

  return json.decode(
    utf8.decode(
      response.bodyBytes,
    ),
  ) as Map<String, dynamic>?;
}

class AppCanvas extends StatelessWidget {
  const AppCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Stack(
      children: [
        SizedBox.expand(
          child: ColoredBox(
            color: NysseColors.mediumBlue,
            child: CustomPaint(
              painter: NysseWavePainter.fromAngle(
                start: Offset(mediaQuery.size.width * 0.875, 0),
                waveStartOffset: 0.375,
                angleRadians: (3 * math.pi) / 4,
                waveLength: mediaQuery.size.width / 3.6,
                waveSize: mediaQuery.size.width / 40,
                invert: false,
              ),
            ),
          ),
        ),
        const Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MainCanvas(),
              EmbedCanvas(),
              _Footer(),
            ],
          ),
        ),
      ],
    );
  }
}

class MainCanvas extends StatelessWidget {
  const MainCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Layout.of(context).doublePadding,
        right: Layout.of(context).doublePadding,
        top: Layout.of(context).doubleWidePadding,
        bottom: Layout.of(context).widePadding,
      ),
      child: const MainLayout(),
    );
  }
}

class EmbedCanvas extends StatefulWidget {
  const EmbedCanvas({super.key});

  @override
  State<EmbedCanvas> createState() => _EmbedCanvasState();
}

class _EmbedCanvasState extends State<EmbedCanvas> {
  int? _childIndex;

  /// Holds a reference to the most recent timer.
  /// Timer can be an old outdated timer if no new timers have been scheduled.
  Timer? _indexTimer;

  List<EmbedWidgetMixin>? _embeds;

  void _switchIndex() {
    assert(_indexTimer?.isActive != true);

    // if index doesn't change, the disable is still pumped through the system
    if (_childIndex != null) {
      _embeds![_childIndex!].onDisable();
    }

    Duration? embedDuration;
    int? childIndex;
    if (_embeds!.isEmpty) {
      childIndex = null;
    } else {
      // iterate at max to the same index as where we were at start
      for (int i = 1; i <= _embeds!.length; i++) {
        // increment index, default to 0 if null.
        // Will wrap around at after final element.
        childIndex = ((_childIndex ?? -1) + i) % _embeds!.length;
        embedDuration = _embeds![childIndex].getDuration() ?? Duration.zero;

        // break on first embed which doesn't have 0 duration
        if (embedDuration != Duration.zero) {
          break;
        }
      }

      // if all embeds had duration zero
      if (embedDuration == Duration.zero) {
        // set this to null so that no timer is scheduled
        embedDuration = null;
        childIndex = null;
      }
    }

    setState(() {
      _childIndex = childIndex;
    });

    if (_childIndex != null) {
      _embeds![_childIndex!].onEnable();
    }

    if (embedDuration != null) {
      _indexTimer = Timer(embedDuration, _switchIndex);
    }
  }

  @override
  void dispose() {
    _indexTimer?.cancel();
    super.dispose();
  }

  void _restartEmbeds() {
    developer.log("(re)Starting embeds...", name: "Digitransit");

    _childIndex = null;
    _indexTimer?.cancel();

    _embeds = null;

    // Reconstruct embeds after frame render
    // so that all embed state has been disposed
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _constructEmbedsAndStart(),
    );
  }

  void _constructEmbedsAndStart() {
    final UnmodifiableListView<EmbedRecord> embeds = Config.of(context).embeds;

    assert(_embeds == null);
    setState(() {
      _embeds = embeds
          .map((e) => e.embed.createEmbed(e.settings))
          .toList(growable: false);
    });

    // Wait for next frame so that all widgets have their state in their keys set.
    WidgetsBinding.instance.addPostFrameCallback((_) => _switchIndex());
  }

  @override
  void didChangeDependencies() {
    _restartEmbeds();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IndexedStack(
        sizing: StackFit.passthrough,
        index: _childIndex,
        children: _embeds ?? [],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(context);
    final double iconHeight = layout.tileHeight * 0.6;

    return Padding(
      padding: EdgeInsets.only(
        bottom: layout.widePadding,
        top: layout.halfPadding,
        right: layout.doublePadding,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "nysse.fi",
              textAlign: TextAlign.right,
              style:
                  layout.smallLabelStyle.copyWith(fontFamily: "LotaGrotesque"),
            ),
          ),
          SizedBox(width: layout.padding),
          SvgPicture(NyssePictograms.bus, height: iconHeight),
          SizedBox(width: layout.halfPadding),
          SvgPicture(NyssePictograms.train, height: iconHeight),
          SizedBox(width: layout.halfPadding),
          SvgPicture(NyssePictograms.routes, height: iconHeight),
          SizedBox(width: layout.halfPadding),
          SvgPicture(NyssePictograms.bike, height: iconHeight),
        ],
      ),
    );
  }
}
