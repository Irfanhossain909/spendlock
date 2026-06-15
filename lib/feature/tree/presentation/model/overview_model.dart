import 'dart:convert';

class OverViewModel {
    bool? success;
    String? message;
    Data? data;

    OverViewModel({
        this.success,
        this.message,
        this.data,
    });

    factory OverViewModel.fromRawJson(String str) => OverViewModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OverViewModel.fromJson(Map<String, dynamic> json) => OverViewModel(
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
    int? currentStreak;
    int? availableCoins;
    int? saveBalancePerMonth;

    Data({
        this.currentStreak,
        this.availableCoins,
        this.saveBalancePerMonth,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentStreak: json["currentStreak"],
        availableCoins: json["availableCoins"],
        saveBalancePerMonth: json["saveBalancePerMonth"],
    );

    Map<String, dynamic> toJson() => {
        "currentStreak": currentStreak,
        "availableCoins": availableCoins,
        "saveBalancePerMonth": saveBalancePerMonth,
    };
}
