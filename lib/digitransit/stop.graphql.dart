import 'package:gql/ast.dart';
import 'schema.graphql.dart';

class Variables$Query$FetchStopInfo {
  factory Variables$Query$FetchStopInfo({required String id}) =>
      Variables$Query$FetchStopInfo._({
        r'id': id,
      });

  Variables$Query$FetchStopInfo._(this._$data);

  factory Variables$Query$FetchStopInfo.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return Variables$Query$FetchStopInfo._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  CopyWith$Variables$Query$FetchStopInfo<Variables$Query$FetchStopInfo>
      get copyWith => CopyWith$Variables$Query$FetchStopInfo(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$FetchStopInfo) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }
}

abstract class CopyWith$Variables$Query$FetchStopInfo<TRes> {
  factory CopyWith$Variables$Query$FetchStopInfo(
    Variables$Query$FetchStopInfo instance,
    TRes Function(Variables$Query$FetchStopInfo) then,
  ) = _CopyWithImpl$Variables$Query$FetchStopInfo;

  factory CopyWith$Variables$Query$FetchStopInfo.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$FetchStopInfo;

  TRes call({String? id});
}

class _CopyWithImpl$Variables$Query$FetchStopInfo<TRes>
    implements CopyWith$Variables$Query$FetchStopInfo<TRes> {
  _CopyWithImpl$Variables$Query$FetchStopInfo(
    this._instance,
    this._then,
  );

  final Variables$Query$FetchStopInfo _instance;

  final TRes Function(Variables$Query$FetchStopInfo) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined}) =>
      _then(Variables$Query$FetchStopInfo._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as String),
      }));
}

class _CopyWithStubImpl$Variables$Query$FetchStopInfo<TRes>
    implements CopyWith$Variables$Query$FetchStopInfo<TRes> {
  _CopyWithStubImpl$Variables$Query$FetchStopInfo(this._res);

  TRes _res;

  call({String? id}) => _res;
}

class Query$FetchStopInfo {
  Query$FetchStopInfo({
    this.stop,
    this.$__typename = 'QueryType',
  });

