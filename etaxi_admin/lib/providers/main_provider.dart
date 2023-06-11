import 'dart:developer';
import 'package:etaxi_admin/models/brand_model.dart';
import 'package:etaxi_admin/models/hub_model.dart';
import 'package:etaxi_admin/models/vehicle_model.dart';
import 'package:etaxi_admin/models/vehicle_type_model.dart';
import 'package:flutter/widgets.dart';

class MainProvider extends ChangeNotifier {
  //singleton
  static MainProvider? _instance;
  static MainProvider get instance {
    if (_instance == null) {
      _instance = MainProvider._();
    }

    return _instance!;
  }

  MainProvider._();
  MainProvider._internal();

  String? _city;
  String? get city => _city;

  List<VehicleType> _vehicleType = [];
  List<VehicleType> get vehicleType => [..._vehicleType];

  List<VehicleModel> _availableModel = [];
  List<VehicleModel> get availableModel => [..._availableModel];

  final List<Map<String, List<BrandModel>>> _brandModel = [];
  List<Map<String, List<BrandModel>>> get brandModel => [..._brandModel];

  List<Hub> _allHub = [];
  List<Hub> get allHub => [..._allHub];

  void setAvailableModels(List<VehicleModel> vehicles) {
    _availableModel = vehicles;
  }

  void setVehicleTypes(List<VehicleType> types) {
    _vehicleType = types;
  }

  void setAllHubs(List<Hub> hubs) {
    _allHub = hubs;
  }
}
