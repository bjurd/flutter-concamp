import 'package:concamp/services/auth.dart';
import 'package:flutter/material.dart';

import 'package:concamp/services/firestore.dart';

class CreatePost extends StatefulWidget
{
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost>
{
  final FormKey = GlobalKey<FormState>();
  final TitleController = TextEditingController();
  final BodyController = TextEditingController();

  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(),

      body: Form(
        key: FormKey,

        child: Column(
          children: [
            TextFormField(
              controller: TitleController,

              validator: (value)
              {
                if (value == null || value.length < 1)
                  return "Enter a title";

                return null;
              }
            ),

            TextFormField(
              controller: BodyController,

              validator: (value)
              {
                if (value == null || value.length < 1)
                  return "Enter a description";

                return null;
              },
            ),

            ElevatedButton(
              onPressed: () async
              {
                if (FormKey.currentState == null) return;
                if (!FormKey.currentState!.validate()) return;

                String? Message = await Firestore.CreatePost(
                  TitleController.text,
                  BodyController.text
                );

                if (Message != null)
                {
                  showDialog(
                      context: context,
                      builder: (context)
                      {
                        return AlertDialog(
                            title: Text(Message)
                        );
                      }
                  );
                }
                else
                {
                  Navigator.pop(context);
                }
              },

              child: Text("Make post")
            )
          ]
        )
      )
    );
  }
}