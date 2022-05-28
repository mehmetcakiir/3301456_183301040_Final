
import 'package:untitled5/DataContract/Faculties.dart';
import 'package:untitled5/DataContract/Statistisc.dart';
import 'package:untitled5/DataContract/Students.dart';
import 'package:untitled5/dataBaseHelper.dart';

class Studentsdao{

  //Select
  Future<List<Students>> allStudents(int facultyId) async{
    print("Methoda girdi");

    //veri tabanına erişim sağlanır
    var db = await DataBaseHelper.connection();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM students,faculty WHERE students.facultyId = faculty.facultyId AND students.facultyId = $facultyId");

    return List.generate(maps.length, (i) {
      var row = maps[i];

      var f = Faculties(row['facultyId'], row['facultyName']);
      var s = Students(row['studentNo'], row['studentFirstName'], row['studentLastName'], row['mail'], f);

      return s;
    });
  }

  //Arama
  Future<List<Students>> callStudents(String wanted, int facultyId) async{
    print("arama yapıldı: $wanted");

    //veri tabanına erişim sağlanır
    var db = await DataBaseHelper.connection();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM students,faculty WHERE students.facultyId = faculty.facultyId AND students.facultyId = $facultyId AND students.studentNo like '%$wanted%'");

    //"SELECT * FROM students WHERE students.studentNo like '%$wanted%'"
    //"SELECT * FROM students,faculty WHERE students.facultyId = faculty.facultyId AND students.studentNo like '%$wanted%'"

    return List.generate(maps.length, (i) {
      var row = maps[i];

      var f = Faculties(row['facultyId'], row['facultyName']);
      var s = Students(row['studentNo'], row['studentFirstName'], row['studentLastName'], row['mail'], f);

      return s;
    });
  }

  //Kaydetme
  Future<void> addStudents(String studentFirstName,String studentLastName, String studentNo, String mail, int facultyId) async{

    //veri tabanına erişim sağlanır
    var db = await DataBaseHelper.connection();

    var info = Map<String,dynamic>();

    info["studentFirstName"] = studentFirstName;
    info["studentLastName"] = studentLastName;
    info["studentNo"] = studentNo;
    info["mail"] = mail;
    info["facultyId"] = facultyId;

    await db.insert("students", info);

  }

  Future<void> updateStudents(String studentFirstName,String studentLastName, String studentNo, String mail, int facultyId) async{

    //veri tabanına erişim sağlanır
    var db = await DataBaseHelper.connection();

    var info = Map<String,dynamic>();

    info["studentFirstName"] = studentFirstName;
    info["studentLastName"] = studentLastName;
    info["mail"] = mail;
    info["facultyId"] = facultyId;

    await db.update("students", info, where: "studentNo=?", whereArgs: [studentNo]);
  }

  Future<void> deleteStudents(String studentNo) async{

    //veri tabanına erişim sağlanır
    var db = await DataBaseHelper.connection();

    var info = Map<String,dynamic>();

    await db.delete("students", where: "studentNo=?", whereArgs: [studentNo]);
  }

  Future<List<Statistisc>> studentCount() async{
    print("Methoda girdi");

    //veri tabanına erişim sağlanır
    var db = await DataBaseHelper.connection();

    //List<Map<String, dynamic>> maps = await db.rawQuery("SELECT facultyId , COUNT(facultyId) as countStudent FROM students GROUP BY facultyId");
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT facultyId , COUNT(facultyId) as countStudent FROM students GROUP BY facultyId");

    return List.generate(maps.length, (i) {
      var row = maps[i];

      var e = Statistisc(row['facultyId'], row['countStudent']);

      return e;
    });
  }

}

