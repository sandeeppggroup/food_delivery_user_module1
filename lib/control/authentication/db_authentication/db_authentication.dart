import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/control/authentication/provider_login/login_provider.dart';
import 'package:user_module/control/authentication/provider_otp/otp_provider.dart';
import 'package:user_module/core/constants/api/api_base_url.dart';
import 'package:user_module/core/constants/api/api_end_url.dart';
import 'package:user_module/widget/show_dialog.dart';

class DbAuthService extends ChangeNotifier {
  final signInUrl = ApiBaseUrl().baseUrl + ApiEndUrl().logIn;
  final saveUserNameUrl = ApiBaseUrl().baseUrl + ApiEndUrl().saveUserName;
  final checkTokenStatusUrl = ApiBaseUrl().baseUrl + ApiEndUrl().checkToken;

  Future<dynamic> loginUser(BuildContext context, String mobileNumber) async {
    final Dio dio = Dio();

    try {
      Response response = await dio.post(
        signInUrl,
        data: {'mobile': mobileNumber},
      );

      if (response.statusCode == 200) {
        log(' if case : ${response.statusCode}');

        final token = response.data['data'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        // ignore: use_build_context_synchronously
        Provider.of<LoginProvider>(context, listen: false).setProgress(false);

        // ignore: use_build_context_synchronously
        Provider.of<OtpProvider>(context, listen: false).setProgress(false);

        // ignore: use_build_context_synchronously
        // Navigator.pushReplacementNamed(context, '/user_home_screen');

        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, '/user_home_screen', (route) => false);
      } else if (response.statusCode == 201) {
        log(' else if case : ${response.data['data']}');

        final token = response.data['data'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        // ignore: use_build_context_synchronously
        showItemSnackBar(context,
            massage: response.data['message'], color: Colors.blue);

        // ignore: use_build_context_synchronously
        Provider.of<LoginProvider>(context, listen: false).setProgress(false);

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/user_signup');
      }
    } catch (e) {
      log('Error :  $e');
    }
  }

  Future<void> saveUserName(
      BuildContext context, String name, String token) async {
    final Dio dio = Dio();

    try {
      Response response = await dio.post(
        saveUserNameUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'name': name,
        },
      );

      if (response.statusCode == 200) {
        log('${response.data}');

        // ignore: use_build_context_synchronously
        // Navigator.pushReplacementNamed(context, '/user_home_screen');

        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, '/user_home_screen', (route) => false);

        // ignore: use_build_context_synchronously
        showItemSnackBar(context,
            massage: '${response.data['message']}', color: Colors.green);
      } else {
        return;
      }
    } catch (e) {
      log('Error in save username : $e');
    }
  }

  Future<dynamic> checkTokenStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await Future.delayed(const Duration(milliseconds: 20));

    final token = prefs.getString('token');
    log('Token in checktokenstatus : $token');

    final Dio dio = Dio();
    if (token != null) {
      try {
        Response response = await dio.post(
          checkTokenStatusUrl,
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );

        log('Response in checktokenstatus : $response');

        if (response.statusCode == 200) {
          if (response.data['success'] == true) {
            return response.data;
          } else {
            return response.data['success'];
          }
        }
      } catch (e) {
        log('error in check in user log :  $e');
        return false;
      }
    } else {
      return false;
    }
  }
}
