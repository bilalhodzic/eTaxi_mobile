import 'package:etaxi_mobile/models/directions_model.dart';
import 'package:etaxi_mobile/screens/taxi/widgets/googleMapWidget.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum TaxiServiceType { LOCAL, OUTSTATION }

enum BookingStage { PICKUP, DESTINATION, VEHICLES, RIDE_BOOKED }

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
  TaxiServiceType taxiServiceType = TaxiServiceType.LOCAL;
  LatLng? currentLocation;
  String? currentAddress;

  LatLng? destinationLocation;
  String? destinationAddress;

  Directions? directions;

  BookingStage stage = BookingStage.PICKUP;

  String paymentMethod = 'Online';

//sets the value for taxi service type which can be selected on HomeMainTaxi page
  void setTaxiServiceType(TaxiServiceType type) {
    taxiServiceType = type;
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    paymentMethod = method;
    notifyListeners();
  }

  void setBookingStage(BookingStage stage) {
    this.stage = stage;
    notifyListeners();
  }

  Future setCurrentLoc(LatLng loc, String add) async {
    currentLocation = loc;
    currentAddress = add;
    await mapController?.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: loc, zoom: 15)));
    notifyListeners();
  }

  Future setDestinationLoc(LatLng loc, String add) async {
    destinationLocation = loc;
    destinationAddress = add;
    await mapController?.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: loc, zoom: 15)));

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
    taxiServiceType = TaxiServiceType.LOCAL;

    destinationLocation = null;
    destinationAddress = null;
    directions = null;
    paymentMethod = 'Online';

    if (shouldNotify) notifyListeners();
  }

  //Taxi order part END

}
