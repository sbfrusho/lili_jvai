// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    String? accessToken;
    String? refreshToken;
    String? role;
    bool? isVerified;
    Profile? profile;

    LoginResponseModel({
        this.accessToken,
        this.refreshToken,
        this.role,
        this.isVerified,
        this.profile,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        role: json["role"],
        isVerified: json["is_verified"],
        profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "role": role,
        "is_verified": isVerified,
        "profile": profile?.toJson(),
    };
}

class Profile {
    int? id;
    int? user;
    dynamic fullName;
    String? email;
    dynamic profilePicture;
    DateTime? joinedDate;

    Profile({
        this.id,
        this.user,
        this.fullName,
        this.email,
        this.profilePicture,
        this.joinedDate,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        user: json["user"],
        fullName: json["full_name"],
        email: json["email"],
        profilePicture: json["profile_picture"],
        joinedDate: json["joined_date"] == null ? null : DateTime.parse(json["joined_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "full_name": fullName,
        "email": email,
        "profile_picture": profilePicture,
        "joined_date": joinedDate?.toIso8601String(),
    };
}
