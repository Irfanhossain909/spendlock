import 'dart:convert';

class RulsApiModel {
    bool? success;
    String? message;
    Pagination? pagination;
    List<Datum>? data;

    RulsApiModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory RulsApiModel.fromRawJson(String str) => RulsApiModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RulsApiModel.fromJson(Map<String, dynamic> json) => RulsApiModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? reachedLimit;
    String? id;
    String? user;
    String? ruleType;
    String? category;
    String? ruleName;
    String? startTime;
    String? endTime;
    List<String>? activeDays;
    List<String>? selectedApps;
    bool? active;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? spendingLimit;

    Datum({
        this.reachedLimit,
        this.id,
        this.user,
        this.ruleType,
        this.category,
        this.ruleName,
        this.startTime,
        this.endTime,
        this.activeDays,
        this.selectedApps,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.spendingLimit,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        reachedLimit: json["reachedLimit"],
        id: json["_id"],
        user: json["user"],
        ruleType: json["ruleType"],
        category: json["category"],
        ruleName: json["ruleName"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        activeDays: json["activeDays"] == null ? [] : List<String>.from(json["activeDays"]!.map((x) => x)),
        selectedApps: json["selectedApps"] == null ? [] : List<String>.from(json["selectedApps"]!.map((x) => x)),
        active: json["active"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        spendingLimit: json["spending_limit"],
    );

    Map<String, dynamic> toJson() => {
        "reachedLimit": reachedLimit,
        "_id": id,
        "user": user,
        "ruleType": ruleType,
        "category": category,
        "ruleName": ruleName,
        "startTime": startTime,
        "endTime": endTime,
        "activeDays": activeDays == null ? [] : List<dynamic>.from(activeDays!.map((x) => x)),
        "selectedApps": selectedApps == null ? [] : List<dynamic>.from(selectedApps!.map((x) => x)),
        "active": active,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "spending_limit": spendingLimit,
    };
}

class Pagination {
    int? total;
    int? limit;
    int? page;
    int? totalPage;

    Pagination({
        this.total,
        this.limit,
        this.page,
        this.totalPage,
    });

    factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        limit: json["limit"],
        page: json["page"],
        totalPage: json["totalPage"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "page": page,
        "totalPage": totalPage,
    };
}
