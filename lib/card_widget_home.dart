import 'package:flutter/material.dart';
import 'package:flutter_shockinflux/credit_card_payment.dart';
import 'package:flutter_shockinflux/credit_card_form.dart';
import 'package:flutter_shockinflux/credit_card_model.dart';

class CardMethodsWidget extends StatefulWidget {
  const CardMethodsWidget({
    Key key,
    @required this.themeColor,
    // @required this.callback,
    // @required this.close,
  })  : assert(themeColor != null),
        super(key: key);

  final Color themeColor;
  @override
  _CardMethodsWidgetState createState() => _CardMethodsWidgetState();
}

class _CardMethodsWidgetState extends State<CardMethodsWidget> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool isSwitched = false;

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
                    "Enter your card details to pay",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black26),
                  )),
              Container(
                  margin: const EdgeInsets.only(left: 6, top: 10, right: 6),
                  child: CreditCardWidget(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused,
                    isSwitched: isSwitched,
                    height: 170,
                  )),
              Container(
                // padding: const EdgeInsets.symmetric(vertical: 8.0),
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: SingleChildScrollView(
                  child: CreditCardForm(
                    themeColor: widget.themeColor,
                    onCreditCardModelChange: onCreditCardModelChange,
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

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isSwitched = creditCardModel.isSwitched;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
