import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled5/models/weather.dart';

class MainScreen extends StatefulWidget {

  final WeatherData weatherData;

  MainScreen({required this.weatherData});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage backroundImage;
  late String city;

  //Değerleri getirecek method

  void updateDisplayInfo(WeatherData weatherData){
    //veriler anlık olarak güncellenmesi için
    setState(() {
      temperature = weatherData.currentTemperature!.round();
      WeatherDisplayData? weatherDisplayData = weatherData.getWeatherDisplayData();
      backroundImage = weatherDisplayData!.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
      city = weatherData.city!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //Resimi Ekrana göre ayarlar
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backroundImage,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30.0,),
            Container(
                child: weatherDisplayIcon
            ),
            SizedBox(height: 30.0,),
            Center(
              child: Text(
                '$temperature°',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 80.0,
                    letterSpacing: -5
                ),
              ),
            ),
            SizedBox(height: 30.0,),
            Center(
              child: Text(
                '$city',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    letterSpacing: -5
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}