import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';

Future<void> initLogging() async {
  await setupFileSystemLogger();

  Logger.root.level = kDebugMode ? Level.ALL : Level.WARNING;
  Logger.root.onRecord.listen(_log);
}

Future<void> setupFileSystemLogger() async {
  Directory support = await getApplicationSupportDirectory();
  _fsLogger = _FileSystemLogger(logDirectory: "${support.path}/logs");
}

_FileSystemLogger? _fsLogger;
void _log(LogRecord record) {
  final String formattedMsg = _MsgFormatter.formatMsg(record);

  if (kDebugMode) {
    _logToConsole(record, formattedMsg: formattedMsg);
  }

  _fsLogger?.log(record, formattedMsg: formattedMsg);
}

void _logToConsole(LogRecord record, {required String formattedMsg}) {
  // ignore: avoid_print
  print(_withAnsiColor(record.level, formattedMsg));
}

String _withAnsiColor(Level level, String message) {
  int? colorCode = switch (level) {
    Level.SHOUT => 31, // dark red
    Level.SEVERE => 91, // red
    Level.WARNING => 93, // yellow
    Level.INFO => 32, // green
    _ => null,
  };

  if (colorCode == null) return message;

  return "\u001B[${colorCode}m$message\u001B[0m";
}

class _OpenedFile {
  final DateTime opened;
  final IOSink file;

  _OpenedFile({
    required this.opened,
    required this.file,
  });
}

class _FileSystemLogger {
  final Directory _logDirectory;

  final Lock _openLock = Lock();
  _OpenedFile? _file;

  _FileSystemLogger({
    required String logDirectory,
  }) : _logDirectory = Directory(logDirectory);

  Future<void> log(LogRecord record, {required String formattedMsg}) async {
    IOSink file = await _loadFile(record.time);
    file.writeln(formattedMsg);
  }

  FutureOr<IOSink> _loadFile(DateTime dt) {
    IOSink? existing = _tryGetCachedFile(dt);
    if (existing != null) return existing;

    return _openLock.synchronized<IOSink>(() async {
      // file might have been opened while we were waiting for the lock
      IOSink? existing2 = _tryGetCachedFile(dt);
      if (existing2 != null) return existing2;

      IOSink file = await _internalLoadFile(dt, dirPath: _logDirectory.path);
      _file = _OpenedFile(opened: dt, file: file);
      return file;
    });
  }

  IOSink? _tryGetCachedFile(DateTime dt) {
    _OpenedFile? file = _file;
    if (file != null &&
        dt.day == file.opened.day &&
        dt.month == file.opened.month &&
        dt.year == file.opened.year) {
      return file.file;
    } else {
      return null;
    }
  }

  static Future<IOSink> _internalLoadFile(
    DateTime dt, {
    required String dirPath,
  }) async {
    int i = 0;
    File file;
    do {
      String filepath = "$dirPath/${dt.year}-${dt.month}-${dt.day}";
      if (i != 0) filepath += " ($i)";
      filepath += ".log";

      file = File(filepath);
      i++;
    } while (await file.exists());

    await file.create(recursive: true, exclusive: true);
    return file.openWrite(mode: FileMode.writeOnly);
  }
}

class _MsgFormatter {
  static String formatMsg(LogRecord record) {
    String prefix = _formatTime(record.time);
    if (record.loggerName.isNotEmpty) prefix += " [${record.loggerName}]";
    prefix += " ${record.level.name}: ";

    final builder = _MsgBuilder(prefix: prefix);
    builder.append(record.message);
    builder.tryAppend(record.error);
    builder.tryAppend(record.stackTrace);

    return builder.toString();
  }

  static String _formatTime(DateTime time) {
    String ft(int x, [int count = 2]) => x.toString().padLeft(count, "0");
    return "${ft(time.hour)}:${ft(time.minute)}:${ft(time.second)}.${ft(time.millisecond, 3)}";
  }
}

class _MsgBuilder {
  final String prefix;
  final String inset;

  final List<String> _lines;

  _MsgBuilder({required this.prefix})
      : inset = " " * prefix.length,
        _lines = List.empty(growable: true);

  /// Appends the object to the builder.
  /// The object is converted to a string using .toString()
  void append(Object msg) {
    for (String line in LineSplitter.split(msg.toString())) {
      _appendLine(line);
    }
  }

  // Only appends if the object is not null.
  void tryAppend(Object? msg) {
    if (msg != null) {
      append(msg);
    }
  }

  void _appendLine(String line) {
    if (_lines.isEmpty) {
      _lines.add(prefix + line);
    } else {
      _lines.add(inset + line);
    }
  }

  @override
  String toString() => _lines.join(Platform.lineTerminator);
}
