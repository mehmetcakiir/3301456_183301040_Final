import 'package:flutter/material.dart';
import 'package:untitled5/DataContract/Students.dart';
import 'package:untitled5/Screens/faculties_screen.dart';
import 'package:untitled5/Screens/students_name_screen.dart';
import 'package:untitled5/Studentsdao.dart';

class StudentDetail extends StatefulWidget {
  late Students student;
  StudentDetail({required this.student});

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {

  var formKey = GlobalKey<FormState>();
  late int saveFaculty = widget.student.faculties.facultyId;

  List<String> facultyList = [];

  String selectedFaculty = "";

  var tfStudentFirsName = TextEditingController();
  var tfStudentLastName = TextEditingController();
  var tfStudentNo = TextEditingController();
  var tfStudentMail = TextEditingController();

  Future<void> studentsUpdate(String firstName, String lastName, String no,
      String mail, int faculty) async {
    print("$firstName güncellendi");
    await Studentsdao().updateStudents(firstName, lastName, no, mail, faculty);
    //Navigator.push(context, MaterialPageRoute(builder: (context) => StudentsName(faculty: )));
  }

  @override
  void initState() {
    super.initState();
    var student = widget.student;
    tfStudentFirsName.text = student.studentFirstName;
    tfStudentLastName.text = student.studentLastName;
    tfStudentNo.text = student.studentNo;
    tfStudentMail.text = student.mail;

    facultyList.add("Bilgisayar Mühendisliği");
    facultyList.add("Makine Mühendisliği");
    facultyList.add("Elektrik Elektronik Mühendisliği");
    facultyList.add("Metalurji ve Malzeme Mühendisliği");

    if (student.faculties.facultyId == 1) {
      selectedFaculty = "Bilgisayar Mühendisliği";
    }
    if (student.faculties.facultyId == 2) {
      selectedFaculty = "Makine Mühendisliği";
    }
    if (student.faculties.facultyId == 3) {
      selectedFaculty = "Elektrik Elektronik Mühendisliği";
    }
    if (student.faculties.facultyId == 4) {
      selectedFaculty = "Metalurji ve Malzeme Mühendisliği";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Öğrenci Detay"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 30.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  controller: tfStudentFirsName,
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
                  controller: tfStudentNo,
                  maxLength: 9,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Öğrenci Numarası',
                    hintText: "18*******",
                    helperText: 'Öğrenci numarası formattaki gibi giriniz',
                    suffixIcon: Icon(
                      Icons.check_circle,
                    ),
                  ),
                  validator: (String? value){
                    if( value != null && value.length != 9){
                      return "Öğrenci numarası formattaki gibi giriniz";
                    }
                  },
                ),
                TextFormField(
                  controller: tfStudentMail,
                  maxLength: 30,
                  decoration: InputDecoration(
                    labelText: 'Öğrenci Mail Adresi',
                    helperText: 'Öğrenci mailini giriniz',
                    suffixIcon: Icon(
                      Icons.check_circle,
                    ),
                  ),
                  validator: (String? value){
                    if( value != null && !(value.contains('@hotmail.com') ||
                        value.contains('@gmail.com') ||
                        value.contains('@outlook.com') ||
                        value.contains('@icloud.com') ||
                        value.contains('@example.com') ||
                        value.contains('@yahoo.com') ||
                        value.contains('@aol.com'))){
                      return "Geçersiz e-posta";
                    }
                  },
                ),
                DropdownButton<String>(
                  value: selectedFaculty,
                  items:
                  facultyList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  icon: Icon(Icons.arrow_circle_down),
                  onChanged: (String? selectedItem) {
                    setState(() {
                      selectedFaculty = selectedItem!;

                      if (selectedFaculty == "Bilgisayar Mühendisliği") {
                        saveFaculty = 1;
                      } else if (selectedFaculty == "Makine Mühendisliği") {
                        saveFaculty = 2;
                      } else if (selectedFaculty ==
                          "Elektrik Elektronik Mühendisliği") {
                        saveFaculty = 3;
                      } else if (selectedFaculty ==
                          "Metalurji ve Malzeme Mühendisliği") {
                        saveFaculty = 4;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //studentsUpdate(tfStudentFirsName.text, tfStudentLastName.text, widget.student.studentNo, tfStudentMail.text, saveFaculty);
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentsName(faculty: widget.student.faculties)));
          if(formKey.currentState!.validate()){
            _showAllert();
          }
        },
        tooltip: 'Güncelle',
        icon: Icon(Icons.update),
        label: Text("Güncelle"),
      ),
    );
  }

  _showAllert() {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text('Kayıt güncellenecek emin misiniz?'),
            content: Text(
                'Güncelle butonuna bastıktan sonra bu işlem geri alınamaz.'),
            actions: [
              TextButton(
                onPressed: () {
                  studentsUpdate(
                      tfStudentFirsName.text,
                      tfStudentLastName.text,
                      widget.student.studentNo,
                      tfStudentMail.text,
                      saveFaculty);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StudentsName(faculty: widget.student.faculties)));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Kayıt Güncellendi'),
                    ),
                  );
                },
                child: Text('GÜNCELLE'),
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
