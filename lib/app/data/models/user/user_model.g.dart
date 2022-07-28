// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      address: json['address'] as String,
      contactNumber: json['contactNumber'] as int,
      monthlyRent: json['monthlyRent'] as num,
      waterRent: json['waterRent'] as num,
      roomNo: json['roomNo'] as int,
      guardianContactNumber: json['guardianContactNumber'] as int,
      startingDate: DateTime.parse(json['startingDate'] as String),
      duePayment: json['duePayment'] as num?,
      totalPayment: json['totalPayment'] as num?,
      photoUrl: json['photoUrl'] as String,
      documentUrl: json['documentUrl'] as String,
      isAdmin: json['isAdmin'] as bool? ?? false,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'address': instance.address,
      'contactNumber': instance.contactNumber,
      'monthlyRent': instance.monthlyRent,
      'waterRent': instance.waterRent,
      'roomNo': instance.roomNo,
      'guardianContactNumber': instance.guardianContactNumber,
      'startingDate': instance.startingDate.toIso8601String(),
      'duePayment': instance.duePayment,
      'totalPayment': instance.totalPayment,
      'photoUrl': instance.photoUrl,
      'documentUrl': instance.documentUrl,
      'isAdmin': instance.isAdmin,
    };
