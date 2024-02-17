import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/main/error_layout.dart';
import 'package:nysse_asemanaytto/main/main_layout.dart';
import 'package:nysse_asemanaytto/main/settings_layout.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kRouteHome = "/home";
const String _kRouteSettings = "/settings";

Future<void> main() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MainApp(sharedPreferences: prefs));
}

class MainApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MainApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return ConfigWidget(
      prefs: sharedPreferences,
      child: MaterialApp(
        title: "Nysse Asemanäyttö",
        initialRoute: _kRouteHome,
        routes: {
          _kRouteHome: (context) =>
              const _SettingsVerificationRouter(child: AppServices()),
          _kRouteSettings: (context) => const SettingsLayout(),
        },
      ),
    );
  }
}

class _SettingsVerificationRouter extends StatelessWidget {
  final Widget child;

  const _SettingsVerificationRouter({required this.child});

  @override
  Widget build(BuildContext context) {
    final Config config = Config.of(context);
    if (config.digitransitSubscriptionKey == null) {
      return const ErrorLayout(
        message: "No Digitransit subscription key provided",
        description: "Open settings by pressing F1",
      );
    }

    return child;
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

class AppCanvas extends StatelessWidget {
  const AppCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: NysseColors.mediumBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MainCanvas(),
          EmbedCanvas(),
          _Footer(),
        ],
      ),
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
              style: layout.shrinkedLabelStyle
                  .copyWith(fontFamily: "LotaGrotesque"),
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
