import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_1/GetLocation.dart';
import 'package:weather_1/widget/weathertile.dart';
import 'dart:async';
import 'dart:convert';
import 'widget/widget.dart';

void main() {

  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Weather App",
        home: MyApp(),
      ),
  );
  getlocation();
}

Future<Weatherinfo> fetchWeather() async {

  final apikey = "b68d0f5586304d1e3c2889427a24647e";
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // log(position.longitude.toString());
  // log(position.latitude.toString());
  // final requestUrlTest ="https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&unit=metric&appid=b68d0f5586304d1e3c2889427a24647e";
  // final responseTest = await http.get(Uri.parse(requestUrlTest));
  // log("Test");
  // log(responseTest.body);
  // log("Tested");
  // final requestUrl ="https://api.openweathermap.org/data/2.5/weather?zip=600126,in&unit=metric&appid=b68d0f5586304d1e3c2889427a24647e";
  final requestUrl ="https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&unit=metric&appid=b68d0f5586304d1e3c2889427a24647e";
  final response = await http.get(Uri.parse(requestUrl));
  log(response.body);
  if(response.statusCode==200)
  {
    return Weatherinfo.fromJSON(jsonDecode(response.body));
  }
  else
  {
    throw Exception("Error loading request");
  }
}

class Weatherinfo{
  final location;
  final temp;
  final tempMax;
  final tempMin;
  final weather;
  final humidity;
  final windSpeed;

  Weatherinfo(
  {
    required this.location,
    required this.temp,
    required this.tempMax,
    required this.tempMin,
    required this.humidity,
    required this.windSpeed,
    required this.weather
   }
  );

  factory Weatherinfo.fromJSON(Map<String,dynamic>json){
    return Weatherinfo(
        location: json['name'],
        temp: json['main']['temp'] - 273.15 ,
        tempMin: json['main']['temp_min']-273.15,
        tempMax: json['main']['temp_max']-273.15,
        weather: json['weather'][0]['description'],
        humidity: json['main']['humidity'],
        windSpeed: json['wind']['speed']
    );
  }

}




class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Weatherinfo> futureWeather;
  @override
  void initState(){
    futureWeather = call();
    super.initState();

  }
  Future<Weatherinfo> call() async{
    return await fetchWeather();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder(
        future: futureWeather,
        builder:(BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return widget(
              location: snapshot.data.location,
              temp: snapshot.data.temp,
              tempMin: snapshot.data.tempMin,
              tempMax: snapshot.data.tempMax,
              weather: snapshot.data.weather,
              humidity: snapshot.data.humidity,
              windSpeed: snapshot.data.windSpeed,
            );
          }
          else {
            if(snapshot.hasError){
             return Center(
               child: Text("error"),
             );
          }
          }
          return Container();
        }

      ),

      // body: Container(
      );

  }
}

