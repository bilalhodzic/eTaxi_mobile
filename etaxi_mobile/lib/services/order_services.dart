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
      "startTime": OrderProvider.instance.startTime?.toIso8601String() ??
          DateTime.now().toIso8601String(),
      "price": OrderProvider.instance.orderPrice,
      "paymentMethod":
          OrderProvider.instance.paymentMethod == PaymentMethod.CASH
              ? "Gotovina"
              : "Online",
    };

    try {
      if (OrderProvider.instance.paymentMethod == PaymentMethod.ONLINE) {
        await createStripePayment();
      }
      Response res =
          await ApiModels().postRequest(url: 'api/Order', data: dataToSend);
      if (res.statusCode == 200) {
        return res;
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

  static Future addStripeCustomer() async {
    var addCustomerData = {
      "email": AuthProvider.instance.user!.email,
      "name": AuthProvider.instance.user!.firstName! +
          " " +
          AuthProvider.instance.user!.lastName!,
      "creditCard": {
        "name": OrderProvider.instance.creditCardModel!.cardHolderName,
        "cardNumber": OrderProvider.instance.creditCardModel!.cardNumber,
        "expirationMonth":
            OrderProvider.instance.creditCardModel!.expiryDate.substring(0, 2),
        "expirationYear":
            OrderProvider.instance.creditCardModel!.expiryDate.substring(3),
        "cvc": OrderProvider.instance.creditCardModel!.cvvCode,
      }
    };
    try {
      Response res = await ApiModels()
          .postRequest(url: 'api/Stripe/customer/add', data: addCustomerData);
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future createStripePayment() async {
    var customer = await addStripeCustomer();
    var addPaymentData = {
      "customerId": customer["customerId"],
      "receiptEmail": customer["email"],
      "description": "eTaxi Narudžba",
      "currency": "BAM",
      "amount": int.parse(
          (OrderProvider.instance.orderPrice! * 100).toStringAsFixed(0))
    };
    try {
      Response res = await ApiModels()
          .postRequest(url: 'api/Stripe/payment/add', data: addPaymentData);
      inspect(res);
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw jsonDecode(res.body);
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
