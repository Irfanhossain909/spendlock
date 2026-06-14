import 'dart:convert';

class MotivationListModel {
    bool? success;
    String? message;
    Pagination? pagination;
    List<MotivationListDataModel>? data;

    MotivationListModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory MotivationListModel.fromRawJson(String str) => MotivationListModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MotivationListModel.fromJson(Map<String, dynamic> json) => MotivationListModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<MotivationListDataModel>.from(json["data"]!.map((x) => MotivationListDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class MotivationListDataModel {
    String? id;
    String? title;
    String? image;
    bool? published;
    DateTime? createdAt;
    DateTime? updatedAt;
    bool? preference;

    MotivationListDataModel({
        this.id,
        this.title,
        this.image,
        this.published,
        this.createdAt,
        this.updatedAt,
        this.preference,
    });

    factory MotivationListDataModel.fromRawJson(String str) => MotivationListDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MotivationListDataModel.fromJson(Map<String, dynamic> json) => MotivationListDataModel(
        id: json["_id"],
        title: json["title"],
        image: json["image"],
        published: json["published"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        preference: json["preference"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "image": image,
        "published": published,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "preference": preference,
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
