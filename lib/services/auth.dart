import 'package:firebase_auth/firebase_auth.dart';

class Auth
{
  static Future<String?> SignUp(String Email, String Password) async
  {
    try
    {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: Email,
          password: Password
      );

      return null;
    }
    on FirebaseAuthException catch (e)
    {
      return e.message ?? "Failed to sign up";
    }
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
}