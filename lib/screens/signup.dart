import 'package:flutter/material.dart';

import 'package:concamp/services/auth.dart';

class SignUp extends StatefulWidget
{
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>
{
  final FormKey = GlobalKey<FormState>();
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  final VerifyController = TextEditingController();

  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(),

      body: SafeArea(
        child: Form(
          key: FormKey,

          child: Column(
            children: [
              TextFormField(
                controller: EmailController,

                validator: (value)
                {
                  if (value == null || value.length < 1)
                    return "Enter email address";

                  return null;
                },
              ),

              TextFormField(
                controller: PasswordController,

                validator: (value)
                {
                  if (value == null || value.length < 1)
                    return "Enter a password";

                  if (value != VerifyController.text)
                    return "Passwords do not match";

                  return null;
                }
              ),

              TextFormField(
                  controller: VerifyController,

                  validator: (value)
                  {
                    if (value == null || value.length < 1)
                      return "Enter a password";

                    if (value != PasswordController.text)
                      return "Passwords do not match";

                    return null;
                  }
              ),

              ElevatedButton(
                onPressed: () async
                {
                  if (FormKey.currentState == null) return;
                  if (!FormKey.currentState!.validate()) return;

                  String? Message = await Auth.SignUp(
                      EmailController.text,
                      PasswordController.text
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
                    Navigator.pushNamed(context, "/login");
                  }
                },

                child: Text("Sign Up")
              ),

              ElevatedButton(
                onPressed: ()
                {
                  Navigator.pushNamed(context, "/login");
                },

                child: Text("Go to login")
              )
            ]
          )
        ),
      )
    );
  }
}