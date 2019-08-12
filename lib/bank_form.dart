import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shockinflux/card_shockinflux.dart';

import 'credit_card_model.dart';

class BankForm extends StatefulWidget {
  const BankForm({
    Key key,
    this.cardNumber,
    this.expiryDate,
    this.cardHolderName,
    this.cvvCode,
    this.isSwitched,
    this.onCreditCardModelChange,
    this.themeColor = Colors.blue,
    this.textColor = Colors.black,
    this.cursorColor,
  }) : super(key: key);

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final String isSwitched;
  final void Function(CreditCardModel) onCreditCardModelChange;
  final Color themeColor;
  final Color textColor;
  final Color cursorColor;

  @override
  _BankFormState createState() => _BankFormState();
}

class _BankFormState extends State<BankForm> {
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  bool isCvvFocused = false;
  bool isSwitched = true;

  void Function(CreditCardModel) onCreditCardModelChange;
  CreditCardModel creditCardModel;

  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '0000');

  FocusNode cvvFocusNode = FocusNode();

  void textFieldFocusDidChange() {
    creditCardModel.isCvvFocused = cvvFocusNode.hasFocus;
    onCreditCardModelChange(creditCardModel);
  }

  void createBankModel() {
    cardNumber = widget.cardNumber ?? '';
    expiryDate = widget.expiryDate ?? '';
    cardHolderName = widget.cardHolderName ?? '';
    cvvCode = widget.cvvCode ?? '';
    cvvCode = widget.isSwitched ?? '';

    creditCardModel = CreditCardModel(cardNumber, expiryDate, cardHolderName,
        cvvCode, isCvvFocused, isSwitched);
  }

  @override
  void initState() {
    super.initState();

    createBankModel();

    _cardNumberController.addListener(() {
      setState(() {
        cardNumber = _cardNumberController.text;
        creditCardModel.cardNumber = cardNumber;
      });
    });

    _expiryDateController.addListener(() {
      setState(() {
        expiryDate = _expiryDateController.text;
        creditCardModel.expiryDate = expiryDate;
      });
    });

    _cardHolderNameController.addListener(() {
      setState(() {
        cardHolderName = _cardHolderNameController.text;
        creditCardModel.cardHolderName = cardHolderName;
      });
    });

    _cvvCodeController.addListener(() {
      setState(() {
        cvvCode = _cvvCodeController.text;
        creditCardModel.cvvCode = cvvCode;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: widget.themeColor.withOpacity(0.8),
        primaryColorDark: widget.themeColor,
      ),
      child: Form(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: TextFormField(
                controller: _cardNumberController,
                cursorColor: widget.cursorColor ?? widget.themeColor,
                style: TextStyle(
                  color: widget.textColor,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Card number',
                  hintText: 'xxxx xxxx xxxx xxxx',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
                    child: TextFormField(
                      controller: _expiryDateController,
                      cursorColor: widget.cursorColor ?? widget.themeColor,
                      style: TextStyle(
                        color: widget.textColor,
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Expired Date',
                          hintText: 'MM/YY'),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
                    child: TextField(
                      focusNode: cvvFocusNode,
                      controller: _cvvCodeController,
                      cursorColor: widget.cursorColor ?? widget.themeColor,
                      style: TextStyle(
                        color: widget.textColor,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CVV',
                        hintText: 'XXXX',
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      onChanged: (String text) {
                        setState(() {
                          cvvCode = text;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
            Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
                child: MaterialButton(
                  onPressed: () {},
                  minWidth: double.infinity,
                  height: 50,
                  color: widget.themeColor,
                  textColor: Colors.white,
                  child: Text('Pay Now',
                      style: new TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 30)),
                ))
          ],
        ),
      ),
    );
  }
}
