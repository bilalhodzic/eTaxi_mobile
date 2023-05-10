import 'dart:convert';
import 'dart:developer';

import 'package:etaxi_mobile/api/api_model.dart';
import 'package:etaxi_mobile/models/order_model.dart';
import 'package:etaxi_mobile/providers/auth_provider.dart';
import 'package:etaxi_mobile/providers/order_provider.dart';
import 'package:http/http.dart';

class OrderServices {
  static Future createOrder({bool isSelfDrive = false}) async {
    var vehicle = OrderProvider.instance.selectedVehicle!;

    var startLocationData = {
      "address": OrderProvider.instance.currentLocationData?.address,
      "latitude": OrderProvider.instance.currentLocationData?.latitude,
      "longitude": OrderProvider.instance.currentLocationData?.longitude,
      "city": OrderProvider.instance.currentLocationData?.city,
      "country": OrderProvider.instance.currentLocationData?.country,
      "postalCode": OrderProvider.instance.currentLocationData?.postalCode,
    };

    var endLocationData = {
      "address": OrderProvider.instance.destinationLocationData?.address,
      "latitude": OrderProvider.instance.destinationLocationData?.latitude,
      "longitude": OrderProvider.instance.destinationLocationData?.longitude,
      "city": OrderProvider.instance.destinationLocationData?.city,
      "country": OrderProvider.instance.destinationLocationData?.country,
      "postalCode": OrderProvider.instance.destinationLocationData?.postalCode,
    };

    var dataToSend = {
      "userDriverId": vehicle.driverId,
      "userId": AuthProvider.instance.user!.id,
      "startLocationId": await createLocation(startLocationData),
      "endLocationId": await createLocation(endLocationData),
      "vehicleId": vehicle.vehicleId,
      "isSelfDrive": isSelfDrive,
      "startTime": DateTime.now().toIso8601String(),
      "price": OrderProvider.instance.orderPrice,
      "paymentMethod":
          OrderProvider.instance.paymentMethod == PaymentMethod.CASH
              ? "Gotovina"
              : "Online",
    };

    try {
      Response res =
          await ApiModels().postRequest(url: 'api/Order', data: dataToSend);
      if (res.statusCode == 200) {
        OrderProvider.instance.setBookingStage(BookingStage.RIDE_BOOKED);
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future createLocation(data) async {
    try {
      Response res =
          await ApiModels().postRequest(url: 'api/Location', data: data);
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future getOrders({Map<String, dynamic>? queryParams}) async {
    try {
      Response res = await ApiModels()
          .getRequest(url: 'api/Order', queryParams: queryParams);
      if (res.statusCode == 200) {
        List<Order> orders = [];
        var data = json.decode(res.body);
        //inspect(data);
        data.forEach((element) {
          orders.add(Order.fromJson(element));
        });
        OrderProvider.instance.setOrders(orders);
      }
      return jsonDecode(res.body);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
