import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_module/views/user_auth_page/otp_screen/otp_screen.dart';

class AuthService extends ChangeNotifier {
  // final _auth = FirebaseAuth.instance;
  final FirebaseAuth auth;
  var varificationId = ' ';

  AuthService({required this.auth});

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    log(phoneNumber.toString());

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          log(e.toString());
          if (e.code == 'invalid-phone-number') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text('Error, the provider phone number is invalid $e')));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text('Error, something went wrong. please try again $e')));
          }
          throw Exception(e.message);
        },
        codeSent: ((String verificationId, int? resendToken) async {
          // this.varificationId.value = varificationId;
          // Navigator.pushNamed(
          //   context,
          //   OTPScreen.routeName,
          //   arguments: verificationId,
          // );
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => OTPScreen()));
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('OTP Failed $e')));
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential);
      Navigator.pushReplacementNamed(context, '/user_home_screen');
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('OTP Failed $e')));
    }
  }
}
