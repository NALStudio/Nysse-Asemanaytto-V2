import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/digitransit/enums.dart';

class NysseColor extends ColorSwatch<int> {
  const NysseColor(super.primary, super.swatch);

  Color get shade70 => this[70]!;
  Color get shade10 => this[10]!;
}

class NysseColors {
  static const white = Color(0xffffffff);

  static const lightBlue = Color(0xffcdeafc);
  static const mediumBlue = Color(0xff1c57cf);
  static const darkBlue = Color(0xff1a4a8f);

  static const Color orange = Color(0xffeb5e47);

  static const NysseColor purple = NysseColor(
    0xff6842ab,
    {
      70: Color(0xff977cc6),
      10: Color(0xfff6f1ff),
    },
  );
  static const NysseColor pink = NysseColor(
    0xffd62560,
    {
      70: Color(0xffec4b8f),
      10: Color(0xfffff2f7),
    },
  );
  static const NysseColor green = NysseColor(
    0xff0e7f3c,
    {
      70: Color(0xff00ba53),
      10: Color(0xffedfff1),
    },
  );
  static const NysseColor tramRed = NysseColor(
    0xffda2128,
    {
      70: Color(0xfff88f8b),
      10: Color(0xfffff3ee),
    },
  );

  static const Color serviceTickets = Color(0xffee4b8f);
  static const Color serviceBus = mediumBlue;
  static const Color serviceTram = tramRed;
  static const Color serviceTrain = Color(0xff40ba53);
  static const Color serviceBike = purple;

  Color getModeColor(DigitransitMode mode) {
    switch (mode) {
      case DigitransitMode.bus:
        return serviceBus;
      case DigitransitMode.tram:
        return serviceTram;
      case DigitransitMode.rail:
        return serviceTrain;
      case DigitransitMode.bicycle:
        return serviceBike;
      default:
        throw ArgumentError.value(
          mode,
          "mode",
          "No color defined for mode: '$mode'",
        );
    }
  }
}
