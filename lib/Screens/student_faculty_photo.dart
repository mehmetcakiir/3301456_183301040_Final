import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/DataContract/FacultyPhotoContract.dart';
import 'package:untitled5/Screens/studentadd_screen.dart';
import 'package:untitled5/Screens/studentphoto_add_screen.dart';
import 'package:untitled5/Screens/studentphoto_screen.dart';

class FacultyPhotoScreen extends StatefulWidget {

  @override
  State<FacultyPhotoScreen> createState() => _FacultyPhotoScreenState();
}

class _FacultyPhotoScreenState extends State<FacultyPhotoScreen> {



  //Referans noktası oluşturulur
  var refFaculty = FirebaseDatabase.instance.ref().child("facultyNewTable");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teknoloji Fakültesi Bölümleri"),
      ),
      //realtime
      body: StreamBuilder<DatabaseEvent>(
        stream: refFaculty.onValue,
        builder: (context,event){
          //veri gelmeme durumu kontrolü
          if(event.hasData){
            print("değer geldi");
            var facultyList = <FacultyPhotoContract>[];
            var items = event.data!.snapshot.value as dynamic;
            if(items != null){
              items.forEach((key, object) {
                //Gelen değer
                var incomingValue = FacultyPhotoContract.fromJson(key, object);
                facultyList.add(incomingValue);
                print(incomingValue);

              });
            }
            return ListView.builder(
              itemCount: facultyList!.length,
              itemBuilder: (context,indeks){
                var faculty = facultyList[indeks];
                return GestureDetector(
                  onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => StudentPhotoScreen(facultyPhotoContract: faculty,)));
                  },
                  child: Card(
                    child: SizedBox(height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(faculty.facultyName),
                        ],
                      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentPhotoAdd()));
        },
        tooltip: 'Kişi Ekle',
        child: Icon(Icons.add),
      ),

    );
  }
}
