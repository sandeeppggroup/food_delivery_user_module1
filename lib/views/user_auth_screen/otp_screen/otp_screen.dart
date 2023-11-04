import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/control/authentication/db_authentication/db_authentication.dart';
import 'package:user_module/control/authentication/firebase_auth/firebase_authentication.dart';
import 'package:user_module/control/authentication/provider_otp/otp_provider.dart';
import 'package:user_module/core/colors/colors.dart';
import 'package:user_module/widget/show_dialog.dart';

class OTPScreen extends StatefulWidget {
  final String varificationId;
  final String phoneNumber;
  const OTPScreen(
      {super.key, required this.varificationId, required this.phoneNumber});

  @override
  // ignore: library_private_types_in_public_api
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  Future<bool> verifyOTP(BuildContext context, String userOTP) {
    log(widget.varificationId);
    final otpStatus = Provider.of<FireBaseAuthService>(context, listen: false)
        .verifyOTP(
            context: context,
            verificationId: widget.varificationId,
            userOTP: userOTP);
    return otpStatus;
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  Timer? _timer;
  int _start = 60;
  String getFormattedTime() {
    final minutes = (_start / 60).floor();
    final seconds = _start % 60;
    final formattedMinutes = minutes.toString().padLeft(2, '0');
    final formattedSeconds = seconds.toString().padLeft(2, '0');
    return '$formattedMinutes:$formattedSeconds';
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    } else {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) => setState(
          () {
            if (_start < 1) {
              timer.cancel();
            } else {
              _start = _start - 1;
            }
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AuthService authService = AuthService(auth: );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: userAppBar,
        title: const Text("OTP Verification"),
      ),
      body: Consumer<OtpProvider>(
        builder: (context, otpProvider, _) => Column(
          children: [
            otpProvider.showProgress
                ? const SpinKitChasingDots(
                    color: Colors.blue,
                    size: 150,
                  )
                : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const Text('Verify your OTP'),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          child: OtpTextField(
                            focusedBorderColor: buttonColor,
                            cursorColor: buttonColor,
                            numberOfFields: 6,
                            borderColor: buttonColor,
                            showFieldAsBox: true,
                            keyboardType: TextInputType.number,
                            onSubmit: (val) async {
                              if (val.length == 6) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                otpProvider.setProgress(true);
                                final userOtp = val.trim();

                                bool otpStatus =
                                    // ignore: use_build_context_synchronously
                                    await verifyOTP(context, userOtp);
                                if (otpStatus == true) {
                                  log('in otp :  ${widget.phoneNumber.toString()}');

                                  final phoneNumber =
                                      widget.phoneNumber.toString();
                                  prefs.setString('phoneNumber', phoneNumber);

                                  // ignore: use_build_context_synchronously
                                  Provider.of<DbAuthService>(context,
                                          listen: false)
                                      .loginUser(context, widget.phoneNumber);
                                } else {
                                  otpProvider.setProgress(false);
                                  // ignore: use_build_context_synchronously
                                  showItemSnackBar(context,
                                      massage: 'Invalid Otp !',
                                      color: Colors.red);
                                }
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        _start > 0
                            ? Text(
                                'Time remaining  : ${getFormattedTime()}',
                                style: const TextStyle(fontSize: 16),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text("Did'nt received a code?"),
                                    InkWell(
                                      onTap: () {
                                        // ref
                                        //     .read(authControllerProvider)
                                        //     .signInWithPhone(context, widget.phoneNumber);
                                      },
                                      child: const Text(
                                        "Resend OTP",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
