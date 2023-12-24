//splash screen
import 'dart:developer';
import 'dart:io';

import 'package:example/apis/apis.dart';
import 'package:example/helper/dialogs.dart';
import 'package:example/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _scale = 0.0;

  @override
  void initState() {
    animate();
    super.initState();
  }

  Future<void> animate() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _scale = _scale == 0.0 ? 0.6 : 0.0;
    });
  }

  _handleGoogleLogin() {
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );

        log('user: ${user.user}');
        log('additional Info: ${user..additionalUserInfo}');
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await Apis.auth.signInWithCredential(credential);
    } catch (e) {
      log('_SigninWithGoogle: $e');
      Dialogs.showSnackbar(
        context,
        'Something went wrong, please check internet',
        MsgType.error,
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Welcome to FL Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: SvgPicture.asset(
                'assets/chat.svg',
                width: 200,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                shape: const StadiumBorder(),
                elevation: 1,
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
              ),
              onPressed: () {
                _handleGoogleLogin();
              },
              icon: SvgPicture.asset(
                'assets/google.svg',
                height: 30,
              ),
              label: RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(text: 'Login with '),
                    TextSpan(
                      text: 'Google',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
