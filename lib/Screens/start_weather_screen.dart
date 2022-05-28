import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled5/Screens/main_weather_screen.dart';
import 'package:untitled5/models/location.dart';
import 'package:untitled5/models/weather.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  //Location classından nesne üretildi
  late LocationHelper locationData;

  //konum bilgilerini verir
  Future<void> getLocationData() async{
    locationData = LocationHelper();
    await locationData.getCurrentLocation();


    //Konum bilgileri alındı mı
    if(locationData.latitute == null ||
        locationData.longitude == null){
      print('Konum bilgileri alınamadı');
    }
    else{
      print(locationData.latitute.toString());
      print(locationData.longitude.toString());
    }
  }

  //Hava durumu bilgilerini Api den verir
  void getWeatherData() async{
    //Locatin isteği tetiklenir
    await getLocationData();

    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();
    //Apinin methodu

    if(weatherData.currentCondition == null && weatherData.currentTemperature == null){
      print("Api sıcaklık ve durum değerleri alınamadı");
    }

    //Değerler geliyorsa diğer sayfaya geç
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return MainScreen(weatherData: weatherData,);
    }));
  }



  //Başlangıçta çağrılacak komutlar
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          //Arka Plan rgeçişli rengi
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple,Colors.blue]
            )
        ),
        child: Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            //Büyüklük
            size: 150.0,
            //Süre
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}