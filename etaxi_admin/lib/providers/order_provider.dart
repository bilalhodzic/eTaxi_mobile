import 'package:etaxi_admin/models/order_model.dart';
import 'package:etaxi_admin/models/vehicle_model.dart';
import 'package:flutter/widgets.dart';

import '../models/location_model.dart';

enum PaymentMethod { CASH, ONLINE }

class OrderProvider extends ChangeNotifier {
  //singleton
  static OrderProvider? _instance;
  static OrderProvider get instance {
    if (_instance == null) {
      _instance = OrderProvider._();
    }

    return _instance!;
  }

  OrderProvider._();

  //Taxi order part START
  Location? currentLocationData;
  Location? destinationLocationData;

  DateTime? startTime;
  VehicleModel? selectedVehicle;
  double? orderPrice;
  PaymentMethod paymentMethod = PaymentMethod.CASH;

  bool isEditOrder = false;
  int? orderId;
  List<Order> orders = [];
  Order? selectedOrder;

  Map<String, dynamic> vehicleFilters = {};

  void setVehicleFilters(Map<String, dynamic> filters) {
    vehicleFilters = filters;
    notifyListeners();
  }

  void setOrderId(int? id) {
    orderId = id;
    notifyListeners();
  }

  void setIsEditOrder(bool value) {
    isEditOrder = value;

    notifyListeners();
  }

  void setOrderPrice(double price, {bool notify = true}) {
    orderPrice = price;
    if (notify) notifyListeners();
  }

  void setStartTime(DateTime? time) {
    startTime = time;
    notifyListeners();
  }

  void setPaymentMethod(PaymentMethod method) {
    paymentMethod = method;
    notifyListeners();
  }

  Future setCurrentLoc(Location loc) async {
    currentLocationData = loc;

    notifyListeners();
  }

  Future setSelectedVehicle(VehicleModel veh) async {
    selectedVehicle = veh;

    notifyListeners();
  }

  Future setDestinationLoc(Location loc) async {
    destinationLocationData = loc;

    notifyListeners();
  }

  void resetToInit([bool shouldNotify = false]) {
    destinationLocationData = null;
    currentLocationData = null;

    paymentMethod = PaymentMethod.CASH;
    selectedVehicle = null;
    orderPrice = null;
    DateTime? startTime = null;
    isEditOrder = false;

    orderId = null;

    if (shouldNotify) notifyListeners();
  }

  //Taxi order part END
}
