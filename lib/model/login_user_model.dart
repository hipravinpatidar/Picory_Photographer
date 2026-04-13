import 'package:json_annotation/json_annotation.dart';
part 'login_user_model.g.dart';

@JsonSerializable()
class LoginUserModel {
  LoginUserModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory LoginUserModel.fromJson(Map<String, dynamic> json) => _$LoginUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserModelToJson(this);

  @override
  String toString(){
    return "$success, $message, $data, ";
  }
}

@JsonSerializable()
class Data {
  Data({
    required this.vendor,
    required this.token,
  });

  final Vendor? vendor;
  final String? token;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  String toString(){
    return "$vendor, $token, ";
  }
}

@JsonSerializable()
class Vendor {
  Vendor({
    required this.id,
    required this.phone,
    required this.name,
    required this.businessName,
    required this.email,
    required this.address,
    required this.token,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? phone;
  final String? name;

  @JsonKey(name: 'business_name')
  final String? businessName;
  final String? email;
  final dynamic address;
  final String? token;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  factory Vendor.fromJson(Map<String, dynamic> json) => _$VendorFromJson(json);

  Map<String, dynamic> toJson() => _$VendorToJson(this);

  @override
  String toString(){
    return "$id, $phone, $name, $businessName, $email, $address, $token, $isActive, $createdAt, $updatedAt, ";
  }
}
