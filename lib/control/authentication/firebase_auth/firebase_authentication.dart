import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_module/views/user_auth_screen/otp_screen/otp_screen.dart';

class FireBaseAuthService extends ChangeNotifier {
  // final _auth = FirebaseAuth.instance;
  final FirebaseAuth auth;
  // dynamic varificationId;

  FireBaseAuthService({required this.auth});

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
        codeSent: ((String? verificationId, int? resendToken) async {
          log('in signin with phone : ${verificationId.toString()}');

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OTPScreen(
                phoneNumber: phoneNumber,
                varificationId: verificationId.toString(),
              ),
            ),
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('OTP Failed $e')));
    }
  }

  Future<bool> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      log('varification id: ${verificationId.toString()}');
      await auth.signInWithCredential(credential);
      log('log in verityOtp after credential : ${credential.token.toString()}');
      return true;
    } on FirebaseAuthException catch (e) {
      log('wrong otp ${e.message}');
      return false;
    }
  }
}
