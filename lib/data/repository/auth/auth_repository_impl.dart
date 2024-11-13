import 'package:dartz/dartz.dart';
import 'package:spotify_clone/data/models/auth/create_user_req.dart';
import 'package:spotify_clone/data/models/auth/signin_user_req.dart';
import 'package:spotify_clone/domain/repository/auth/auth.dart';
import 'package:spotify_clone/service_locator.dart';

import '../../sources/auth/auth_firebase_service.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Either> signIn(SigninUserReq req) async { 
    return await sl<AuthFirebaseService>().signIn(req);
  }

  @override
  Future<Either> signUp(CreateUserReq req) async {
    return await sl<AuthFirebaseService>().signUp(req);
  }
  
}