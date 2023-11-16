import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:user_module/control/authentication/provider_login/login_provider.dart';
import 'package:user_module/core/colors/colors.dart';
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
          log('firebase error:  ${e.message.toString()}');
          if (e.code == 'invalid-phone-number') {
            Fluttertoast.showToast(
                msg:
                    'An error occurred. Please try again later : ${e.message.toString()}',
                fontSize: 16,
                backgroundColor: buttonColor,
                toastLength: Toast.LENGTH_LONG);
            Provider.of<LoginProvider>(context, listen: false)
                .setProgress(false);
            return;
          } else {
            log('firebase error: ${e.message}');
            Fluttertoast.showToast(
                msg:
                    'An error occurred. Please try again later : ${e.message.toString()}',
                fontSize: 16,
                backgroundColor: buttonColor,
                toastLength: Toast.LENGTH_LONG);
            Provider.of<LoginProvider>(context, listen: false)
                .setProgress(false);
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
