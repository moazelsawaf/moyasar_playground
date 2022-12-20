import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:moyasar_payment/model/source/applepaymodel.dart';
import 'package:moyasar_payment/model/source/stcpaymodel.dart';
import 'package:moyasar_payment/moyasar_payment.dart';
import 'package:moyasar_payment/model/source/creditcardmodel.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _applePay,
            child: const Text('Hello World'),
          ),
        ),
      ),
    );
  }

  Future<void> _creditCardPay() async {
    final res = await MoyasarPayment().creditCard(
      description: 'Test Payment',
      amount: 100.0,
      publishableKey: 'pk_test_PcfsWh5PodJAfGTwr7aXgY53bCmdhutLwBMMeJwM',
      cardHolderName: 'Moaz Hazem El-sawaf',
      // add test credit card number
      cardNumber: '4111111111111111',
      cvv: 123,
      expiryManth: 1,
      expiryYear: 25,
      callbackUrl: 'https://example.com/orders',
    );

    if (res != null) {
      CreditcardModel creditcardModel = CreditcardModel.fromJson(res.source);
      Logger().d(creditcardModel.toJson());
    } else {
      Logger().e('Error');
    }
  }

  Future<void> _applePay() async {
    var items = <String, double>{'Item 1': 20.0, 'Item 2': 80.0};

    final res = await MoyasarPayment().applePay(
      amount: 100.0,
      publishableKey: 'pk_test_PcfsWh5PodJAfGTwr7aXgY53bCmdhutLwBMMeJwM',
      applepayMerchantId: 'merchant.net.smartangle.arto',
      paymentItems: items,
      currencyCode: 'SAR',
      countryCode: 'SA',
      description: 'Apple Pay Test',
    );

    if (res != null) {
      ApplePayModel applePayModel = ApplePayModel.fromJson(res.source);
      Logger().d(applePayModel.toJson());
    } else {
      Logger().e('Error');
    }
  }

  Future<void> _stcPay() async {
    final res = await MoyasarPayment().stcPay(
      amount: 100.0,
      phoneNumber: '0500000000',
      publishableKey: 'pk_test_PcfsWh5PodJAfGTwr7aXgY53bCmdhutLwBMMeJwM',
      description: 'description',
    );

    if (res != null) {
      STCPayModel stcPayModel = STCPayModel.fromJson(res.source);
      Logger().d(stcPayModel.toJson());
    } else {
      Logger().e('Error');
    }
  }
}


// TODO: Export all the imports into a single file
// TODO: Enhance pub.dev score
// TODO: Update the docs to fix credit payment model
// TODO: Remove the line of the plugin is available on pub.dev
// TODO: Apply linting rules
// TODO: Fix Android Example build issues
// TODO: Fix the library name
// TODO: Fix the issue on GitHub of not a number, it is because of the credit card number
// TODO: Better handle the response
// TODO: Better handle the error and eliminate the not initialized source error


