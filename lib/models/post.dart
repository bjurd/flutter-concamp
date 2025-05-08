import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

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

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(Title),
          Text(Body),
          Text(AuthorID)
        ]
      )
    );
  }
}