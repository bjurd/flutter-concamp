import 'package:flutter/material.dart';
import 'package:concamp/services/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FormKey = GlobalKey<FormState>();
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  final VerifyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: FormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person_add, size: 100, color: Colors.deepPurple),

                SizedBox(height: 20),

                TextFormField(
                  controller: EmailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 1) {
                      return "Enter email address";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16),

                TextFormField(
                  controller: PasswordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return "Enter a password";
                    if (value != VerifyController.text)
                      return "Passwords do not match";
                    return null;
                  },
                ),

                SizedBox(height: 16),

                TextFormField(
                  controller: VerifyController,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return "Enter a password";
                    if (value != PasswordController.text)
                      return "Passwords do not match";
                    return null;
                  },
                ),

                SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () async {
                    if (FormKey.currentState == null) return;
                    if (!FormKey.currentState!.validate()) return;

                    String? Message = await Auth.SignUp(
                      EmailController.text,
                      PasswordController.text,
                    );

                    if (Message != null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(title: Text(Message));
                        },
                      );
                    } else {
                      Navigator.pushNamed(context, "/login");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Sign Up", style: TextStyle(fontSize: 16)),
                ),

                SizedBox(height: 12),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  child: Text(
                    "Already have an account? Log in",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
