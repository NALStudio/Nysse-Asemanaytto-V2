import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/main/main_layout.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  final HttpLink digitransitHttpLink = HttpLink(
    "https://api.digitransit.fi/routing/v1/routers/waltti/index/graphql",
  );
  final AuthLink digitransitAuthLink = AuthLink(
    headerKey: "digitransit-subscription-key",
    getToken: () => dotenv.env["DIGITRANSIT_API_KEY"],
  );
  final Link digitransitLink = digitransitAuthLink.concat(digitransitHttpLink);

  ValueNotifier<GraphQLClient> digitransitClient = ValueNotifier(
    GraphQLClient(
      link: digitransitLink,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    ),
  );

  runApp(MainApp(digitransitClient: digitransitClient));
}

class MainApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> digitransitClient;

  const MainApp({
    super.key,
    required this.digitransitClient,
  });

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: digitransitClient,
      child: const MaterialApp(
        title: "Nysse Asemanäyttö",
        home: AppServices(),
      ),
    );
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
