import 'dart:developer';

import 'package:etaxi_mobile/models/directions_model.dart';
import 'package:etaxi_mobile/models/location_model.dart';
import 'package:etaxi_mobile/models/order_model.dart';
import 'package:etaxi_mobile/models/vehicle_model.dart';
import 'package:etaxi_mobile/screens/taxi/widgets/googleMapWidget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum BookingStage { PICKUP, DESTINATION, VEHICLES, RIDE_BOOKED }

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
  Directions? directions;

  DateTime? startTime;

  VehicleModel? selectedVehicle;
  double? orderPrice;

  BookingStage stage = BookingStage.PICKUP;

  PaymentMethod paymentMethod = PaymentMethod.CASH;

  List<Order> orders = [];

  //Credit card fields;
  CreditCardModel? creditCardModel;

//sets the value for taxi service type which can be selected on HomeMainTaxi page

  void setCreditCardModel(CreditCardModel? model) {
    creditCardModel = model;
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

  void setOrders(List<Order> ordersData) {
    orders = ordersData;
    notifyListeners();
  }

  void setSelectedVehicle(VehicleModel vehicle) {
    selectedVehicle = vehicle;
    notifyListeners();
  }

  void setPaymentMethod(PaymentMethod method) {
    paymentMethod = method;
    notifyListeners();
  }

  String calculateTotalPrice() {
    double total = 0;
    if (directions != null) {
      //parse total distance from directions into double number
      double distanceNumber = double.tryParse(directions!.totalDistance!
              .substring(0, directions!.totalDistance!.indexOf("km"))) ??
          1;
      total = distanceNumber * selectedVehicle!.price!;
    }
    setOrderPrice(total, notify: false);
    return total.toStringAsFixed(2) + " BAM";
  }

  void setBookingStage(BookingStage stage) {
    this.stage = stage;
    notifyListeners();
  }

  Future setCurrentLoc(Location loc) async {
    currentLocationData = loc;
    await mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(loc.latitude!, loc.longitude!), zoom: 15)));
    notifyListeners();
  }

  Future setDestinationLoc(Location loc) async {
    destinationLocationData = loc;
    await mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(loc.latitude!, loc.longitude!), zoom: 15)));

    notifyListeners();
  }

  Future setDirections(Directions dir) async {
    directions = dir;
    await mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(directions!.bounds!, 100),
    );
    notifyListeners();
  }

  Future animateMapToDirectionBounds() async {
    await mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(directions!.bounds!, 100),
    );
    notifyListeners();
  }

  void resetToInit([bool shouldNotify = false]) {
    stage = BookingStage.PICKUP;

    destinationLocationData = null;
    directions = null;
    paymentMethod = PaymentMethod.CASH;
    selectedVehicle = null;
    orderPrice = null;
    DateTime? startTime = null;

    if (shouldNotify) notifyListeners();
  }

  //Taxi order part END

}
