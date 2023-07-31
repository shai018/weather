// this file is for displaying the data
import 'package:flutter/material.dart';
import 'weathertile.dart';

class widget extends StatelessWidget {
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  widget(
      {required this.location,
      required this.temp,
      required this.tempMax,
      required this.tempMin,
      required this.humidity,
      required this.windSpeed,
      required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.blueGrey,
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${location.toString()}",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "${temp.toInt()}°C",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 40.0,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                Text(
                  "High of ${tempMax.toInt().toString()}°C of ${tempMin.toInt().toString()}°C",
                  style: TextStyle(
                    color: Color(0xff9e9e9e),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ) ,
          ),
          Expanded(child: Padding(padding:EdgeInsets.all(12) ,
            child: ListView(children: [
              weathertile(icon: Icons.thermostat_auto_outlined,
                  title: "Temperature",
                  subtitle: "${temp.toInt().toString()}°C "),
              weathertile(icon: Icons.filter_drama_outlined,
                  title: "weather",
                  subtitle: "${temp.toInt().toString()}",),
              weathertile(icon: Icons.wb_sunny,
                  title: "Humidity",
                  subtitle: "${humidity.toString()}%"),
              weathertile(icon: Icons.waves_outlined,
                  title: "wind speed",
                  subtitle: "${windSpeed.toInt().toString()}°C "),
            ],),
          ))
        ],
      ),
    );
  }
}
