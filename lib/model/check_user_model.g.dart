// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUserModel _$CheckUserModelFromJson(Map<String, dynamic> json) =>
    CheckUserModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckUserModelToJson(CheckUserModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      exists: json['exists'] as bool?,
      otp: json['otp'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'exists': instance.exists,
      'otp': instance.otp,
    };
