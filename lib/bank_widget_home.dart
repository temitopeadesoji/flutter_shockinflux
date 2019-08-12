import 'package:flutter/material.dart';
import 'package:flutter_shockinflux/bank_form.dart';
import 'package:flutter_shockinflux/bank_model.dart';

class BankMethodsWidget extends StatefulWidget {
  const BankMethodsWidget({Key key, @required this.themeColor})
      : assert(themeColor != null),
        super(key: key);

  final Color themeColor;
  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<BankMethodsWidget> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Column(children: [
              Container(
                  margin: const EdgeInsets.only(left: 6, top: 28, right: 6),
                  child: Text(
                    "Choose your bank to start the payment",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black26),
                  )),
              Container(
                // padding: const EdgeInsets.symmetric(vertical: 8.0),
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: SingleChildScrollView(
                  child: BankForm(
                    themeColor: widget.themeColor,
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 28, bottom: 28),
                  padding: const EdgeInsets.only(bottom: 6, top: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFF003F5F),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  width: 180,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.lock, size: 12, color: Colors.white),
                        Text(
                          'SECURED BY SHOCKINFLUX',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white),
                        )
                      ])),
            ]),
          ),
        );
      },
    );
  }

  void onCreditCardModelChange(BankModel bankModel) {
    setState(() {
      cardNumber = bankModel.cardNumber;
      expiryDate = bankModel.expiryDate;
      cardHolderName = bankModel.cardHolderName;
      cvvCode = bankModel.cvvCode;
    });
  }
}
