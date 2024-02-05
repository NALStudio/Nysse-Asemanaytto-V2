import 'package:flutter_svg/flutter_svg.dart';

import '_transit_modes.dart';

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

  NyssePictogramSvg getModePictogram(NysseTransitMode mode) {
    return switch (mode) {
      NysseTransitMode.bus => bus,
      NysseTransitMode.tram => tram,
      NysseTransitMode.train => train,
      NysseTransitMode.bike => bike,
    };
  }
}
