import 'package:untitled5/DataContract/Faculties.dart';
import 'package:untitled5/dataBaseHelper.dart';

class Facultiesdao{
  Future<List<Faculties>> allFaculties() async{

    //veri tabanına erişim sağlanır
    var db = await DataBaseHelper.connection();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM faculty");

    return List.generate(maps.length, (i) {
      var row = maps[i];

      return Faculties(row["facultyId"],row["facultyName"]);
    });
  }
}