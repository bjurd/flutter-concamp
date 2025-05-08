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
      appBar: AppBar(
        title: Text(
          "Create a Post",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: FormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: TitleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),

                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a title";
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              TextFormField(
                controller: BodyController,
                decoration: InputDecoration(
                  labelText: "Description",
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a description";
                  }
                  return null;
                },
              ),

              SizedBox(height: 24),

              ElevatedButton(
                onPressed: () async {
                  if (FormKey.currentState == null) return;
                  if (!FormKey.currentState!.validate()) return;

                  String? Message = await Firestore.CreatePost(
                    TitleController.text,
                    BodyController.text,
                  );

                  if (Message != null) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(Message),
                        );
                      },
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Make Post", style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
