import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './bank_widget_home.dart';
import './card_widget_home.dart';
import './api.dart';

class PaymentMethodsWidget extends StatefulWidget {
  const PaymentMethodsWidget({
    Key key,
    @required this.amount,
    @required this.email,
    @required this.storeid,
    @required this.reference,
    @required this.transactionid,
    @required this.template,
    @required this.currency,
    @required this.comment,
    @required this.themeColor,
    // @required this.callback,
    // @required this.close,
  })  : assert(amount != null),
        assert(email != null),
        assert(storeid != null),
        assert(template != null),
        super(key: key);

  final int amount;
  final String email;
  final String storeid;
  final String reference;
  final String transactionid;
  final String template;
  final String currency;
  final String comment;
  final Color themeColor;
  // final void Function(CreditCardModel) onCreditCardModelChange;
  @override
  _PaymentMethodsWidgetState createState() => _PaymentMethodsWidgetState();
}

class _PaymentMethodsWidgetState extends State<PaymentMethodsWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _loadData = 'false';
    _authtenticatePayment();
    final dynamic controller = MoneyMaskedTextController(
        decimalSeparator: '.', thousandSeparator: ',');
    controller.updateValue(widget.amount + 0.0);
    _amount = controller.text;
  }

  void _dataLoaded(dynamic payload) {
    setState(() {
      _loadData = payload;
    });
  }

  Future<dynamic> _authtenticatePayment() async {
    final dynamic payload = {
      'sh_amount': widget.amount,
      'sh_email': widget.email,
      'sh_storeid': widget.storeid,
      'sh_reference': widget.reference,
      'sh_transactionid': widget.transactionid,
      'sh_template': widget.template,
      'sh_currency': widget.currency,
      'sh_comment': widget.comment
    };
    final dynamic result = await _authenticationService.authenticate(payload);
    if (result['status'] == 1) {
      _dataLoaded(result.toString());
    } else {
      _dataLoaded('error');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String amount;
  String email;
  String storeid;
  String reference;
  String transactionid;
  String currency;
  String _loadData;
  String _amount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.red),
              onPressed: () => Navigator.of(context).pop(),
            )),
        body: Container(color: Colors.white, child: _buildPaymentMethods()));
  }

  Widget _buildPaymentMethods() {
    if (_loadData == 'false') {
      return Center(
          child: Image.asset(
        'icons/loader.gif',
        width: 150,
        package: 'flutter_shockinflux',
      ));
    } else if (_loadData == 'error') {
      return Center(
          child: OutlineButton(
        onPressed: () {
          _authtenticatePayment();
        },
        color: Colors.white,
        textColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        borderSide: BorderSide(
          color: Colors.red, //Color of the border
          style: BorderStyle.solid, //Style of the border
          width: 0.8, //width of the border
        ),
        child: Text('Try again',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: widget.themeColor)),
      ));
    } else {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(55.0), // here the desired height
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    "You are paying",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.black38),
                  ),
                ),
                Container(
                  // Another fixed-height child.
                  child: Text(
                    widget.currency.toUpperCase() + ' ' + _amount,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            )
            // ...
            ),
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0), // here the desired height
              child: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  bottom: TabBar(
                    unselectedLabelColor: Colors.black38,
                    labelColor: widget.themeColor,
                    indicatorColor: widget.themeColor,
                    tabs: [
                      Tab(
                          child: Text('CARD',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              )),
                          icon: Icon(Icons.credit_card)),
                      Tab(
                          child: Text('BANK',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15)),
                          icon: Icon(Icons.account_balance)),
                      Tab(
                          child: Text('MYNE',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15)),
                          icon: Icon(Icons.account_balance_wallet)),
                    ],
                  )),
            ),
            body: Center(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  CardMethodsWidget(themeColor: widget.themeColor),
                  BankMethodsWidget(themeColor: widget.themeColor),
                  Icon(Icons.directions_bike),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

class MoneyMaskedTextController extends TextEditingController {
  MoneyMaskedTextController(
      {double initialValue = 0.0,
      this.decimalSeparator = ',',
      this.thousandSeparator = '.',
      this.rightSymbol = '',
      this.leftSymbol = '',
      this.precision = 2}) {
    _validateConfig();

    this.addListener(() {
      this.updateValue(this.numberValue);
      this.afterChange(this.text, this.numberValue);
    });

    this.updateValue(initialValue);
  }

  final String decimalSeparator;
  final String thousandSeparator;
  final String rightSymbol;
  final String leftSymbol;
  final int precision;

  Function afterChange = (String maskedValue, double rawValue) {};

  double _lastValue = 0.0;

  void updateValue(double value) {
    double valueToUse = value;

    if (value.toStringAsFixed(0).length > 12) {
      valueToUse = _lastValue;
    } else {
      _lastValue = value;
    }

    String masked = this._applyMask(valueToUse);

    if (rightSymbol.length > 0) {
      masked += rightSymbol;
    }

    if (leftSymbol.length > 0) {
      masked = leftSymbol + masked;
    }

    if (masked != this.text) {
      this.text = masked;

      var cursorPosition = super.text.length - this.rightSymbol.length;
      this.selection = new TextSelection.fromPosition(
          new TextPosition(offset: cursorPosition));
    }
  }

  double get numberValue {
    List<String> parts =
        _getOnlyNumbers(this.text).split('').toList(growable: true);

    parts.insert(parts.length - precision, '.');

    return double.parse(parts.join());
  }

  dynamic _validateConfig() {
    bool rightSymbolHasNumbers = _getOnlyNumbers(this.rightSymbol).length > 0;

    if (rightSymbolHasNumbers) {
      throw new ArgumentError("rightSymbol must not have numbers.");
    }
  }

  String _getOnlyNumbers(String text) {
    String cleanedText = text;

    var onlyNumbersRegex = new RegExp(r'[^\d]');

    cleanedText = cleanedText.replaceAll(onlyNumbersRegex, '');

    return cleanedText;
  }

  String _applyMask(double value) {
    List<String> textRepresentation = value
        .toStringAsFixed(precision)
        .replaceAll('.', '')
        .split('')
        .reversed
        .toList(growable: true);

    textRepresentation.insert(precision, decimalSeparator);

    for (var i = precision + 4; true; i = i + 4) {
      if (textRepresentation.length > i) {
        textRepresentation.insert(i, thousandSeparator);
      } else {
        break;
      }
    }

    return textRepresentation.reversed.join('');
  }
}
