import 'dart:convert';

class CoinPackageModel {
    bool? success;
    String? message;
    Pagination? pagination;
    List<CoinPackageDataModel>? data;

    CoinPackageModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory CoinPackageModel.fromRawJson(String str) => CoinPackageModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CoinPackageModel.fromJson(Map<String, dynamic> json) => CoinPackageModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<CoinPackageDataModel>.from(json["data"]!.map((x) => CoinPackageDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class CoinPackageDataModel {
    String? id;
    int? coins;
    double? price;
    int? discount;
    bool? isActive;
    DateTime? createdAt;
    DateTime? updatedAt;

    CoinPackageDataModel({
        this.id,
        this.coins,
        this.price,
        this.discount,
        this.isActive,
        this.createdAt,
        this.updatedAt,
    });

    factory CoinPackageDataModel.fromRawJson(String str) => CoinPackageDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CoinPackageDataModel.fromJson(Map<String, dynamic> json) => CoinPackageDataModel(
        id: json["_id"],
        coins: json["coins"],
        price: json["price"]?.toDouble(),
        discount: json["discount"],
        isActive: json["isActive"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "coins": coins,
        "price": price,
        "discount": discount,
        "isActive": isActive,
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
