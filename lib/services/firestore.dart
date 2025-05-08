import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:concamp/services/auth.dart';
import 'package:concamp/models/post.dart';

class Firestore
{
  static Stream<QuerySnapshot<Map<String, dynamic>>> GetPostStream()
  {
    return FirebaseFirestore.instance
        .collection("posts")
        .orderBy(
          "timestamp",
          descending: true
        )
        .snapshots();
  }

  static Post BuildPost(DocumentSnapshot Data)
  {
    return Post(Data);
  }

  static List<Widget> BuildPostStream(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot)
  {
    List<Widget> Posts = [];

    for (DocumentSnapshot PostData in snapshot.data!.docs)
      Posts.add(BuildPost(PostData));

    return Posts;
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