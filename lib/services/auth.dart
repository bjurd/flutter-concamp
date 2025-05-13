import 'package:firebase_auth/firebase_auth.dart';

import 'package:concamp/services/firestore.dart';

class Auth
{
  static Future<String?> SignUp(String Name, String Email, String Password) async
  {
    return await Firestore.CreateUser(Name, Email, Password);
  }

  static Future<String?> Login(String Email, String Password) async
  {
    try
    {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: Email,
          password: Password
      );

      return null;
    }
    on FirebaseAuthException catch (e)
    {
      return e.message ?? "Failed to login";
    }
  }

  static String? GetUserID()
  {
    return FirebaseAuth.instance.currentUser?.uid;
  }
}