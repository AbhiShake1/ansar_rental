import 'package:ansar_rental/app/data/models/user/user_model.dart';
import 'package:ansar_rental/app/packages/firestore_client/auth_client.dart';
import 'package:ansar_rental/app/packages/firestore_client/firestore_client.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserRepo extends GetxService {
  final _dbClient = Get.find<FirestoreClient>();
  final _authClient = Get.find<AuthClient>();

  Future<Either<UserModel, String>> registerUser({
    required bool toUpdate,
    required String name,
    required String password,
    required String email,
    String? address,
    int? contactNumber,
    String? guardianName,
    int? roomNo,
    num? monthlyRent,
    DateTime? startingDate,
    int? guardianContactNumber,
    int? startingElectricityUnits,
    int? noOfTenants,
    num? waterRent,
    required bool isAdmin,
    String? documentUrl,
    required String photoUrl,
    String? notes,
    String? id,
  }) async {
    UserCredential? credential;

    if (id == null) {
      try {
        credential =
            await _authClient.signUpWithEmailAndPassword(email, password);
      } on FirebaseAuthException catch (e) {
        return Right(e.code);
      } catch (e) {
        return Right(e.toString());
      }
    }

    // register or update (if id is passed) new user
    final userData = UserModel(
      id: id ?? credential!.user!.uid,
      name: name,
      password: password,
      email: email,
      address: address ?? '',
      contactNumber: contactNumber ?? 0,
      guardianName: guardianName ?? '',
      roomNo: roomNo ?? 0,
      monthlyRent: monthlyRent ?? 0,
      startingDate: startingDate ?? DateTime.now(),
      guardianContactNumber: guardianContactNumber ?? 0,
      waterRent: waterRent ?? 0,
      isAdmin: isAdmin,
      documentUrl: documentUrl ?? '',
      photoUrl: photoUrl,
      notes: notes,
      startingElectricityUnits: startingElectricityUnits ?? 0,
      noOfTenants: noOfTenants ?? 0,
    );

    final _user = await _dbClient.updateUser(user: userData);
    return Left(_user);
  }
}
