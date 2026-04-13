// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUserModel _$LoginUserModelFromJson(Map<String, dynamic> json) =>
    LoginUserModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginUserModelToJson(LoginUserModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      vendor: json['vendor'] == null
          ? null
          : Vendor.fromJson(json['vendor'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'vendor': instance.vendor,
      'token': instance.token,
    };

Vendor _$VendorFromJson(Map<String, dynamic> json) => Vendor(
      id: (json['id'] as num?)?.toInt(),
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      businessName: json['business_name'] as String?,
      email: json['email'] as String?,
      address: json['address'],
      token: json['token'] as String?,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$VendorToJson(Vendor instance) => <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'name': instance.name,
      'business_name': instance.businessName,
      'email': instance.email,
      'address': instance.address,
      'token': instance.token,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
