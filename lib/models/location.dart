import 'package:location/location.dart';

class LocationHelper{
  late double latitute;
  late double longitude;


  //Konum bilgisini veren method
  Future<void> getCurrentLocation() async{
    Location location = Location();

    //Servis Ayakta mı
    bool _serviceEnabled;

    //Kullanıcı izin vermiş mi
    PermissionStatus _permissionGranted;

    //Lokasyon bilgileri alındı mı
    LocationData _locationData;


    //Lokasyon için servis ayakta mı?
    _serviceEnabled = await location.serviceEnabled();

    if(!_serviceEnabled){
      //Servis ayakta değil ise servise istek atanır
      _serviceEnabled = await location.requestService();

      if(!_serviceEnabled){
        return null;
      }
    }

    //Kullanıcıdan izin alınmış mı
    _permissionGranted = await location.hasPermission();

    //izin verilmemişse
    if(_permissionGranted == PermissionStatus.denied){
      //Tekrar izin için istek atanır
      _permissionGranted = await location.requestPermission();

      //İzin verilmemişse
      if(_permissionGranted != PermissionStatus.granted){
        return null;
      }
    }

    //İzin alınıp servis ayakta ise
    _locationData = await location.getLocation();
    latitute = _locationData.latitude!;
    longitude = _locationData.longitude!;

  }
}