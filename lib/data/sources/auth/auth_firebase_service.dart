import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone/data/models/auth/create_user_req.dart';

abstract class AuthFirebaseService {

  Future<void> signIn();
  Future<Either> signUp(CreateUserReq request);
   
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<void> signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Either> signUp(CreateUserReq request) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: request.email, 
          password: request.password
        );

      return const Right('Signup successful');
    } on FirebaseAuthException catch (e){
      String message = '';
      if (e.code == 'weak-passwords') message = 'Weak passwords';
      if (e.code == 'email-already-in-use') message = 'Already exist an account with this email';
      return Left(message);
    }
  }
  
}