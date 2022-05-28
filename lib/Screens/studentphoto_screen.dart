
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/DataContract/AdressContract.dart';
import 'package:untitled5/DataContract/FacultyPhotoContract.dart';
import 'package:untitled5/DataContract/StudentPhotoContract.dart';
import 'package:untitled5/Screens/adressphoto_screen.dart';

class StudentPhotoScreen extends StatefulWidget {
  FacultyPhotoContract facultyPhotoContract;

  StudentPhotoScreen({required this.facultyPhotoContract});

  @override
  _StudentPhotoScreenState createState() => _StudentPhotoScreenState();
}

class _StudentPhotoScreenState extends State<StudentPhotoScreen> {

  // Referans oluşturulur
  var refStudent = FirebaseDatabase.instance.ref().child("student");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Öğrenci Listesi : ${widget.facultyPhotoContract.facultyName}"),
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: refStudent.orderByChild("facultyPhotoName").equalTo(widget.facultyPhotoContract.facultyName).onValue,
        builder: (context,event){
          if(event.hasData){
            var studentPhotoList = <StudentPhotoContract>[];
            var items = event.data!.snapshot.value as dynamic;
            if(items != null){
              items.forEach((key, object) {
                //Gelen değer
                var incomingValue = StudentPhotoContract.fromJson(key, object);
                studentPhotoList.add(incomingValue);
              });
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //1 satırda gösterilecek öğrenci
                crossAxisCount: 2,
                //Oran olarak Boyur
                childAspectRatio: 2 / 3.5,
              ),
              itemCount: studentPhotoList!.length,
              itemBuilder: (context,indeks){
                var studentPhotoItem = studentPhotoList[indeks];
                var photoName = studentPhotoItem.studentPhoto;
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AdressPhotoScreen(studentPhotoContract: studentPhotoItem ,)));
                  },
                  child: Card(
                    child: Column(
                      //Aralarında boşluklu yapıyı sağlar
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/$photoName'),
                          //child: Image.network("assets/images/${studentPhotoItem.studentPhoto}"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(studentPhotoItem.studentFirstName,style: TextStyle(fontSize: 20, color: Colors.blue),),
                            Text("  "),
                            Text(studentPhotoItem.studentLastName,style: TextStyle(fontSize: 20, color: Colors.blue,),),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return Center();
          }
        },
      ),

    );
  }
}
