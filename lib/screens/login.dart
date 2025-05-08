import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget
{
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>
{
  final FormKey = GlobalKey<FormState>();
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();

  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(),

        body: Form(
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
                          return "Enter password";

                        return null;
                      }
                  ),

                  ElevatedButton(
                      onPressed: () async
                      {
                        if (FormKey.currentState == null) return;
                        if (!FormKey.currentState!.validate()) return;

                        try
                        {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: EmailController.text,
                              password: PasswordController.text
                          );

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            "/home",
                            (r) => false
                          );
                        }
                        on FirebaseAuthException catch (e)
                        {
                          showDialog(
                              context: context,
                              builder: (context)
                              {
                                return AlertDialog(
                                    title: Text(e.message ?? "Failed to login")
                                );
                              }
                          );
                        }
                      },

                      child: Text("Login")
                  ),

                  ElevatedButton(
                      onPressed: ()
                      {
                        Navigator.pushNamed(context, "/signup");
                      },

                      child: Text("Go to sign up")
                  )
                ]
            )
        )
    );
  }
}