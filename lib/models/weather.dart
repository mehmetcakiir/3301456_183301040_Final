import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

import 'location.dart';

const apiKey = "284a81a07c8fdf83d26a6cc442c63c73";


//Görüntülenecek verileri tutar
class WeatherDisplayData{
  late Icon weatherIcon;
  late AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData{
  WeatherData({required this.locationData});

  //Lokasyon bilgilerini kullanabilmesi için
  LocationHelper? locationData;

  //Anlık sıcaklık
  double? currentTemperature;

  //Anlık Durum
  int? currentCondition;
  String? city;



  Future<void> getCurrentTemperature() async{

    var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=37.875496498&lon=32.488664712&appid=284a81a07c8fdf83d26a6cc442c63c73&units=metric');
    Response response = await get(url);

    //Api den değer dönüyo ise
    if(response.statusCode == 200){
      String data = response.body;

      var currentWeather = jsonDecode(data);

      try{
        //sıcaklık alınır
        currentTemperature = currentWeather['main']['temp'];
        print(currentTemperature);

        //Durum
        currentCondition = currentWeather['weather'][0]['id'];
        print(currentCondition);

        //Şehir
        city = currentWeather['name'];

      }catch(e){
        print(e);
      }
    }
    else{
      print("API den değer gelmiyor");
    }
  }


  WeatherDisplayData? getWeatherDisplayData(){
    //Bulutlu
    if(currentCondition! < 600){
      return WeatherDisplayData(weatherIcon: Icon(
        FontAwesomeIcons.cloud,
        size: 75.0,
        color: Colors.white,
      ),
        weatherImage: AssetImage('assets/images/hava_durumu.jpg'),
      );
    }
    else{
      var now = DateTime.now();
      print(now);
      //sabah
      if(now.hour >= 19){
        return WeatherDisplayData(weatherIcon: Icon(
          FontAwesomeIcons.moon,
          size: 75.0,
          color: Colors.white,
        ),
          weatherImage: AssetImage('assets/images/gece.jpg'),
        );
      }
      else{
        return WeatherDisplayData(weatherIcon: Icon(
          FontAwesomeIcons.sun,
          size: 75.0,
          color: Colors.white,
        ),
          weatherImage: AssetImage('assets/images/gunesli.jpg'),
        );
      }
    }
  }
}