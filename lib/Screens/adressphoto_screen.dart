
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/DataContract/StudentPhotoContract.dart';
import 'package:untitled5/Screens/photoEdit.dart';

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
    var photoName = widget.studentPhotoContract.studentPhoto;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.studentPhotoContract.studentFirstName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StudentPhotoDetail( studentPhotoContract : widget.studentPhotoContract)));
                },
              //StudentPhotoDetail
                child: Image.asset('assets/images/$photoName')
            ),
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
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Adress : ", style: TextStyle(fontSize: 20),),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(widget.studentPhotoContract.adressPhotoName.toString(),style: TextStyle(fontSize: 15),),
            ),
            //Text(widget.studentPhotoContract.adressPhotoName.toString(),style: TextStyle(fontSize: 15),),
            SizedBox(
              height: 50.0,
            ),

            //Text(widget.studentPhotoContract.facultyPhotoContract.facultyNama,style: TextStyle(fontSize: 30),),
          ],
        ),
      ),

    );
  }
}
