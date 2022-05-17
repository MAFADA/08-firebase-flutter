// M. Afada Nur Saiva Syahira
// MI-2F
// 2031710168
import 'package:firebase_flutter1/pages/second.dart';
import 'package:flutter/material.dart';
import '../services/authentication.dart';
import 'first_screen.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool _obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    // nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("2031710168 / M. Afada Nur Saiva Syahira"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const FlutterLogo(
              size: 150,
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: passController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              child: ElevatedButton(
                child: const Text("Login"),
                onPressed: () {
                  Authentication.signInEmailAndPassword(
                          email: emailController.text,
                          password: passController.text)
                      .then((result) {
                    if (result == null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmailScreen(
                            email: emailController.text,
                            name: '',
                          ),
                        ),
                      );
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                          result,
                          style: TextStyle(fontSize: 16),
                        ),
                      ));
                    }
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              child: const Text("Sign Up"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Ink(
              decoration: const ShapeDecoration(
                color: Colors.lightBlue,
                shape: CircleBorder(),
              ),
              child: IconButton(
                color: Colors.white,
                onPressed: () {
                  Authentication.signInWithGoogle().then((result) {
                    if (result != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const FirstScreen();
                          },
                        ),
                      );
                    }
                  });
                },
                icon: const ImageIcon(
                  AssetImage('assets/images/google_logo.png'),
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
