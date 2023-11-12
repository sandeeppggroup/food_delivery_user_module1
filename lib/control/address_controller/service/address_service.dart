import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_module/core/constants/api/api_base_url.dart';
import 'package:user_module/core/constants/api/api_end_url.dart';
import 'package:user_module/model/address_model/address_model.dart';

class AddressService {
  final addAddressUrl = ApiBaseUrl().baseUrl + ApiEndUrl().addAddress;
  final getAllAdress = ApiBaseUrl().baseUrl + ApiEndUrl().getAllAddress;
  final deleteAddressUrl = ApiBaseUrl().baseUrl + ApiEndUrl().deleteAddress;

  Dio dio = Dio();

  Future<bool> addAddress(AddressModel addressModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Response response = await dio.post(addAddressUrl,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: addressModel.toJson());

    try {
      if (response.statusCode == 200) {
        log('response in address service success:  ${response.data.toString()}');
        return true;
      } else {
        log('response in address service failed:  ${response.data.toString()}');
        return false;
      }
    } catch (e) {
      log('Error in address service: $e');
      return false;
    }
  }

  Future<List<AddressModel>> getAllAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    log(token.toString());

    Response response = await dio.get(
      getAllAdress,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    try {
      if (response.statusCode == 200) {
        log('get all address : ${response.data.toString()}');
        List<dynamic> addressJson = response.data['data'];
        List<AddressModel> getAllAddress = addressJson
            .map((addressList) => AddressModel.fromJson(addressList))
            .toList();
        return getAllAddress;
      } else {
        log('Something went worng: ${response.data.toString()}');
        return [];
      }
    } catch (e) {
      log('Error $e');
      return [];
    }
  }

  Future<bool> deleteAddress(String addressId) async {
    final deleteUrl = deleteAddressUrl + addressId;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    log('addresId : $addressId, token : $token');
    try {
      Response response = await dio.delete(
        deleteUrl,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        log('success: ${response.data}');
        return true;
      } else {
        log('message : ${response.data.toString()}');
        return false;
      }
    } catch (e) {
      log('Delete Error : $e');
      return false;
    }
  }
}
