import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/user/user_model.dart';
import 'auth_api_repository.dart';

/// Implementation of [AuthApiRepository] for making HTTP requests to the authentication API.
class AuthHttpApiRepository implements AuthApiRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  /// Sends a login request to the authentication API with the provided [data].
  ///
  /// Returns a [UserModel] representing the user data if the login is successful.
  @override
  Future<dynamic> loginApi(dynamic data) async {
    dynamic response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data['email'], password: data['password']);
    return response;
  }

  @override
  Future<dynamic> signupApi(dynamic data) async {
    dynamic response = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: data['email'], password: data['password']);       
    return response;
  }
  
  @override
  Future saveuserData(dynamic data) async{
    dynamic response = FirebaseFirestore.instance.collection('users').doc(data['email']).set({
      'name': data['name'],
      'email': data['email'],
      'password': data['password'],
      'fcm': data['fcm']
    }).then((value) {
      if (kDebugMode) {
        print("data inserted");
      }
    });
    return response;
  }
  
}
