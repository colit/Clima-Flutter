import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';

import 'package:http/http.dart' as http;
import 'package:clima/utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
  }

  void getData() async {
    //String query_sample = 'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22';
    String query = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$kOpenWeatherAPIKey';

    http.Response response = await http.get(query);
    int statusCode = response.statusCode;

    if (statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);
      var condition = decodedData['weather'][0]['main'];
      var cityName = decodedData['name'];
      var temperature = decodedData['main']['temp'];

      print(cityName);
      print(condition);
      print(temperature);

    } else {
      print('Respoce code: $statusCode');
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
