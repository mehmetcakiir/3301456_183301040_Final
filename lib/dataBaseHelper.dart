import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper{
  static final databaseName = "otomasyon.sqlite";

  static Future<Database> connection() async{

    //veri tabanı dosya yolu kontrol edilir(kopyalanmış mı)
    String databasePath = join(await getDatabasesPath(),databaseName);

    //veri tabanı bu yolda var mı
    if(await databaseExists(databasePath)){
      print("Veri tabanı daha öncesinde kopyalanmış");
    }else{
      //Data bayt formatına dönüştürülür
      ByteData data = await rootBundle.load("database/$databaseName");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);

      //Yazdırma işlemi(Rolback yapma)
      await File(databasePath).writeAsBytes(bytes,flush:true);
      print("Veri tabanı kopyalandı");
    }
    return openDatabase(databasePath);
  }
}
