import 'dart:convert';

class ProfileModel {
    bool? success;
    String? message;
    Data? data;

    ProfileModel({
        this.success,
        this.message,
        this.data,
    });

    factory ProfileModel.fromRawJson(String str) => ProfileModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? id;
    String? name;
    String? email;
    String? image;
    String? role;
    String? status;
    bool? verified;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    Authorization? authorization;
    Preference? preference;
    int? coinBalance;
    int? currentStreak;

    Data({
        this.id,
        this.name,
        this.email,
        this.image,
        this.role,
        this.status,
        this.verified,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.authorization,
        this.preference,
        this.coinBalance,
        this.currentStreak,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"] != null && json["_id"] is String ? json["_id"] : "",
        name: json["name"] != null && json["name"] is String ? json["name"] : "",
        email: json["email"] != null && json["email"] is String ? json["email"] : "",
        image: json["image"] != null && json["image"] is String ? json["image"] : "",
        role: json["role"] != null && json["role"] is String ? json["role"] : "",
        status: json["status"] != null && json["status"] is String ? json["status"] : "",
        verified: json["verified"] != null && json["verified"] is bool ? json["verified"] : false,
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] != null && json["__v"] is int ? json["__v"] : 0,
        authorization: json["authorization"] == null ? null : Authorization.fromJson(json["authorization"]),
        preference: json["preference"] == null ? null : Preference.fromJson(json["preference"]),
        coinBalance: json["coinBalance"],
        currentStreak: json["currentStreak"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "image": image,
        "role": role,
        "status": status,
        "verified": verified,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "authorization": authorization?.toJson(),
        "preference": preference?.toJson(),
        "coinBalance": coinBalance,
        "currentStreak": currentStreak,
    };
}

class Authorization {
    String? oneTimeCode;
    DateTime? expireAt;

    Authorization({
        this.oneTimeCode,
        this.expireAt,
    });

    factory Authorization.fromRawJson(String str) => Authorization.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
        oneTimeCode: json["oneTimeCode"],
        expireAt: json["expireAt"] == null ? null : DateTime.parse(json["expireAt"]),
    );

    Map<String, dynamic> toJson() => {
        "oneTimeCode": oneTimeCode,
        "expireAt": expireAt?.toIso8601String(),
    };
}

class Preference {
    String? motivation;
    String? trigger;
    int? budget;

    Preference({
        this.motivation,
        this.trigger,
        this.budget,
    });

    factory Preference.fromRawJson(String str) => Preference.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Preference.fromJson(Map<String, dynamic> json) => Preference(
        motivation: json["motivation"],
        trigger: json["trigger"],
        budget: json["budget"],
    );

    Map<String, dynamic> toJson() => {
        "motivation": motivation,
        "trigger": trigger,
        "budget": budget,
    };
}
