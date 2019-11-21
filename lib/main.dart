import 'package:flutter/material.dart';
import 'package:flutter_coding_challenge/api/Zomato.dart';
import 'package:flutter_coding_challenge/views/random/RandomPage.dart';

void main() async {
//  final api = new Zomato();
//  final loc = await api.getRestaurants(89, 3);
//  print(loc.found);
//  print(loc.restaurants);
  runApp(SuburbanSpoon());
}

class SuburbanSpoon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Random Pick restaunrant'),
        ),
        body: SafeArea(
          child: RandomPage()

        )
      ),
    );
  }
}

