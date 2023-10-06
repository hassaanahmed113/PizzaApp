import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pizzaapp/payment/Keys.dart';

class StripeAPI {
  static createPaymentIntent(
      String amount, String currency, BuildContext context) async {
    try {
      var response = await http
          .post(Uri.parse('https://api.stripe.com/v1/payment_intents'), body: {
        'amount': "${amount}00",
        'currency': currency,
        'payment_method_types[]': 'card',
      }, headers: {
        'Authorization': 'Bearer ${Keys.secretKey}',
        'Content-Type': 'application/x-www-form-urlencoded'
      });
      return jsonDecode(response.body);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
      return null; // Return null to indicate an error
    }
  }

  static Future<bool> makePayment(
      String amount, String currency, BuildContext context) async {
    Map<String, dynamic>? paymentIntentData;
    try {
      paymentIntentData = await createPaymentIntent(amount, currency, context);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData['client_secret'],
            // applePay:
            //     const PaymentSheetApplePay(merchantCountryCode: "+1"),
            // googlePay:
            //     const PaymentSheetGooglePay(merchantCountryCode: "+1"),
            // customerEphemeralKeySecret: paymentIntentData['ephemeralKey'],
            customerId: 'id',
            merchantDisplayName: 'name',
          ),
        );
        await Stripe.instance.presentPaymentSheet();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Payment is successful"),
            backgroundColor: Colors.green,
          ),
        );

        return true; // Return true to indicate a successful payment
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Payment is not done yet...."),
          backgroundColor: Colors.red,
        ),
      );
      return false; // Return false to indicate a failed payment
    }
    return false; // Return false by default if no payment is attempted
  }
}
