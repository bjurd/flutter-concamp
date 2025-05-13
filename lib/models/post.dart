import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:concamp/services/firestore.dart';
import 'package:concamp/services/auth.dart';

import 'package:concamp/screens/edit_post.dart';

class Post extends StatelessWidget
{
  DocumentSnapshot? PostData;

  Post(DocumentSnapshot Data)
  {
    this.PostData = Data;
  }

  Widget build(BuildContext context)
  {
    String Title = PostData?["title"] ?? "N/A";
    String Body = PostData?["body"] ?? "N/A";
    String AuthorID = PostData?["author"] ?? "N/A";

    return FutureBuilder(
        future: Firestore.GetUserInfo(AuthorID),
        builder: (context, snapshot)
        {
          if (snapshot == null) return Text("");
          if (!snapshot.hasData) return Text("");

          String AuthorName = snapshot.data!.docs[0]["name"]; // blek

          Widget Edit = Text("");

          if (AuthorID == Auth.GetUserID())
          {
            Edit = ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPost(
                      id: PostData!.id,
                      title: Title,
                      body: Body,
                    ),
                  ),
                );
              },

              icon: Icon(Icons.edit, color: Colors.white),
              label: Text(
                "Edit",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            );
          }

          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("User: $AuthorName", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                SizedBox(height: 12.0),
                Text(Title),
                Text(Body),
                SizedBox(height: 12.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Edit
                ),
              ],
            ),
          );
        }
    );
  }
}