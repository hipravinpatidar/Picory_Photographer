import 'package:json_annotation/json_annotation.dart';

part 'check_user_model.g.dart';

@JsonSerializable()
class CheckUserModel {
  CheckUserModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory CheckUserModel.fromJson(Map<String, dynamic> json) => _$CheckUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckUserModelToJson(this);

  @override
  String toString(){
    return "$success, $message, $data, ";
  }
}

@JsonSerializable()
class Data {
  Data({
    required this.exists,
    required this.otp,
  });

  final bool? exists;
  final String? otp;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  String toString(){
    return "$exists, $otp, ";
  }
}
