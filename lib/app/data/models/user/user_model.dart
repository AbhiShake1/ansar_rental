import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String name,
    required String email,
    required String password,
    required String address,
    required int contactNumber,
    required num monthlyRent,
    required num waterRent,
    required int roomNo,
    required int guardianContactNumber,
    required DateTime startingDate,
    num? duePayment,
    num? totalPayment,
    required String photoUrl,
    required String documentUrl,
    @Default(false) bool isAdmin,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
