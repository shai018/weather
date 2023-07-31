import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
}

Future<Weatherinfo> fetchWeather() async{
  final ZipCodec = "600126";
  final apikey = "b68d0f5586304d1e3c2889427a24647e";
  final requestUrl ="https://api.openweathermap.org/data/2.5/weather?zip=600126,in&unit=metric&appid=b68d0f5586304d1e3c2889427a24647e";
  final response = await http.get(Uri.parse(requestUrl));
  
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
        temp: json['main']['temp'],
        tempMin: json['main']['tempMin'],
        tempMax: json['main']['tempmax'],
        weather: json['main'][0]['description'],
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
    super.initState();
    futureWeather = fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Weatherinfo>(
        future: futureWeather,
        builder:(context,snapshot){
          if(snapshot.hasData){
            return widget(
              location: snapshot.data?.location,
              temp: snapshot.data?.temp,
              tempMin: snapshot.data?.tempMin,
              tempMax: snapshot.data?.tempMax,
              weather: snapshot.data?.weather,
              humidity: snapshot.data?.humidity,
              windSpeed: snapshot.data?.windSpeed,
            );
          }
          else {
            if(snapshot.hasError){
             return Center(
               child: Text("$snapshot.error"),
             );
          }
          }
          return Container();
        }

      ),
      appBar: AppBar(
        title: const Text('Weather App'),
      ),

      );

  }
}

