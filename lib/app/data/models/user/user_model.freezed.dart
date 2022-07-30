// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  int get contactNumber => throw _privateConstructorUsedError;
  num get monthlyRent => throw _privateConstructorUsedError;
  num get waterRent => throw _privateConstructorUsedError;
  int get roomNo => throw _privateConstructorUsedError;
  String get guardianName => throw _privateConstructorUsedError;
  int get guardianContactNumber => throw _privateConstructorUsedError;
  DateTime get startingDate => throw _privateConstructorUsedError;
  num? get duePayment => throw _privateConstructorUsedError;
  num? get totalPayment => throw _privateConstructorUsedError;
  String get photoUrl => throw _privateConstructorUsedError;
  String get documentUrl => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      String email,
      String password,
      String address,
      int contactNumber,
      num monthlyRent,
      num waterRent,
      int roomNo,
      String guardianName,
      int guardianContactNumber,
      DateTime startingDate,
      num? duePayment,
      num? totalPayment,
      String photoUrl,
      String documentUrl,
      bool isAdmin});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res> implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  final UserModel _value;
  // ignore: unused_field
  final $Res Function(UserModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? password = freezed,
    Object? address = freezed,
    Object? contactNumber = freezed,
    Object? monthlyRent = freezed,
    Object? waterRent = freezed,
    Object? roomNo = freezed,
    Object? guardianName = freezed,
    Object? guardianContactNumber = freezed,
    Object? startingDate = freezed,
    Object? duePayment = freezed,
    Object? totalPayment = freezed,
    Object? photoUrl = freezed,
    Object? documentUrl = freezed,
    Object? isAdmin = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: contactNumber == freezed
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as int,
      monthlyRent: monthlyRent == freezed
          ? _value.monthlyRent
          : monthlyRent // ignore: cast_nullable_to_non_nullable
              as num,
      waterRent: waterRent == freezed
          ? _value.waterRent
          : waterRent // ignore: cast_nullable_to_non_nullable
              as num,
      roomNo: roomNo == freezed
          ? _value.roomNo
          : roomNo // ignore: cast_nullable_to_non_nullable
              as int,
      guardianName: guardianName == freezed
          ? _value.guardianName
          : guardianName // ignore: cast_nullable_to_non_nullable
              as String,
      guardianContactNumber: guardianContactNumber == freezed
          ? _value.guardianContactNumber
          : guardianContactNumber // ignore: cast_nullable_to_non_nullable
              as int,
      startingDate: startingDate == freezed
          ? _value.startingDate
          : startingDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duePayment: duePayment == freezed
          ? _value.duePayment
          : duePayment // ignore: cast_nullable_to_non_nullable
              as num?,
      totalPayment: totalPayment == freezed
          ? _value.totalPayment
          : totalPayment // ignore: cast_nullable_to_non_nullable
              as num?,
      photoUrl: photoUrl == freezed
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      documentUrl: documentUrl == freezed
          ? _value.documentUrl
          : documentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isAdmin: isAdmin == freezed
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$$_UserModelCopyWith(
          _$_UserModel value, $Res Function(_$_UserModel) then) =
      __$$_UserModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      String email,
      String password,
      String address,
      int contactNumber,
      num monthlyRent,
      num waterRent,
      int roomNo,
      String guardianName,
      int guardianContactNumber,
      DateTime startingDate,
      num? duePayment,
      num? totalPayment,
      String photoUrl,
      String documentUrl,
      bool isAdmin});
}

