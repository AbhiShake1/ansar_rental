import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:ansar_rental/app/packages/firestore_client/auth_client.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserRepo extends GetxService {
  final _dbClient = Get.find<AuthClient>();

  User get currentUser => FirebaseAuth.instance.currentUser!;

  String get currentUID => currentUser.uid;

  Future<Either<UserModel, String>> registerUser({
    //required String id,
    required String name,
    required String password,
    required String email,
    required String address,
    required int contactNumber,
    required String guardianName,
    required int roomNo,
    required num monthlyRent,
    required DateTime startingDate,
    required int guardianContactNumber,
    required num startingElectricityUnits,
    required int noOfTenants,
    required num waterRent,
    required bool isAdmin,
    required String documentUrl,
    required String photoUrl,
  }) async {
    UserCredential? credential;

    try {
      credential = await _dbClient.signUpWithEmailAndPassword(email, password);
    } on FirebaseAuthException catch (e) {
      return Right(e.code);
    } catch (e) {
      return Right(e.toString());
    }

    // register new user
    final userData = UserModel(
      id: credential.user!.uid,
      name: name,
      password: password,
      email: email,
      address: address,
      contactNumber: contactNumber,
      guardianName: guardianName,
      roomNo: roomNo,
      monthlyRent: monthlyRent,
      startingDate: startingDate,
      guardianContactNumber: guardianContactNumber,
      waterRent: waterRent,
      isAdmin: isAdmin,
      documentUrl: documentUrl,
      photoUrl: photoUrl,
    );

    final _user = await _dbClient.updateUser(user: userData);
    return Left(_user);
  }
}
