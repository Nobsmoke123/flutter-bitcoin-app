import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './coin_data.dart';
import 'dart:io' show Platform;

import './services/coin_api.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'USD';

  Map crypto = {
    'BTC' : '?',
    'ETH' : '?',
    'LTC' : '?'
  };

  void getRates() async{
    CoinApi coinApi = CoinApi(currency: selectedCurrency, coin: ['BTC','ETH','LTC']);
    Map rates = await coinApi.getRates();

    double btc = rates['BTC'];
    double eth = rates['ETH'];
    double ltc = rates['LTC'];

    setState(() {
      crypto['BTC'] = btc.toStringAsFixed(0);
      crypto['ETH'] = eth.toStringAsFixed(0);
      crypto['LTC'] = ltc.toStringAsFixed(0);
    });
  }

  Widget androidDropDown(){
    return DropdownButton<String>(
      onChanged: (value){
        setState(() {
          selectedCurrency = value;
        });
        getRates();
      },
      items: currenciesList
          .map((e) => DropdownMenuItem(
        child: Text(e.toString()),
        value: e.toString(),
      )).toList(),
      value: selectedCurrency,
    );
  }

  Widget iOSPicker () {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlueAccent,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex){
        selectedCurrency = currenciesList[selectedIndex];
      },
      children: currenciesList.map((e) => Text(e.toString())).toList(),
    );
  }

  List<Widget> generateCoins() {
    return cryptoList.map((e) => Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $e = ${crypto[e]} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ) ).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRates();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: generateCoins(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropDown() ,
          ),
        ],
      ),
    );
  }
}
