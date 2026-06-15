import 'dart:convert';

class StreakModel {
  List<Datum>? data;
  int? currentStreak;
  int? coinBalance;

  StreakModel({
    this.data,
    this.currentStreak,
    this.coinBalance,
  });

  factory StreakModel.fromRawJson(String str) =>
      StreakModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StreakModel.fromJson(Map<String, dynamic> json) => StreakModel(
        data: parseDatumList(json["data"]),
        currentStreak: _readInt(json, json["data"], const [
          'currentStreak',
          'streak',
          'current_streak',
        ]),
        coinBalance: _readInt(json, json["data"], const [
          'coinBalance',
          'coins',
          'coin_balance',
        ]),
      );

  static List<Datum> parseDatumList(dynamic raw) {
    if (raw == null) return [];

    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((item) => Datum.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }

    if (raw is Map) {
      final map = Map<String, dynamic>.from(raw);
      if (map["data"] is List) {
        return parseDatumList(map["data"]);
      }
      for (final key in const ['calendar', 'records', 'streaks', 'items']) {
        if (map[key] is List) {
          return parseDatumList(map[key]);
        }
      }
    }

    return [];
  }

  static int? _readInt(
    Map<String, dynamic> root,
    dynamic nested,
    List<String> keys,
  ) {
    for (final key in keys) {
      final rootValue = root[key];
      if (rootValue is int) return rootValue;
      if (rootValue is String) {
        final parsed = int.tryParse(rootValue);
        if (parsed != null) return parsed;
      }
    }

    if (nested is Map) {
      final map = Map<String, dynamic>.from(nested);
      for (final key in keys) {
        final value = map[key];
        if (value is int) return value;
        if (value is String) {
          final parsed = int.tryParse(value);
          if (parsed != null) return parsed;
        }
      }
    }

    return null;
  }

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "currentStreak": currentStreak,
        "coinBalance": coinBalance,
      };
}

class Datum {
  String? id;
  DateTime? date;
  Status? status;
  String? user;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.id,
    this.date,
    this.status,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"]?.toString(),
        date: parseDate(json["date"]),
        status: parseStatus(json["status"]),
        user: json["user"]?.toString(),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.tryParse(json["createdAt"].toString()),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.tryParse(json["updatedAt"].toString()),
        v: json["__v"] is int ? json["__v"] as int : null,
      );

  static DateTime? parseDate(dynamic value) {
    if (value == null) return null;

    final raw = value.toString().trim();
    if (raw.isEmpty) return null;

    final datePart = raw.split('T').first;
    final parts = datePart.split('-');
    if (parts.length == 3) {
      final year = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final day = int.tryParse(parts[2]);
      if (year != null && month != null && day != null) {
        return DateTime(year, month, day);
      }
    }

    return DateTime.tryParse(raw)?.toLocal();
  }

  static Status? parseStatus(dynamic value) {
    if (value == null) return null;
    return statusValues.map[value.toString().toLowerCase()];
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "date": date == null
            ? null
            : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "status": status == null ? null : statusValues.reverse[status],
        "user": user,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

enum Status {
  break_,
  progress,
}

final statusValues = EnumValues({
  "break": Status.break_,
  "progress": Status.progress,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
