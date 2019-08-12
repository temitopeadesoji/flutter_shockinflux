# Flutter Credit Card

A Flutter package for shockinflux payment gateway.

## Preview

![The example app running in Android](https://github.com/temitopeadesoji/flutter_shockinflux/blob/master/preview/preview.gif)

## Installing

1.  Add dependency to `pubspec.yaml`

    _Get the latest version in the 'Installing' tab on pub.dartlang.org_

```dart
dependencies:
    flutter_shockinflux: 0.0.1
```

2.  Import the package

```dart
import 'package:flutter_shockinflux/flutter_shockinflux.dart';
```

3.  Adding CreditCardWidget

_With required parameters_

```dart

    CreditCardWidget(
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cardHolderName: cardHolderName,
        cvvCode: cvvCode,
        showBackView: isCvvFocused, //true when you want to show cvv(back) view
    ),
```

_With optional parameters_

```dart
    CreditCardWidget(
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cardHolderName: cardHolderName,
        cvvCode: cvvCode,
        showBackView: isCvvFocused,
        cardbgColor: Colors.black,
        height: 175,
        textStyle: TextStyle(color: Colors.yellowAccent),
        width: MediaQuery.of(context).size.width,
        animationDuration: Duration(milliseconds: 1000),
        ),
```

3.  Adding CreditCardForm

```dart
    CreditCardForm(
      themeColor: Colors.red,
      onCreditCardModelChange: (CreditCardModel data) {},
    ),
```

## How to use

Check out the **example** app in the [example](example) directory or the 'Example' tab on pub.dartlang.org for a more complete example.

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Credit
