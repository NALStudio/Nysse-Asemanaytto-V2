import 'package:flutter_svg/flutter_svg.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';

class NyssePictogramSvg extends SvgAssetLoader {
  const NyssePictogramSvg(super.assetName, this.borderless);

  final SvgAssetLoader borderless;
}

class NyssePictograms {
  static const NyssePictogramSvg bus = NyssePictogramSvg(
    "assets/images/pictogram_bussi.svg",
    SvgAssetLoader("assets/images/pictogram_bussi_borderless.svg"),
  );

  static const NyssePictogramSvg tram = NyssePictogramSvg(
    "assets/images/pictogram_ratikka.svg",
    SvgAssetLoader("assets/images/pictogram_ratikka_borderless.svg"),
  );

  static const NyssePictogramSvg train = NyssePictogramSvg(
    "assets/images/pictogram_juna.svg",
    SvgAssetLoader("assets/images/pictogram_juna_borderless.svg"),
  );

  static const NyssePictogramSvg bike = NyssePictogramSvg(
    "assets/images/pictogram_kaupunkipyora.svg",
    SvgAssetLoader("assets/images/pictogram_kaupunkipyora_borderless.svg"),
  );

  static const SvgAssetLoader routes =
      SvgAssetLoader("assets/images/pictogram_reitit.svg");

  static NyssePictogramSvg getModePictogram(DigitransitMode mode) {
    switch (mode) {
      case DigitransitMode.bus:
        return bus;
      case DigitransitMode.tram:
        return tram;
      case DigitransitMode.rail:
        return train;
      case DigitransitMode.bicycle:
        return bike;
      default:
        throw ArgumentError.value(
          mode,
          "mode",
          "No pictogram defined for mode: '$mode'",
        );
    }
  }
}