/// @nodoc
class __$$_UserModelCopyWithImpl<$Res> extends _$UserModelCopyWithImpl<$Res>
    implements _$$_UserModelCopyWith<$Res> {
  __$$_UserModelCopyWithImpl(
      _$_UserModel _value, $Res Function(_$_UserModel) _then)
      : super(_value, (v) => _then(v as _$_UserModel));

  @override
  _$_UserModel get _value => super._value as _$_UserModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? password = freezed,
    Object? address = freezed,
    Object? contactNumber = freezed,
    Object? monthlyRent = freezed,
    Object? waterRent = freezed,
    Object? roomNo = freezed,
    Object? guardianName = freezed,
    Object? guardianContactNumber = freezed,
    Object? startingDate = freezed,
    Object? duePayment = freezed,
    Object? totalPayment = freezed,
    Object? photoUrl = freezed,
    Object? documentUrl = freezed,
    Object? isAdmin = freezed,
  }) {
    return _then(_$_UserModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: contactNumber == freezed
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as int,
      monthlyRent: monthlyRent == freezed
          ? _value.monthlyRent
          : monthlyRent // ignore: cast_nullable_to_non_nullable
              as num,
      waterRent: waterRent == freezed
          ? _value.waterRent
          : waterRent // ignore: cast_nullable_to_non_nullable
              as num,
      roomNo: roomNo == freezed
          ? _value.roomNo
          : roomNo // ignore: cast_nullable_to_non_nullable
              as int,
      guardianName: guardianName == freezed
          ? _value.guardianName
          : guardianName // ignore: cast_nullable_to_non_nullable
              as String,
      guardianContactNumber: guardianContactNumber == freezed
          ? _value.guardianContactNumber
          : guardianContactNumber // ignore: cast_nullable_to_non_nullable
              as int,
      startingDate: startingDate == freezed
          ? _value.startingDate
          : startingDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duePayment: duePayment == freezed
          ? _value.duePayment
          : duePayment // ignore: cast_nullable_to_non_nullable
              as num?,
      totalPayment: totalPayment == freezed
          ? _value.totalPayment
          : totalPayment // ignore: cast_nullable_to_non_nullable
              as num?,
      photoUrl: photoUrl == freezed
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      documentUrl: documentUrl == freezed
          ? _value.documentUrl
          : documentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isAdmin: isAdmin == freezed
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserModel implements _UserModel {
  const _$_UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.address,
      required this.contactNumber,
      required this.monthlyRent,
      required this.waterRent,
      required this.roomNo,
      required this.guardianName,
      required this.guardianContactNumber,
      required this.startingDate,
      this.duePayment,
      this.totalPayment,
      required this.photoUrl,
      required this.documentUrl,
      this.isAdmin = false});

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String password;
  @override
  final String address;
  @override
  final int contactNumber;
  @override
  final num monthlyRent;
  @override
  final num waterRent;
  @override
  final int roomNo;
  @override
  final String guardianName;
  @override
  final int guardianContactNumber;
  @override
  final DateTime startingDate;
  @override
  final num? duePayment;
  @override
  final num? totalPayment;
  @override
  final String photoUrl;
  @override
  final String documentUrl;
  @override
  @JsonKey()
  final bool isAdmin;

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, password: $password, address: $address, contactNumber: $contactNumber, monthlyRent: $monthlyRent, waterRent: $waterRent, roomNo: $roomNo, guardianName: $guardianName, guardianContactNumber: $guardianContactNumber, startingDate: $startingDate, duePayment: $duePayment, totalPayment: $totalPayment, photoUrl: $photoUrl, documentUrl: $documentUrl, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality()
                .equals(other.contactNumber, contactNumber) &&
            const DeepCollectionEquality()
                .equals(other.monthlyRent, monthlyRent) &&
            const DeepCollectionEquality().equals(other.waterRent, waterRent) &&
            const DeepCollectionEquality().equals(other.roomNo, roomNo) &&
            const DeepCollectionEquality()
                .equals(other.guardianName, guardianName) &&
            const DeepCollectionEquality()
                .equals(other.guardianContactNumber, guardianContactNumber) &&
            const DeepCollectionEquality()
                .equals(other.startingDate, startingDate) &&
            const DeepCollectionEquality()
                .equals(other.duePayment, duePayment) &&
            const DeepCollectionEquality()
                .equals(other.totalPayment, totalPayment) &&
            const DeepCollectionEquality().equals(other.photoUrl, photoUrl) &&
            const DeepCollectionEquality()
                .equals(other.documentUrl, documentUrl) &&
            const DeepCollectionEquality().equals(other.isAdmin, isAdmin));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(contactNumber),
      const DeepCollectionEquality().hash(monthlyRent),
      const DeepCollectionEquality().hash(waterRent),
      const DeepCollectionEquality().hash(roomNo),
      const DeepCollectionEquality().hash(guardianName),
      const DeepCollectionEquality().hash(guardianContactNumber),
      const DeepCollectionEquality().hash(startingDate),
      const DeepCollectionEquality().hash(duePayment),
      const DeepCollectionEquality().hash(totalPayment),
      const DeepCollectionEquality().hash(photoUrl),
      const DeepCollectionEquality().hash(documentUrl),
      const DeepCollectionEquality().hash(isAdmin));

  @JsonKey(ignore: true)
  @override
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      __$$_UserModelCopyWithImpl<_$_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String id,
      required final String name,
      required final String email,
      required final String password,
      required final String address,
      required final int contactNumber,
      required final num monthlyRent,
      required final num waterRent,
      required final int roomNo,
      required final String guardianName,
      required final int guardianContactNumber,
      required final DateTime startingDate,
      final num? duePayment,
      final num? totalPayment,
      required final String photoUrl,
      required final String documentUrl,
      final bool isAdmin}) = _$_UserModel;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String get password;
  @override
  String get address;
  @override
  int get contactNumber;
  @override
  num get monthlyRent;
  @override
  num get waterRent;
  @override
  int get roomNo;
  @override
  String get guardianName;
  @override
  int get guardianContactNumber;
  @override
  DateTime get startingDate;
  @override
  num? get duePayment;
  @override
  num? get totalPayment;
  @override
  String get photoUrl;
  @override
  String get documentUrl;
  @override
  bool get isAdmin;
  @override
  @JsonKey(ignore: true)
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
