import 'package:flutter/material.dart';

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
      appBar: AppBar(),

      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          Navigator.pushNamed(context, "/make");
        },

        child: Icon(Icons.add)
      ),

      body: SafeArea(
        child: StreamBuilder(
          stream: Firestore.GetPostStream(),

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