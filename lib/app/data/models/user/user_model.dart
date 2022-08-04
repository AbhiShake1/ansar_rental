import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    required String email,
    required String password,
    required String address,
    required int contactNumber,
    required num monthlyRent,
    required num waterRent,
    required int roomNo,
    required String guardianName,
    required int guardianContactNumber,
    required DateTime startingDate,
    num? duePayment,
    num? totalPayment,
    String? notes,
    required String photoUrl,
    required String documentUrl,
    @Default(false) bool isAdmin,
    @Default(false) bool hasLeft,
    @Default(0) int startingElectricityUnits,
    @Default(1) int noOfTenants,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
