import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:concamp/services/auth.dart';

class Firestore
{
  static Stream<QuerySnapshot<Map<String, dynamic>>> GetPostStream()
  {
    return FirebaseFirestore.instance
        .collection("posts")
        .snapshots();
  }

  static Future<String?> CreatePost(String Title, String Body) async
  {
    String? UserID = Auth.GetUserID();

    if (UserID == null)
      return "You are not logged in";

    // TODO: Error handling
    //try
    //{
      FirebaseFirestore.instance
          .collection("posts")
          .add({
            "title": Title,
            "body": Body,
            "author": UserID,
            "timestamp": DateTime.now().toString()
          });
    //}

    return null;
  }
}