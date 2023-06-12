import 'dart:convert';

import 'package:etaxi_admin/api/api_model.dart';
import 'package:etaxi_admin/models/vehicle_model.dart';
import 'package:etaxi_admin/models/vehicle_type_model.dart';
import 'package:etaxi_admin/providers/main_provider.dart';
import 'package:http/http.dart';

class MainServices {
  static Future<List<VehicleType>> getVehicleTypes() async {
    try {
      Response res = await ApiModels().getRequest(url: 'api/VehicleType');
      var decoded = jsonDecode(res.body);
      List<VehicleType> vehicleTypesList = [];
      for (var item in decoded) {
        vehicleTypesList.add(VehicleType.fromJson(item));
      }
      return vehicleTypesList;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<VehicleModel>> getVehicles(
      {Map<String, dynamic>? queryParams = const {}}) async {
    List<VehicleModel> vehicles = [];
    try {
      Response res = await ApiModels()
          .getRequest(url: 'api/Vehicle', queryParams: queryParams);

      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        data.forEach((element) {
          vehicles.add(VehicleModel.fromJson(element));
        });
        MainProvider.instance.setAvailableModels(vehicles);
      }
    } catch (e) {
      print('Error in getSelfDrivingVehicles: $e');
    }
    return vehicles;
  }

  Future addVehicle({required Map<String, Object> data}) async {
    Response res =
        await ApiModels().postRequest(url: 'api/Vehicle', data: data);
    if (res.statusCode == 200) {
      //var token = jsonDecode(res.body)['Token'];
      //AuthProvider.instance.setToken(token);
    } else {
      //AuthProvider.instance.setError(jsonDecode(res.body)["title"], 'register');
      print(res.body);
    }

    return res;
  }
//Add vehicle type

  Future addVehicleType({required Map<String, Object> data}) async {
    Response res =
        await ApiModels().postRequest(url: 'api/VehicleType', data: data);
    if (res.statusCode == 200) {
      // var token = jsonDecode(res.body)['Token'];
      //AuthProvider.instance.setToken(token);
    } else {
      //AuthProvider.instance.setError(jsonDecode(res.body)["title"], 'register');
      print(res.body);
    }

    return res;
  }

  Future deleteVehicle({required int id}) async {
    Response res = await ApiModels().deleteRequest(url: 'api/Vehicle/$id');
    if (res.statusCode == 200) {
      //var token = jsonDecode(res.body)['Token'];
      //AuthProvider.instance.setToken(token);
    } else {
      //AuthProvider.instance.setError(jsonDecode(res.body)["title"], 'register');
      print(res.body);
    }
    return res;
  }
}
