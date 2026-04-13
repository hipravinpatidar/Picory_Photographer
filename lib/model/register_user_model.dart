import 'package:json_annotation/json_annotation.dart';
part 'register_user_model.g.dart';

@JsonSerializable()
class RegisterUserModel {
  RegisterUserModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) => _$RegisterUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterUserModelToJson(this);

  @override
  String toString(){
    return "$success, $message, $data, ";
  }
}

@JsonSerializable()
class Data {
  Data({
    required this.vendorId,
    required this.message,
  });

  @JsonKey(name: 'vendor_id')
  final int? vendorId;
  final String? message;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  String toString(){
    return "$vendorId, $message, ";
  }
}
