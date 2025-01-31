import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/components/screen_darken.dart';
import 'package:nysse_asemanaytto/embeds/_hue_embed/hue_embed_settings.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import 'package:nysse_asemanaytto/philips_hue/_icons.dart';
import 'package:nysse_asemanaytto/philips_hue/philips_hue.dart';

GlobalKey<_HueEmbedState> _hueWidget = GlobalKey();

class HueEmbed extends Embed {
  const HueEmbed({required super.name});

  @override
  EmbedSettings<Embed> createDefaultSettings() {
    return HueEmbedSettings(
      bridge: null,
      darkenOnLightsOff: true,
      darkenOnEntertainment: true,
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
  Duration? getDuration() => Duration(seconds: 10);

  @override
  void onEnable() {
    _hueWidget.currentState?.onEnabled();
  }

  @override
  void onDisable() {}
}

class _HueEmbedState extends State<_HueEmbedWidget> {
  HueEventApi? _hue;

  ScreenDarkenHandle? _screenDarkenHandle;

  List<HueLight> _lights = List.empty();
  bool _entertainmentOn = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _screenDarkenHandle?.dispose();
    _screenDarkenHandle = ScreenDarkenWidget.maybeOf(context)?.createHandle();
  }

  Future onEnabled() async {
    HueBridge? bridge = widget.settings.bridge;
    if (_hue?.bridge.ipAddress != bridge?.ipAddress ||
        _hue?.connected == false) {
      _hue?.dispose();
      _hue = await connectApi(bridge);

      _hue?.addListener(updateHueState);
      updateHueState(); // update state immediately and don't wait for an event
    }
  }

  Future<HueEventApi?> connectApi(HueBridge? bridge) async {
    if (bridge == null) return null;

    return await HueEventApi.listen(
      bridge: bridge,
      types: [
        HueResourceType.light,
        HueResourceType.entertainmentConfiguration
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.settings.bridge == null) {
      return ErrorWidget.withDetails(message: "No bridge selected.");
    }

    if (_hue?.connected != true) {
      return ErrorWidget.withDetails(message: "Philips Hue disconnected.");
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
          HueLight l = _lights[index];
          return _HueEmbedLight(l, isEntertaining: _entertainmentOn);
        },
      ),
    );
  }

  void updateHueState() {
    bool entertainmentOn = false;
    bool anyLightsOn = false;
    List<HueLight> lights = List.empty(growable: true);
    for (HueResource r in _hue!.resources) {
      if (r is HueLight) {
        lights.add(r);

        if (r.isOn) {
          anyLightsOn = true;
        }
      } else if (r is HueEntertainmentConfiguration && r.isActive) {
        entertainmentOn = true;
      }
    }

    lights.sort((a, b) {
      String aName = _HueEmbedLight.getLightName(a);
      String bName = _HueEmbedLight.getLightName(b);
      return aName.compareTo(bName);
    });

    setState(() {
      _lights = lights;
      _entertainmentOn = entertainmentOn;
    });

    if ((!anyLightsOn && widget.settings.darkenOnLightsOff) ||
        (entertainmentOn && widget.settings.darkenOnEntertainment)) {
      _screenDarkenHandle?.activate();
    } else {
      _screenDarkenHandle?.deactivate();
    }
  }

  @override
  void dispose() {
    // fix crash: remove listener before dispose
    _hue?.removeListener(updateHueState);
    _hue?.dispose();

    _screenDarkenHandle?.dispose();

    super.dispose();
  }
}

class _HueEmbedLight extends StatelessWidget {
  final HueLight light;
  final bool isEntertaining;

  const _HueEmbedLight(this.light, {required this.isEntertaining});

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(context);

    Color? color;
    if (isEntertaining) {
      color = Color(0xFFFFFFFF);
    } else if (light.isOn) {
      final xy = light.color.xy;
      color = HueColorConverter.colorFromXY(xy);
    }

    final double brightness = light.dimming.brightness / 100;

    Color foregroundColor =
        brightness < 0.5 || color == null || color.computeLuminance() < 0.5
            ? Colors.white
            : Color(0xFF383838);

    const Color offColor = Color(0xFF303236);

    return AnimatedContainer(
      duration: Durations.medium1,
      decoration: BoxDecoration(
        color: offColor,
        gradient: getLightColorGradient(
          color,
          offColor: offColor,
          brightness: brightness,
        ),
        borderRadius: BorderRadius.circular(Layout.of(context).shrinkedPadding),
      ),
      child: Padding(
        padding: EdgeInsets.all(layout.padding),
        child: Row(
          children: [
            Icon(
              getLightIcon(light),
              size: layout.doublePadding,
              color: foregroundColor,
            ),
            SizedBox(width: layout.widePadding),
            Text(
              getLightName(light),
              style: TextStyle(
                fontFamily: "NeueFrutiger",
                fontWeight: FontWeight.bold,
                fontSize: layout.padding,
                color: foregroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String getLightName(HueLight l) {
    return l.metadata.name;
  }

  static IconData getLightIcon(HueLight l) {
    return HueIcons.findArchetype(l.metadata.archetype) ??
        HueIcons.questionMark;
  }

  LinearGradient? getLightColorGradient(
    Color? color, {
    required Color offColor,
    required double brightness,
  }) {
    if (color == null) return null;

    // HSVColor.lerp provided ugly middle colors
    Color endColor = Color.lerp(color, offColor, 1.0 - brightness)!;

    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [color, endColor],
    );
  }
}