  factory Query$FetchStopInfo.fromJson(Map<String, dynamic> json) {
    final l$stop = json['stop'];
    final l$$__typename = json['__typename'];
    return Query$FetchStopInfo(
      stop: l$stop == null
          ? null
          : Query$FetchStopInfo$stop.fromJson((l$stop as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$FetchStopInfo$stop? stop;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$stop = stop;
    _resultData['stop'] = l$stop?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$stop = stop;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$stop,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$FetchStopInfo) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$stop = stop;
    final lOther$stop = other.stop;
    if (l$stop != lOther$stop) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$FetchStopInfo on Query$FetchStopInfo {
  CopyWith$Query$FetchStopInfo<Query$FetchStopInfo> get copyWith =>
      CopyWith$Query$FetchStopInfo(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$FetchStopInfo<TRes> {
  factory CopyWith$Query$FetchStopInfo(
    Query$FetchStopInfo instance,
    TRes Function(Query$FetchStopInfo) then,
  ) = _CopyWithImpl$Query$FetchStopInfo;

  factory CopyWith$Query$FetchStopInfo.stub(TRes res) =
      _CopyWithStubImpl$Query$FetchStopInfo;

  TRes call({
    Query$FetchStopInfo$stop? stop,
    String? $__typename,
  });
  CopyWith$Query$FetchStopInfo$stop<TRes> get stop;
}

class _CopyWithImpl$Query$FetchStopInfo<TRes>
    implements CopyWith$Query$FetchStopInfo<TRes> {
  _CopyWithImpl$Query$FetchStopInfo(
    this._instance,
    this._then,
  );

  final Query$FetchStopInfo _instance;

  final TRes Function(Query$FetchStopInfo) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? stop = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$FetchStopInfo(
        stop: stop == _undefined
            ? _instance.stop
            : (stop as Query$FetchStopInfo$stop?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$FetchStopInfo$stop<TRes> get stop {
    final local$stop = _instance.stop;
    return local$stop == null
        ? CopyWith$Query$FetchStopInfo$stop.stub(_then(_instance))
        : CopyWith$Query$FetchStopInfo$stop(local$stop, (e) => call(stop: e));
  }
}

class _CopyWithStubImpl$Query$FetchStopInfo<TRes>
    implements CopyWith$Query$FetchStopInfo<TRes> {
  _CopyWithStubImpl$Query$FetchStopInfo(this._res);

  TRes _res;

  call({
    Query$FetchStopInfo$stop? stop,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$FetchStopInfo$stop<TRes> get stop =>
      CopyWith$Query$FetchStopInfo$stop.stub(_res);
}

const documentNodeQueryFetchStopInfo = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'FetchStopInfo'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'id')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'stop'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'id'),
            value: VariableNode(name: NameNode(value: 'id')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'code'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'lat'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'lon'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'vehicleMode'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);

class Query$FetchStopInfo$stop {
  Query$FetchStopInfo$stop({
    required this.name,
    this.code,
    this.lat,
    this.lon,
    this.vehicleMode,
    this.$__typename = 'Stop',
  });

  factory Query$FetchStopInfo$stop.fromJson(Map<String, dynamic> json) {
    final l$name = json['name'];
    final l$code = json['code'];
    final l$lat = json['lat'];
    final l$lon = json['lon'];
    final l$vehicleMode = json['vehicleMode'];
    final l$$__typename = json['__typename'];
    return Query$FetchStopInfo$stop(
      name: (l$name as String),
      code: (l$code as String?),
      lat: (l$lat as num?)?.toDouble(),
      lon: (l$lon as num?)?.toDouble(),
      vehicleMode: l$vehicleMode == null
          ? null
          : fromJson$Enum$Mode((l$vehicleMode as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String name;

  final String? code;

  final double? lat;

  final double? lon;

  final Enum$Mode? vehicleMode;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$name = name;
    _resultData['name'] = l$name;
    final l$code = code;
    _resultData['code'] = l$code;
    final l$lat = lat;
    _resultData['lat'] = l$lat;
    final l$lon = lon;
    _resultData['lon'] = l$lon;
    final l$vehicleMode = vehicleMode;
    _resultData['vehicleMode'] =
        l$vehicleMode == null ? null : toJson$Enum$Mode(l$vehicleMode);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$name = name;
    final l$code = code;
    final l$lat = lat;
    final l$lon = lon;
    final l$vehicleMode = vehicleMode;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$name,
      l$code,
      l$lat,
      l$lon,
      l$vehicleMode,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$FetchStopInfo$stop) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$code = code;
    final lOther$code = other.code;
    if (l$code != lOther$code) {
      return false;
    }
    final l$lat = lat;
    final lOther$lat = other.lat;
    if (l$lat != lOther$lat) {
      return false;
    }
    final l$lon = lon;
    final lOther$lon = other.lon;
    if (l$lon != lOther$lon) {
      return false;
    }
    final l$vehicleMode = vehicleMode;
    final lOther$vehicleMode = other.vehicleMode;
    if (l$vehicleMode != lOther$vehicleMode) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$FetchStopInfo$stop
    on Query$FetchStopInfo$stop {
  CopyWith$Query$FetchStopInfo$stop<Query$FetchStopInfo$stop> get copyWith =>
      CopyWith$Query$FetchStopInfo$stop(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$FetchStopInfo$stop<TRes> {
  factory CopyWith$Query$FetchStopInfo$stop(
    Query$FetchStopInfo$stop instance,
    TRes Function(Query$FetchStopInfo$stop) then,
  ) = _CopyWithImpl$Query$FetchStopInfo$stop;

  factory CopyWith$Query$FetchStopInfo$stop.stub(TRes res) =
      _CopyWithStubImpl$Query$FetchStopInfo$stop;

  TRes call({
    String? name,
    String? code,
    double? lat,
    double? lon,
    Enum$Mode? vehicleMode,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$FetchStopInfo$stop<TRes>
    implements CopyWith$Query$FetchStopInfo$stop<TRes> {
  _CopyWithImpl$Query$FetchStopInfo$stop(
    this._instance,
    this._then,
  );

  final Query$FetchStopInfo$stop _instance;

  final TRes Function(Query$FetchStopInfo$stop) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? name = _undefined,
    Object? code = _undefined,
    Object? lat = _undefined,
    Object? lon = _undefined,
    Object? vehicleMode = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$FetchStopInfo$stop(
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        code: code == _undefined ? _instance.code : (code as String?),
        lat: lat == _undefined ? _instance.lat : (lat as double?),
        lon: lon == _undefined ? _instance.lon : (lon as double?),
        vehicleMode: vehicleMode == _undefined
            ? _instance.vehicleMode
            : (vehicleMode as Enum$Mode?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$FetchStopInfo$stop<TRes>
    implements CopyWith$Query$FetchStopInfo$stop<TRes> {
  _CopyWithStubImpl$Query$FetchStopInfo$stop(this._res);

  TRes _res;

  call({
    String? name,
    String? code,
    double? lat,
    double? lon,
    Enum$Mode? vehicleMode,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$FetchStopStoptimes {
  factory Variables$Query$FetchStopStoptimes({
    required String id,
    required int numberOfDepartures,
    required bool omitNonPickups,
    required bool omitCanceled,
  }) =>
      Variables$Query$FetchStopStoptimes._({
        r'id': id,
        r'numberOfDepartures': numberOfDepartures,
        r'omitNonPickups': omitNonPickups,
        r'omitCanceled': omitCanceled,
      });

  Variables$Query$FetchStopStoptimes._(this._$data);

  factory Variables$Query$FetchStopStoptimes.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$numberOfDepartures = data['numberOfDepartures'];
    result$data['numberOfDepartures'] = (l$numberOfDepartures as int);
    final l$omitNonPickups = data['omitNonPickups'];
    result$data['omitNonPickups'] = (l$omitNonPickups as bool);
    final l$omitCanceled = data['omitCanceled'];
    result$data['omitCanceled'] = (l$omitCanceled as bool);
    return Variables$Query$FetchStopStoptimes._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  int get numberOfDepartures => (_$data['numberOfDepartures'] as int);

  bool get omitNonPickups => (_$data['omitNonPickups'] as bool);

  bool get omitCanceled => (_$data['omitCanceled'] as bool);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$numberOfDepartures = numberOfDepartures;
    result$data['numberOfDepartures'] = l$numberOfDepartures;
    final l$omitNonPickups = omitNonPickups;
    result$data['omitNonPickups'] = l$omitNonPickups;
    final l$omitCanceled = omitCanceled;
    result$data['omitCanceled'] = l$omitCanceled;
    return result$data;
  }

  CopyWith$Variables$Query$FetchStopStoptimes<
          Variables$Query$FetchStopStoptimes>
      get copyWith => CopyWith$Variables$Query$FetchStopStoptimes(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$FetchStopStoptimes) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$numberOfDepartures = numberOfDepartures;
    final lOther$numberOfDepartures = other.numberOfDepartures;
    if (l$numberOfDepartures != lOther$numberOfDepartures) {
      return false;
    }
    final l$omitNonPickups = omitNonPickups;
    final lOther$omitNonPickups = other.omitNonPickups;
    if (l$omitNonPickups != lOther$omitNonPickups) {
      return false;
    }
    final l$omitCanceled = omitCanceled;
    final lOther$omitCanceled = other.omitCanceled;
    if (l$omitCanceled != lOther$omitCanceled) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$numberOfDepartures = numberOfDepartures;
    final l$omitNonPickups = omitNonPickups;
    final l$omitCanceled = omitCanceled;
    return Object.hashAll([
      l$id,
      l$numberOfDepartures,
      l$omitNonPickups,
      l$omitCanceled,
    ]);
  }
}

abstract class CopyWith$Variables$Query$FetchStopStoptimes<TRes> {
  factory CopyWith$Variables$Query$FetchStopStoptimes(
    Variables$Query$FetchStopStoptimes instance,
    TRes Function(Variables$Query$FetchStopStoptimes) then,
  ) = _CopyWithImpl$Variables$Query$FetchStopStoptimes;

  factory CopyWith$Variables$Query$FetchStopStoptimes.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$FetchStopStoptimes;

  TRes call({
    String? id,
    int? numberOfDepartures,
    bool? omitNonPickups,
    bool? omitCanceled,
  });
}

class _CopyWithImpl$Variables$Query$FetchStopStoptimes<TRes>
    implements CopyWith$Variables$Query$FetchStopStoptimes<TRes> {
  _CopyWithImpl$Variables$Query$FetchStopStoptimes(
    this._instance,
    this._then,
  );

  final Variables$Query$FetchStopStoptimes _instance;

  final TRes Function(Variables$Query$FetchStopStoptimes) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? numberOfDepartures = _undefined,
    Object? omitNonPickups = _undefined,
    Object? omitCanceled = _undefined,
  }) =>
      _then(Variables$Query$FetchStopStoptimes._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as String),
        if (numberOfDepartures != _undefined && numberOfDepartures != null)
          'numberOfDepartures': (numberOfDepartures as int),
        if (omitNonPickups != _undefined && omitNonPickups != null)
          'omitNonPickups': (omitNonPickups as bool),
        if (omitCanceled != _undefined && omitCanceled != null)
          'omitCanceled': (omitCanceled as bool),
      }));
}

class _CopyWithStubImpl$Variables$Query$FetchStopStoptimes<TRes>
    implements CopyWith$Variables$Query$FetchStopStoptimes<TRes> {
  _CopyWithStubImpl$Variables$Query$FetchStopStoptimes(this._res);

  TRes _res;

  call({
    String? id,
    int? numberOfDepartures,
    bool? omitNonPickups,
    bool? omitCanceled,
  }) =>
      _res;
}

class Query$FetchStopStoptimes {
  Query$FetchStopStoptimes({
    this.stop,
    this.$__typename = 'QueryType',
  });

  factory Query$FetchStopStoptimes.fromJson(Map<String, dynamic> json) {
    final l$stop = json['stop'];
    final l$$__typename = json['__typename'];
    return Query$FetchStopStoptimes(
      stop: l$stop == null
          ? null
          : Query$FetchStopStoptimes$stop.fromJson(
              (l$stop as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$FetchStopStoptimes$stop? stop;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$stop = stop;
    _resultData['stop'] = l$stop?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$stop = stop;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$stop,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$FetchStopStoptimes) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$stop = stop;
    final lOther$stop = other.stop;
    if (l$stop != lOther$stop) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$FetchStopStoptimes
    on Query$FetchStopStoptimes {
  CopyWith$Query$FetchStopStoptimes<Query$FetchStopStoptimes> get copyWith =>
      CopyWith$Query$FetchStopStoptimes(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$FetchStopStoptimes<TRes> {
  factory CopyWith$Query$FetchStopStoptimes(
    Query$FetchStopStoptimes instance,
    TRes Function(Query$FetchStopStoptimes) then,
  ) = _CopyWithImpl$Query$FetchStopStoptimes;

  factory CopyWith$Query$FetchStopStoptimes.stub(TRes res) =
      _CopyWithStubImpl$Query$FetchStopStoptimes;

  TRes call({
    Query$FetchStopStoptimes$stop? stop,
    String? $__typename,
  });
  CopyWith$Query$FetchStopStoptimes$stop<TRes> get stop;
}

class _CopyWithImpl$Query$FetchStopStoptimes<TRes>
    implements CopyWith$Query$FetchStopStoptimes<TRes> {
  _CopyWithImpl$Query$FetchStopStoptimes(
    this._instance,
    this._then,
  );

  final Query$FetchStopStoptimes _instance;

  final TRes Function(Query$FetchStopStoptimes) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? stop = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$FetchStopStoptimes(
        stop: stop == _undefined
            ? _instance.stop
            : (stop as Query$FetchStopStoptimes$stop?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$FetchStopStoptimes$stop<TRes> get stop {
    final local$stop = _instance.stop;
    return local$stop == null
        ? CopyWith$Query$FetchStopStoptimes$stop.stub(_then(_instance))
        : CopyWith$Query$FetchStopStoptimes$stop(
            local$stop, (e) => call(stop: e));
  }
}

class _CopyWithStubImpl$Query$FetchStopStoptimes<TRes>
    implements CopyWith$Query$FetchStopStoptimes<TRes> {
  _CopyWithStubImpl$Query$FetchStopStoptimes(this._res);

  TRes _res;

  call({
    Query$FetchStopStoptimes$stop? stop,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$FetchStopStoptimes$stop<TRes> get stop =>
      CopyWith$Query$FetchStopStoptimes$stop.stub(_res);
}

const documentNodeQueryFetchStopStoptimes = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'FetchStopStoptimes'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'id')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'numberOfDepartures')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'omitNonPickups')),
        type: NamedTypeNode(
          name: NameNode(value: 'Boolean'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: BooleanValueNode(value: true)),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'omitCanceled')),
        type: NamedTypeNode(
          name: NameNode(value: 'Boolean'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: BooleanValueNode(value: false)),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'stop'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'id'),
            value: VariableNode(name: NameNode(value: 'id')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'stoptimesWithoutPatterns'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'numberOfDepartures'),
                value:
                    VariableNode(name: NameNode(value: 'numberOfDepartures')),
              ),
              ArgumentNode(
                name: NameNode(value: 'omitNonPickups'),
                value: VariableNode(name: NameNode(value: 'omitNonPickups')),
              ),
              ArgumentNode(
                name: NameNode(value: 'omitCanceled'),
                value: VariableNode(name: NameNode(value: 'omitCanceled')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'scheduledDeparture'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'realtimeDeparture'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'serviceDay'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'realtime'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'realtimeState'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'headsign'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);

class Query$FetchStopStoptimes$stop {
  Query$FetchStopStoptimes$stop({
    this.stoptimesWithoutPatterns,
    this.$__typename = 'Stop',
  });

  factory Query$FetchStopStoptimes$stop.fromJson(Map<String, dynamic> json) {
    final l$stoptimesWithoutPatterns = json['stoptimesWithoutPatterns'];
    final l$$__typename = json['__typename'];
    return Query$FetchStopStoptimes$stop(
      stoptimesWithoutPatterns: (l$stoptimesWithoutPatterns as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns.fromJson(
                  (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns?>?
      stoptimesWithoutPatterns;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$stoptimesWithoutPatterns = stoptimesWithoutPatterns;
    _resultData['stoptimesWithoutPatterns'] =
        l$stoptimesWithoutPatterns?.map((e) => e?.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$stoptimesWithoutPatterns = stoptimesWithoutPatterns;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$stoptimesWithoutPatterns == null
          ? null
          : Object.hashAll(l$stoptimesWithoutPatterns.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$FetchStopStoptimes$stop) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$stoptimesWithoutPatterns = stoptimesWithoutPatterns;
    final lOther$stoptimesWithoutPatterns = other.stoptimesWithoutPatterns;
    if (l$stoptimesWithoutPatterns != null &&
        lOther$stoptimesWithoutPatterns != null) {
      if (l$stoptimesWithoutPatterns.length !=
          lOther$stoptimesWithoutPatterns.length) {
        return false;
      }
      for (int i = 0; i < l$stoptimesWithoutPatterns.length; i++) {
        final l$stoptimesWithoutPatterns$entry = l$stoptimesWithoutPatterns[i];
        final lOther$stoptimesWithoutPatterns$entry =
            lOther$stoptimesWithoutPatterns[i];
        if (l$stoptimesWithoutPatterns$entry !=
            lOther$stoptimesWithoutPatterns$entry) {
          return false;
        }
      }
    } else if (l$stoptimesWithoutPatterns != lOther$stoptimesWithoutPatterns) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$FetchStopStoptimes$stop
    on Query$FetchStopStoptimes$stop {
  CopyWith$Query$FetchStopStoptimes$stop<Query$FetchStopStoptimes$stop>
      get copyWith => CopyWith$Query$FetchStopStoptimes$stop(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$FetchStopStoptimes$stop<TRes> {
  factory CopyWith$Query$FetchStopStoptimes$stop(
    Query$FetchStopStoptimes$stop instance,
    TRes Function(Query$FetchStopStoptimes$stop) then,
  ) = _CopyWithImpl$Query$FetchStopStoptimes$stop;

  factory CopyWith$Query$FetchStopStoptimes$stop.stub(TRes res) =
      _CopyWithStubImpl$Query$FetchStopStoptimes$stop;

  TRes call({
    List<Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns?>?
        stoptimesWithoutPatterns,
    String? $__typename,
  });
  TRes stoptimesWithoutPatterns(
      Iterable<Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns?>? Function(
              Iterable<
                  CopyWith$Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns<
                      Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns>?>?)
          _fn);
}

class _CopyWithImpl$Query$FetchStopStoptimes$stop<TRes>
    implements CopyWith$Query$FetchStopStoptimes$stop<TRes> {
  _CopyWithImpl$Query$FetchStopStoptimes$stop(
    this._instance,
    this._then,
  );

  final Query$FetchStopStoptimes$stop _instance;

  final TRes Function(Query$FetchStopStoptimes$stop) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? stoptimesWithoutPatterns = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$FetchStopStoptimes$stop(
        stoptimesWithoutPatterns: stoptimesWithoutPatterns == _undefined
            ? _instance.stoptimesWithoutPatterns
            : (stoptimesWithoutPatterns as List<
                Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns?>?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes stoptimesWithoutPatterns(
          Iterable<Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns?>? Function(
                  Iterable<
                      CopyWith$Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns<
                          Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns>?>?)
              _fn) =>
      call(
          stoptimesWithoutPatterns:
              _fn(_instance.stoptimesWithoutPatterns?.map((e) => e == null
                  ? null
                  : CopyWith$Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns(
                      e,
                      (i) => i,
                    )))?.toList());
}

class _CopyWithStubImpl$Query$FetchStopStoptimes$stop<TRes>
    implements CopyWith$Query$FetchStopStoptimes$stop<TRes> {
  _CopyWithStubImpl$Query$FetchStopStoptimes$stop(this._res);

  TRes _res;

  call({
    List<Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns?>?
        stoptimesWithoutPatterns,
    String? $__typename,
  }) =>
      _res;

  stoptimesWithoutPatterns(_fn) => _res;
}

class Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns {
  Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns({
    this.scheduledDeparture,
    this.realtimeDeparture,
    this.serviceDay,
    this.realtime,
    this.realtimeState,
    this.headsign,
    this.$__typename = 'Stoptime',
  });

  factory Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns.fromJson(
      Map<String, dynamic> json) {
    final l$scheduledDeparture = json['scheduledDeparture'];
    final l$realtimeDeparture = json['realtimeDeparture'];
    final l$serviceDay = json['serviceDay'];
    final l$realtime = json['realtime'];
    final l$realtimeState = json['realtimeState'];
    final l$headsign = json['headsign'];
    final l$$__typename = json['__typename'];
    return Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns(
      scheduledDeparture: (l$scheduledDeparture as int?),
      realtimeDeparture: (l$realtimeDeparture as int?),
      serviceDay: (l$serviceDay as int?),
      realtime: (l$realtime as bool?),
      realtimeState: l$realtimeState == null
          ? null
          : fromJson$Enum$RealtimeState((l$realtimeState as String)),
      headsign: (l$headsign as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final int? scheduledDeparture;

  final int? realtimeDeparture;

  final int? serviceDay;

  final bool? realtime;

  final Enum$RealtimeState? realtimeState;

  final String? headsign;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$scheduledDeparture = scheduledDeparture;
    _resultData['scheduledDeparture'] = l$scheduledDeparture;
    final l$realtimeDeparture = realtimeDeparture;
    _resultData['realtimeDeparture'] = l$realtimeDeparture;
    final l$serviceDay = serviceDay;
    _resultData['serviceDay'] = l$serviceDay;
    final l$realtime = realtime;
    _resultData['realtime'] = l$realtime;
    final l$realtimeState = realtimeState;
    _resultData['realtimeState'] = l$realtimeState == null
        ? null
        : toJson$Enum$RealtimeState(l$realtimeState);
    final l$headsign = headsign;
    _resultData['headsign'] = l$headsign;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$scheduledDeparture = scheduledDeparture;
    final l$realtimeDeparture = realtimeDeparture;
    final l$serviceDay = serviceDay;
    final l$realtime = realtime;
    final l$realtimeState = realtimeState;
    final l$headsign = headsign;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$scheduledDeparture,
      l$realtimeDeparture,
      l$serviceDay,
      l$realtime,
      l$realtimeState,
      l$headsign,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$scheduledDeparture = scheduledDeparture;
    final lOther$scheduledDeparture = other.scheduledDeparture;
    if (l$scheduledDeparture != lOther$scheduledDeparture) {
      return false;
    }
    final l$realtimeDeparture = realtimeDeparture;
    final lOther$realtimeDeparture = other.realtimeDeparture;
    if (l$realtimeDeparture != lOther$realtimeDeparture) {
      return false;
    }
    final l$serviceDay = serviceDay;
    final lOther$serviceDay = other.serviceDay;
    if (l$serviceDay != lOther$serviceDay) {
      return false;
    }
    final l$realtime = realtime;
    final lOther$realtime = other.realtime;
    if (l$realtime != lOther$realtime) {
      return false;
    }
    final l$realtimeState = realtimeState;
    final lOther$realtimeState = other.realtimeState;
    if (l$realtimeState != lOther$realtimeState) {
      return false;
    }
    final l$headsign = headsign;
    final lOther$headsign = other.headsign;
    if (l$headsign != lOther$headsign) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns
    on Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns {
  CopyWith$Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns<
          Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns>
      get copyWith =>
          CopyWith$Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns<
    TRes> {
  factory CopyWith$Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns(
    Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns instance,
    TRes Function(Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns) then,
  ) = _CopyWithImpl$Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns;

  factory CopyWith$Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns.stub(
          TRes res) =
      _CopyWithStubImpl$Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns;

  TRes call({
    int? scheduledDeparture,
    int? realtimeDeparture,
    int? serviceDay,
    bool? realtime,
    Enum$RealtimeState? realtimeState,
    String? headsign,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns<TRes>
    implements
        CopyWith$Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns<TRes> {
  _CopyWithImpl$Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns(
    this._instance,
    this._then,
  );

  final Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns _instance;

  final TRes Function(Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns)
      _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? scheduledDeparture = _undefined,
    Object? realtimeDeparture = _undefined,
    Object? serviceDay = _undefined,
    Object? realtime = _undefined,
    Object? realtimeState = _undefined,
    Object? headsign = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns(
        scheduledDeparture: scheduledDeparture == _undefined
            ? _instance.scheduledDeparture
            : (scheduledDeparture as int?),
        realtimeDeparture: realtimeDeparture == _undefined
            ? _instance.realtimeDeparture
            : (realtimeDeparture as int?),
        serviceDay: serviceDay == _undefined
            ? _instance.serviceDay
            : (serviceDay as int?),
        realtime:
            realtime == _undefined ? _instance.realtime : (realtime as bool?),
        realtimeState: realtimeState == _undefined
            ? _instance.realtimeState
            : (realtimeState as Enum$RealtimeState?),
        headsign:
            headsign == _undefined ? _instance.headsign : (headsign as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns<
        TRes>
    implements
        CopyWith$Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns<TRes> {
  _CopyWithStubImpl$Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns(
      this._res);

  TRes _res;

  call({
    int? scheduledDeparture,
    int? realtimeDeparture,
    int? serviceDay,
    bool? realtime,
    Enum$RealtimeState? realtimeState,
    String? headsign,
    String? $__typename,
  }) =>
      _res;
}
