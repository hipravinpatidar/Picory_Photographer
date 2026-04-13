// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterUserModel _$RegisterUserModelFromJson(Map<String, dynamic> json) =>
    RegisterUserModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterUserModelToJson(RegisterUserModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      vendorId: (json['vendor_id'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'vendor_id': instance.vendorId,
      'message': instance.message,
    };
