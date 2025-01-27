import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hue/flutter_hue.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/embeds/_hue_embed/hue_embed_settings.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import 'package:nysse_asemanaytto/philips_hue/hue_icons_helper.dart';

GlobalKey<_HueEmbedState> _hueWidget = GlobalKey();

class HueEmbed extends Embed {
  const HueEmbed({required super.name});

  @override
  EmbedSettings<Embed> createDefaultSettings() {
    return HueEmbedSettings(
      bridge: null,
    );
  }

  @override
  EmbedWidgetMixin<Embed> createEmbed(covariant HueEmbedSettings settings) =>
      _HueEmbedWidget(key: _hueWidget, settings: settings);
}

class _HueEmbedWidget extends StatefulWidget with EmbedWidgetMixin<HueEmbed> {
  final HueEmbedSettings settings;

  const _HueEmbedWidget({super.key, required this.settings});

  @override
  State<_HueEmbedWidget> createState() => _HueEmbedState();

  @override
  Duration? getDuration() => Duration(seconds: 5);

  @override
  void onEnable() {
    _hueWidget.currentState?.update();
  }

  @override
  void onDisable() {}
}

class _HueEmbedState extends State<_HueEmbedWidget> {
  HueNetwork? _network;
  List<Light> _lights = List.empty();
  bool _entertainmentOn = false;

  @override
  Widget build(BuildContext context) {
    if (widget.settings.bridge == null) {
      return ErrorWidget.withDetails(message: "No bridge selected.");
    }

    final layout = Layout.of(context);

    return Container(
      color: Color(0xFF181B1F),
      padding: EdgeInsets.only(
        top: layout.padding,
        left: layout.padding,
        right: layout.padding,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 32 / 9,
          mainAxisSpacing: layout.padding,
          crossAxisSpacing: layout.padding,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: _lights.length,
        itemBuilder: (context, index) {
          Light l = _lights[index];
          return _HueEmbedLight(l, isEntertaining: _entertainmentOn);
        },
      ),
    );
  }

  Future update() async {
    if (_network == null) {
      Bridge? bridge = widget.settings.bridge;
      if (bridge != null) {
        _network = HueNetwork(bridges: [bridge]);
      }
    }

    if (_network != null) {
      await fetchData(_network!);
    }
  }

  Future fetchData(HueNetwork hue) async {
    await hue.fetchAllType(ResourceType.light);

    List<Light> lights = hue.lights.toList(growable: false);
    lights.sort((a, b) {
      String aName = _HueEmbedLight.getRawLightName(a);
      String bName = _HueEmbedLight.getRawLightName(b);
      return aName.compareTo(bName);
    });

    if (mounted) {
      setState(() {
        _lights = lights;
      });
    }

    await hue.fetchAllType(ResourceType.entertainmentConfiguration);

    bool entertaining = hue.entertainmentConfigurations.any(
      (e) => e.status == "active",
    );

    if (mounted) {
      setState(() {
        _entertainmentOn = entertaining;
      });
    }
  }
}

class _HueEmbedLight extends StatelessWidget {
  final Light light;
  final bool isEntertaining;

  const _HueEmbedLight(this.light, {required this.isEntertaining});

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(context);

    final Color color;
    if (isEntertaining) {
      color = Color(0xFFFFFFFF);
    } else if (light.isOn) {
      final xy = light.color.xy;
      final double brightness = light.dimming.brightness / 100;
      List<int> rgb = ColorConverter.xy2rgb(xy.x, xy.y, brightness);
      color = Color.fromARGB(255, rgb[0], rgb[1], rgb[2]);
    } else {
      color = const Color(0xFF303236);
    }

    Color foregroundColor =
        color.computeLuminance() >= 0.5 ? Colors.black : Colors.white;

    return AnimatedContainer(
      duration: Durations.medium1,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Layout.of(context).shrinkedPadding),
      ),
      child: Padding(
        padding: EdgeInsets.all(layout.padding),
        child: Row(
          children: [
            Icon(getLightIcon(), color: foregroundColor),
            SizedBox(width: layout.widePadding),
            Text(
              getLightName(),
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontWeight: FontWeight.bold,
                    color: foregroundColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  static String getRawLightName(Light l) {
    // ignore: deprecated_member_use
    return l.metadata.name;
  }

  String getLightName() {
    String name = getRawLightName(light);
    Uint8List encoded = latin1.encode(name); // re-encode to fix ä and ö
    return utf8.decode(encoded);
  }

  IconData? getLightIcon() {
    // ignore: deprecated_member_use
    LightArchetype arch = light.metadata.archetype;
    return HueIconsHelper.toIcon(arch);
  }
}
