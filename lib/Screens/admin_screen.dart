import 'package:flutter/material.dart';
import 'package:untitled5/DataContract/Statistisc.dart';
import 'package:untitled5/Screens/faculties_screen.dart';
import 'package:untitled5/Screens/notebook_screen.dart';
import 'package:untitled5/Screens/statistics.dart';
import 'package:untitled5/Screens/student_add.dart';
import 'package:untitled5/Screens/student_edit.dart';
import 'package:untitled5/Screens/student_faculty_photo.dart';
import 'package:untitled5/Studentsdao.dart';
import 'package:untitled5/models/student.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

var students = [
  Student.withid(1, "Mehmet", "Çakır", 50),
  Student.withid(2, "Ali", "Demir", 80),
  Student.withid(3, "Hakan", "Çalışkan", 10)
];

Student selectedStudent = new Student.withid(0, "", "", 0);

int? sayi;

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {

  late int computer = 0;
  late int machine = 0;
  late int electricity = 0;
  late int material = 0;


  Future<void> studentCount() async {
    List<Statistisc> studentCount = await Studentsdao().studentCount();

    for(Statistisc s in studentCount){
      if(s.facultyId == 1){
        computer = s.countStudent;
        print(s.countStudent);
      }
      if(s.facultyId == 2){
        machine = s.countStudent;
        print(s.countStudent);
      }
      if(s.facultyId == 3){
        electricity = s.countStudent;
        print(s.countStudent);
      }
      if(s.facultyId == 4){
        material = s.countStudent;
        print(s.countStudent);
      }
    }
  }

  void initState() {
    super.initState();
    studentCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Öğrenci Listesi"),
        ),
        body: buildBody(context));
  }

  void messageShow(BuildContext context, String message) {
    var alert = AlertDialog(
      title: Text("İşlem Durumu"),
      content: Text(message),
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: buildAvatar(students[index].fitstName),
                    title: Text(students[index].fitstName +
                        " " +
                        students[index].lastName),
                    subtitle: Text("Sınavdan aldığı not :" +
                        students[index].point.toString() +
                        " [" +
                        students[index].getStatus +
                        "]"),
                    trailing: buildIcon(students[index].point),
                    onTap: () {
                      setState(() {
                        selectedStudent = students[index];
                      });
                    },
                  );
                })
        ),
        Text("Seçilen Öğrenci : " + selectedStudent.fitstName + " " + selectedStudent.lastName, style: TextStyle(),),
        Row(
          children: [
            SizedBox(width: 5.0,),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color: Colors.green,
                child: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 5.0,),
                    Text("Yeni Öğrenci")
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StudentAdd()));
                },
              ),
            ),

            SizedBox(width: 5.0,),

            SizedBox(width: 5.0,),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color: Colors.amberAccent,
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 5.0,),
                    Text("Sil")
                  ],
                ),
                onPressed: () {
                  if((selectedStudent.fitstName == "A")){
                    setState(() {
                      students.remove(selectedStudent);
                    });
                    var messaj = selectedStudent.fitstName + " " + selectedStudent.lastName + " " + " Kayıt Silindi !" ;
                    messageShow(context, messaj);
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Silinecek Kaydı Seçiniz'),),
                    );
                  }
                },
              ),
            ),
            SizedBox(width: 5.0,)
          ],
        ),
        Row(

          children: [
            SizedBox(width: 5.0,),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color: Colors.red,
                child: Row(
                  children: [
                    Icon(Icons.update),
                    SizedBox(width: 5.0,),
                    Text("Güncelle")
                  ],
                ),
                onPressed: () {
                  if(!(selectedStudent.point == 0)){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StudentEdit(selectedStudent)));
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Güncellenicek Kaydı Seçiniz'),),
                    );
                  }
                },
              ),
            ),
            SizedBox(width: 5.0,),

            SizedBox(width: 5.0,),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color: Colors.pink,
                child: Row(
                  children: [
                    Icon(Icons.stacked_line_chart_sharp),
                    SizedBox(width: 5.0,),
                    Text("İstatistlikler")
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Statistics(computer: computer, electricity: electricity, machine: machine, material: material)));
                  //computer: computer, electricity: electricity, machine: machine, material: material,
                  print(this.computer);print("bilgisayar");
                  print(this.machine);print("makine");
                  print(this.electricity);print("elektrik");
                  print(this.material);print("malzeme");
                },
              ),
            ),
            SizedBox(width: 5.0,)
          ],
        ),
        Row(

          children: [
            SizedBox(width: 5.0,),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color: Colors.lightBlueAccent,
                child: Row(
                  children: [
                    Icon(Icons.mail),
                    SizedBox(width: 5.0,),
                    Text("Öğrenci İletişim")
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FacultiesScreen()));
                },
              ),
            ),
            SizedBox(width: 5.0,),

            SizedBox(width: 5.0,),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color: Colors.white,
                child: Row(
                  children: [
                    Icon(Icons.note_add_outlined),
                    SizedBox(width: 5.0,),
                    Text("Not Defterim")
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NoteBook()));
                },
              ),
            ),

            SizedBox(width: 5.0,)
          ],
        ),
        SizedBox(width: 5.0,),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color: Colors.black12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.note_add_outlined),
                    SizedBox(width: 5.0,),
                    Text("Öğrenci Detay"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FacultyPhotoScreen()));
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0,),
      ],
    );
  }

  Widget buildIcon(int point) {
    if (point < 50) {
      return Icon(Icons.clear);
    }
    if (point == 50) {
      return Icon(Icons.access_alarm);
    } else {
      return Icon(Icons.done);
    }
  }

  buildAvatar(String fitstName) {
    if (fitstName == "Mehmet") {
      return CircleAvatar(
        backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/tr/6/6c/Yahya_Demirel_foto%C4%9Fraf%C4%B1.jpg"),

      );
    }
    if (fitstName == "Hakan") {
      return CircleAvatar(
        backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/tr/6/6c/Yahya_Demirel_foto%C4%9Fraf%C4%B1.jpg"),

      );
    }
    if (fitstName == "Ali") {
      return CircleAvatar(
        backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/tr/d/db/Hrant_Dink_foto%C4%9Fraf%C4%B1.jpg"),
      );
    } else {
      return CircleAvatar(
        backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/tr/d/db/Hrant_Dink_foto%C4%9Fraf%C4%B1.jpg"),
      );
    }
  }
}