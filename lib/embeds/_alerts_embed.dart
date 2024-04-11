import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/request_info.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';
import 'package:nysse_asemanaytto/settings/settings_switch_form_field.dart';

final GlobalKey<_InternalEmbedWidgetState> _internalEmbedKey = GlobalKey();

class AlertsEmbed extends Embed {
  const AlertsEmbed({required super.name});

  @override
  EmbedSettings<AlertsEmbed> createDefaultSettings() => AlertsEmbedSettings(
        hideIfNoAlerts: true,
      );

  @override
  EmbedWidgetMixin<AlertsEmbed> createEmbed(
          covariant AlertsEmbedSettings settings) =>
      AlertsEmbedWidget(settings: settings);
}

class AlertsEmbedWidget extends StatefulWidget
    implements EmbedWidgetMixin<AlertsEmbed> {
  final AlertsEmbedSettings settings;

  const AlertsEmbedWidget({super.key, required this.settings});

  @override
  State<AlertsEmbedWidget> createState() => _AlertsEmbedWidgetState();

  @override
  Duration? getDuration() {
    final widget = _internalEmbedKey.currentWidget as _InternalEmbedWidget?;
    if (settings.hideIfNoAlerts && (widget == null || widget.alerts.isEmpty)) {
      return null;
    }
    return const Duration(seconds: 10);
  }

  @override
  void onDisable() {}

  @override
  void onEnable() {
    _internalEmbedKey.currentState?.switchEmbed();
  }
}

class _AlertsEmbedWidgetState extends State<AlertsEmbedWidget> {
  @override
  Widget build(BuildContext context) {
    final GtfsId stopGtfsId = Config.of(context).stopId;

    return Query(
      options: QueryOptions(
        document: gql(DigitransitAlertsQuery.query),
        variables: {
          "feeds": [stopGtfsId.feedId],
          "stopId": stopGtfsId.id,
        },
        pollInterval: RequestInfo.ratelimits.alertsRequest,
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return ErrorWidget(result.exception!);
        }

        final Map<String, dynamic>? data = result.data;
        final DigitransitAlertsQuery? parsed =
            data != null ? DigitransitAlertsQuery.parse(data) : null;

        final Iterable<DigitransitAlert> alerts;
        if (parsed != null) {
          alerts = parsed.globalSevere.followedBy(parsed.localAll);
        } else {
          alerts = const Iterable.empty();
        }

        return _InternalEmbedWidget(
          key: _internalEmbedKey,
          alerts: List.from(alerts),
        );
      },
    );
  }
}

class _InternalEmbedWidget extends StatefulWidget {
  final List<DigitransitAlert> alerts;

  const _InternalEmbedWidget({super.key, required this.alerts});

  @override
  State<_InternalEmbedWidget> createState() => _InternalEmbedWidgetState();
}

class _InternalEmbedWidgetState extends State<_InternalEmbedWidget> {
  int? _index;

  void _switchEmbed() {
    if (widget.alerts.isEmpty) {
      _index = null;
    } else if (_index != null) {
      _index = (_index! + 1) % widget.alerts.length;
    } else {
      _index = 0;
    }
  }

  void switchEmbed() => setState(_switchEmbed);

  @override
  Widget build(BuildContext context) {
    if (_index == null || _index! >= widget.alerts.length) {
      _switchEmbed();
    }
    final DigitransitAlert? alert =
        _index != null ? widget.alerts[_index!] : null;

    final layout = Layout.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: NysseColors.white,
        border: Border.all(
          color: NysseColors.orange,
          width: 10 * layout.logicalPixelSize,
        ),
        borderRadius: BorderRadius.circular(layout.padding),
      ),
      child: Padding(
        padding: EdgeInsets.all(layout.padding),
        child: alert != null ? _buildAlert(alert) : _buildNoAlerts(),
      ),
    );
  }

  Widget _buildNoAlerts() {
    return Center(
      child: Text(
        "Ei häiriöitä Nyssen toiminnassa.",
        style: TextStyle(
          color: Colors.grey,
          fontSize: Layout.of(context).labelStyle.fontSize! / 2,
        ),
      ),
    );
  }

  Widget _buildAlert(final DigitransitAlert alert) {
    return Text(
      alert.description,
      style: TextStyle(
        color: Colors.black,
        fontSize: Layout.of(context).labelStyle.fontSize! / 2,
      ),
    );
  }
}

class AlertsEmbedSettings extends EmbedSettings<AlertsEmbed> {
  bool hideIfNoAlerts;

  AlertsEmbedSettings({required this.hideIfNoAlerts});

  @override
  EmbedSettingsForm<AlertsEmbedSettings> createForm(
          covariant AlertsEmbedSettings defaultSettings) =>
      AlertsEmbedSettingsForm(
        parentSettings: this,
        defaultSettings: defaultSettings,
      );

  @override
  void deserialize(String serialized) {}

  // TODO:
  @override
  String serialize() => "";
}

class AlertsEmbedSettingsForm extends EmbedSettingsForm<AlertsEmbedSettings> {
  AlertsEmbedSettingsForm({
    required super.parentSettings,
    required super.defaultSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsSwitchFormField(
          initialValue: parentSettings.hideIfNoAlerts,
          titleText: "Allow Hide",
          subtitleText:
              "Allows the alerts embed to be hidden when there are no alerts to display.",
          onSaved: (newValue) => parentSettings.hideIfNoAlerts = newValue!,
        )
      ],
    );
  }

  @override
  Color get displayColor => Colors.red;

  @override
  String get displayName => "Alerts Embed";
}
