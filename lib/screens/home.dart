import 'package:flutter/material.dart';

import "package:cloud_firestore/cloud_firestore.dart";

class Home extends StatefulWidget
{
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
{
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(),

      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("posts")
              .snapshots(),

          builder: (context, snapshot)
          {
            if (!snapshot.hasData)
              return Text("Thinking");

            return Text("Yay!");
          }
        )
      )
    );
  }
}