import 'package:flutter/material.dart';

import 'package:concamp/services/auth.dart';

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
                            return "Enter password";
          
                          return null;
                        }
                    ),
          
                    ElevatedButton(
                        onPressed: () async
                        {
                          if (FormKey.currentState == null) return;
                          if (!FormKey.currentState!.validate()) return;

                          String? Message = await Auth.Login(
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
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              "/home",
                              (r) => false
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
          ),
        )
    );
  }
}