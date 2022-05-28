import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/Screens/student_faculty_photo.dart';

class StudentPhotoAdd extends StatefulWidget {
  @override
  _StudentPhotoAddState createState() => _StudentPhotoAddState();
}

class _StudentPhotoAddState extends State<StudentPhotoAdd> {

  var formKey = GlobalKey<FormState>();

  String selectedFaculty = 'Bilgisayar Mühendisliği';
  List<String> facultyList = [];

  var items = [
    'Bilgisayar Mühendisliği',
    'Makine Mühendisliği',
    'Elektrik Elektronik Mühendisliği',
    'Metalurji ve Malzeme Mühendisliği',
  ];


  var tfstudentFirstName = TextEditingController();
  var tfStudentPhoneNumber = TextEditingController();
  var tfStudentLastName = TextEditingController();
  var tfStudentbirthYear = TextEditingController();
  var tfStudentAdress = TextEditingController();

  var refStudentPhoto = FirebaseDatabase.instance.ref().child("student");

  Future<void> add(String studentFirstName, String studentLastName,
      int birthYear
      , String studentPhoneNumber, String adressPhotoName,
      String facultyPhotoName) async {
    var info = HashMap<String, dynamic>();
    info["studentId"] = " ";
    info["studentFirstName"] = studentFirstName;
    info["studentLastName"] = studentLastName;
    info["birthYear"] = birthYear;
    info["studentPhoneNumber"] = studentPhoneNumber;
    info["adressPhotoName"] = adressPhotoName;
    info["facultyPhotoName"] = facultyPhotoName;
    info["studentPhoto"] = 'default.png';
    refStudentPhoto.push().set(info);
    //Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Öğrenci Kayıt"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                    controller: tfstudentFirstName,
                    maxLength: 20,
                    decoration: InputDecoration(
                      labelText: 'Öğrenci Adı',
                      helperText: 'Öğrenci adı en az 2 karekter olmalıdır',
                      suffixIcon: Icon(
                        Icons.check_circle,
                      ),
                    ),
                    validator: (String? value) {
                      if (value != null && value.length < 2) {
                        return "Öğrenci adı en az 2 karekter olmalıdır";
                      }
                    },
                  ),
                  TextFormField(
                      controller: tfStudentLastName,
                      maxLength: 20,
                      decoration: InputDecoration(
                        labelText: 'Öğrenci Soyadı',
                        helperText: 'Öğrenci soyadı en az 2 karekter olmalıdır',
                        suffixIcon: Icon(
                          Icons.check_circle,
                        ),
                      ),
                      validator: (String? value) {
                        if (value != null && value.length < 2) {
                          return "Öğrenci soyadı en az 2 karekterden oluşmalıdır";
                        }
                      }),
                  TextFormField(
                    controller: tfStudentbirthYear,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: InputDecoration(
                      labelText: 'Öğrencinin Doğum Yılı',
                      helperText: '19880-2010',
                      suffixIcon: Icon(
                        Icons.check_circle,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: tfStudentPhoneNumber,
                    maxLength: 13,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Öğrenci Telefon Numarası',
                      hintText: "05** *** ****",
                      helperText: 'Öğrenci telefon numarası formattaki gibi giriniz',
                      suffixIcon: Icon(
                        Icons.check_circle,
                      ),
                    ),
                    validator: (String? value) {
                      if (value != null && value.length != 13) {
                        return "Öğrenci numarası formattaki gibi giriniz";
                      }
                    },
                  ),
                  TextFormField(
                    minLines: 3,
                    maxLines: 5,
                    controller: tfStudentAdress,
                    decoration: InputDecoration(
                      labelText: 'Adres',
                      hintText:
                      "Kavaklıdere, Esat Cd. No:2 D:2, 06680 Çankaya/Ankara",
                      suffixIcon: Icon(
                        Icons.check_circle,
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    value: selectedFaculty,
                    items:
                    items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    icon: Icon(Icons.arrow_circle_down),
                    onChanged: (String? selectedItem) {
                      setState(() {
                        selectedFaculty = selectedItem!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            _showAllert();
          }
        },
        tooltip: 'Kişi Kayıt',
        icon: Icon(Icons.update),
        label: Text("Kaydet"),
      ),
    );
  }


  _showAllert() {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text('Kayıt eklenecek emin misiniz?'),
            content: Text(
                'Kaydet butonuna bastıktan sonra bu işlem geri alınamaz.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  add( tfstudentFirstName.text, tfStudentLastName.text,
                      int.parse(tfStudentbirthYear.text),tfStudentPhoneNumber.text,tfStudentAdress.text, selectedFaculty);
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                  builder: (context) =>
                  FacultyPhotoScreen()));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Kayıt Gerçekleşti'),
                    ),
                  );
                },
                child: Text('Kaydet'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Color(0xFF6200EE),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('VAZGEÇ'),
              ),
            ],
          );
        });
  }
}

