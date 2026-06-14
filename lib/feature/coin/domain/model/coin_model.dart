import 'dart:convert';

class CoinModel {
    bool? success;
    String? message;
    Pagination? pagination;
    List<CoinDataModel>? data;

    CoinModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory CoinModel.fromRawJson(String str) => CoinModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CoinModel.fromJson(Map<String, dynamic> json) => CoinModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<CoinDataModel>.from(json["data"]!.map((x) => CoinDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class CoinDataModel {
    String? id;
    String? user;
    String? type;
    String? title;
    String? description;
    int? coins;
    DateTime? createdAt;
    DateTime? updatedAt;

    CoinDataModel({
        this.id,
        this.user,
        this.type,
        this.title,
        this.description,
        this.coins,
        this.createdAt,
        this.updatedAt,
    });

    factory CoinDataModel.fromRawJson(String str) => CoinDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CoinDataModel.fromJson(Map<String, dynamic> json) => CoinDataModel(
        id: json["_id"],
        user: json["user"],
        type: json["type"],
        title: json["title"],
        description: json["description"],
        coins: json["coins"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "type": type,
        "title": title,
        "description": description,
        "coins": coins,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
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
