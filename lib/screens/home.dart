import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:concamp/services/firestore.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Stack(
          children: [
            Text(
              "BookFace",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          Navigator.pushNamed(context, "/make");
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),

      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          child: StreamBuilder(
            stream: Firestore.GetPostStream(),
            builder: (context, snapshot)
            {
              if (!snapshot.hasData)
                return Center(child: Text("Thinking"));
              return ListView(
                children: Firestore.BuildPostStream(snapshot).map((postWidget) => Card(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: postWidget,
                  ),
                ))
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}