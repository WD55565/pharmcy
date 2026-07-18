// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PharmacyModel _$PharmacyModelFromJson(Map<String, dynamic> json) =>
    _PharmacyModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      district: json['district'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      isOnDuty: json['isOnDuty'] as bool,
      openingTime: json['openingTime'] as String?,
      closingTime: json['closingTime'] as String?,
    );

Map<String, dynamic> _$PharmacyModelToJson(_PharmacyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'district': instance.district,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'isOnDuty': instance.isOnDuty,
      'openingTime': instance.openingTime,
      'closingTime': instance.closingTime,
    };
