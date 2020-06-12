import 'package:flutter/material.dart';
import './../services/networking.dart';

class CoinApi{
    String currency;

    List coin;

    CoinApi({ @required this.currency, @required this.coin });

    Future<Map> getRates() async{
        const String url = 'http://api.coinlayer.com/api/live';

        const String accessKey = 'd1479f1fdec99685dc118fa7991a970a';

        NetworkService networkService = NetworkService(url: '$url?access_key=$accessKey&target=$currency&symbols=${coin.join(',')}');

        var data =  await networkService.getData();

//        print(data['rates']);

        Map rates = data['rates'];

        return rates;
    }
}