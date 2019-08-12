import 'package:flutter/material.dart';
import 'package:flutter_shockinflux/flutter_shockinflux.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  int amount = 50000;
  String email = 'temitopeadesoji23@gmail.com';
  String storeid =
      'a0s0wnpbao00000U2FsdGVkX19oAaYMU3J2p0REVWe5NokqwSUZGocEFNXM9orMV8bbYBmyUHb0EkiZLb1/5ZOd/u892gz2huuob9E2TmUFTR2u97LQsfPdz53lFVh2pfZ0aeAO7amwEqPKNLFCoCLMSYbGXt4aFgay7SNj3cVsI3wfiLcyNqe5hKgm6zN4SaZTmW9zzu9/r1EzB1RGhlGIQM3F2VoSXn8DM5HqTiKO/yP9Tnp8qEwmQQ8=';
  String reference = 'reference';
  String transactionid = 'refid';
  String template = 'modern';
  String currency = 'ngn';
  String comment = 'L-evrl - Fitness Subscription';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/payment': (BuildContext context) => PaymentMethodsWidget(
              amount: amount,
              email: email,
              storeid: storeid,
              reference: reference,
              transactionid: transactionid,
              template: template,
              currency: currency,
              comment: comment,
              themeColor: Color(0xFF003F5F),
            )
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Credit Card View Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('TestProject'),
            ),
            body: Center(
                child: FlatButton(
                    child: const Text('Make Payment'),
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/payment')))));
  }
}
