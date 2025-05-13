import 'package:flutter/material.dart';
import 'package:concamp/services/firestore.dart';

class EditPost extends StatefulWidget {
  final String id;
  final String title;
  final String body;

  const EditPost({
    super.key,
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _bodyController = TextEditingController(text: widget.body);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Title is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _bodyController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Body",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Body is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState == null ||
                      !_formKey.currentState!.validate()) return;

                  String? message = await Firestore.EditPost(
                    widget.id,
                    _titleController.text,
                    _bodyController.text,
                  );

                  if (message != null) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(message),
                        );
                      },
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
