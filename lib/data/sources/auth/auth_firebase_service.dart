import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone/data/models/auth/create_user_req.dart';
import 'package:spotify_clone/data/models/auth/signin_user_req.dart';

abstract class AuthFirebaseService {

  Future<Either> signIn(SigninUserReq request);
  Future<Either> signUp(CreateUserReq request);
   
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signIn(SigninUserReq request) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: request.email, 
          password: request.password
        );

      return const Right('Signin successful');
    } on FirebaseAuthException catch (e){
      debugPrint('FirebaseAuthException: ${e.message}');
      String message = '';
      if (e.code == 'invalid-email') message = 'User have not registered';
      if (e.code == 'invalid-credential') message = 'Wrong password';
      return Left(message);
    }
  }

  @override
  Future<Either> signUp(CreateUserReq request) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: request.email, 
          password: request.password
        );
      FirebaseFirestore.instance.collection('Users').add(
        {
          'name' : request.fullname,
          'email' : data.user?.email
        }
      );
      return const Right('Signup successful');
    } on FirebaseAuthException catch (e){
      debugPrint('FirebaseAuthException: ${e.message}');
      String message = '';
      if (e.code == 'weak-passwords') message = 'Weak passwords';
      if (e.code == 'email-already-in-use') message = 'Already exist an account with this email';
      return Left(message);
    }
  }
  
}