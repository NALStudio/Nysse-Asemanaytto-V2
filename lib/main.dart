import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/painters/nysse_wave_painter.dart';
import 'package:nysse_asemanaytto/core/routes.dart';
import 'package:nysse_asemanaytto/main/error_layout.dart';
import 'package:nysse_asemanaytto/main/main_layout.dart';
import 'package:nysse_asemanaytto/settings/settings_layout.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import "package:http/http.dart" as http;
import 'dart:developer' as developer;
import 'dart:math' as math;

Future<void> main() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    ConfigWidget(
      prefs: prefs,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Config config = Config.of(context);

    return GraphQLProvider(
      client: ValueNotifier<GraphQLClient>(
        GraphQLClient(
          link: HttpLink(
            config.endpoint.getEndpoint(),
            defaultHeaders: {
              "digitransit-subscription-key":
                  config.digitransitSubscriptionKey!,
            },
            httpResponseDecoder: _handleGraphQLResponse,
          ),
          cache: GraphQLCache(),
        ),
      ),
      child: MaterialApp(
        title: "Nysse Asemanäyttö",
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) => const _HomeRouter(child: AppServices()),
          Routes.settings: (context) => const SettingsWidget(),
        },
      ),
    );
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
    if (event is KeyDownEvent && event.physicalKey == PhysicalKeyboardKey.f1) {
      Navigator.pushNamed(context, Routes.settings);
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
      child: const AppCanvas(),
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

class EmbedCanvas extends StatelessWidget {
  const EmbedCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: ColoredBox(
        color: Colors.orange,
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
