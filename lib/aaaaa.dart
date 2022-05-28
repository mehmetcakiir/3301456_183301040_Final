
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/DataContract/StudentPhotoContract.dart';

class AdressPhotoScreen extends StatefulWidget {
  StudentPhotoContract studentPhotoContract;

  AdressPhotoScreen({required this.studentPhotoContract});

  @override
  _AdressPhotoScreenState createState() => _AdressPhotoScreenState();
}

class _AdressPhotoScreenState extends State<AdressPhotoScreen> {

  //Referans noktası oluşturulur
  var refFaculty = FirebaseDatabase.instance.ref().child("adressTable");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.studentPhotoContract.studentFirstName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.network("https://upload.wikimedia.org/wikipedia/tr/6/6c/Yahya_Demirel_foto%C4%9Fraf%C4%B1.jpg"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.studentPhotoContract.studentFirstName.toString(),style: TextStyle(fontSize: 20),),
                Text(" "),
                Text(widget.studentPhotoContract.studentLastName.toString(),style: TextStyle(fontSize: 20),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Doğum Tarihi : ", style: TextStyle(fontSize: 20),),
                Text(widget.studentPhotoContract.birthYear.toString(),style: TextStyle(fontSize: 20),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Telefon Numarası : ", style: TextStyle(fontSize: 20),),
                Text(widget.studentPhotoContract.studentPhoneNumber.toString(),style: TextStyle(fontSize: 20),),
              ],
            ),

            //Text(widget.studentPhotoContract.facultyPhotoContract.facultyNama,style: TextStyle(fontSize: 30),),
          ],
        ),
      ),

    );
  }
}
