// To parse this JSON data, do
//
//     final registerResonseModel = registerResonseModelFromJson(jsonString);

import 'dart:convert';

RegisterResonseModel registerResonseModelFromJson(String str) => RegisterResonseModel.fromJson(json.decode(str));

String registerResonseModelToJson(RegisterResonseModel data) => json.encode(data.toJson());

class RegisterResonseModel {
    String? message;
    UserModel? user;

    RegisterResonseModel({
        this.message,
        this.user,
    });

    factory RegisterResonseModel.fromJson(Map<String, dynamic> json) => RegisterResonseModel(
        message: json["message"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "user": user?.toJson(),
    };
}

class UserModel {
    int? id;
    String? email;

    UserModel({
        this.id,
        this.email,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
    };
}
