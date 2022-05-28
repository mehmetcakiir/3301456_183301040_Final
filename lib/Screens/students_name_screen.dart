import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/DataContract/Faculties.dart';
import 'package:untitled5/DataContract/Students.dart';
import 'package:untitled5/Screens/studentadd_screen.dart';
import 'package:untitled5/Screens/studentdetail_screen.dart';
import 'package:untitled5/Studentsdao.dart';

class StudentsName extends StatefulWidget {
  late Faculties faculty;
  StudentsName({required this.faculty});

  @override
  State<StudentsName> createState() => _StudentsNameState();
}

class _StudentsNameState extends State<StudentsName> {
  //Arama Yapılıyor mu
  late bool areYouMakingCall = false;

  //Aranan kelime
  late String wanted = "";

  Future<List<Students>> studentsShow() async {
    List<Students> studentsList = await Studentsdao().allStudents(widget.faculty.facultyId);
    return studentsList;
  }

  Future<List<Students>> callMake(String wanted, int facultyId) async {
    List<Students> studentsList = await Studentsdao().callStudents(wanted,widget.faculty.facultyId);
    return studentsList;
  }

  Future<void> studentsRemove(String studentNo) async {
    await Studentsdao().deleteStudents(studentNo);
    print("$studentNo silindi");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: areYouMakingCall
            ? TextField(
          decoration:
          InputDecoration(hintText: "Öğrenci Numarasını Giriniz"),
          onChanged: (wantedTemp) {
            print("Arama Kelime: $wantedTemp");
            setState(() {
              wanted = wantedTemp;
            });
          },
        )
            : Text("${widget.faculty.facultyName}"),
        actions: [
          areYouMakingCall
              ? IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                areYouMakingCall = false;
                wanted = "";
              });
            },
          )
              : IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                areYouMakingCall = true;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Students>>(
        future: areYouMakingCall ? callMake(wanted,widget.faculty.facultyId) : studentsShow(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var studentsList = snapshot.data;
            return ListView.builder(
              itemCount: studentsList!.length,
              itemBuilder: (context, index) {
                var student = studentsList[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentDetail(student: student,)));
                  },
                  child: Card(
                    child: SizedBox(
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            student.studentFirstName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            student.studentLastName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            student.studentNo,
                            style: TextStyle(color: Colors.teal),
                          ),
                          SizedBox(
                            height: 180.0,
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.redAccent,
                            onPressed: () {
                              _showAllert(student);
                              //studentsRemove(student.studentNo);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentAddScreen(widget.faculty)));
        },
        tooltip: 'Kişi Ekle',
        child: Icon(Icons.add),
      ),
    );
  }

  _showAllert(Students students){
    showDialog(
        context: context,
        builder: (BuildContext){
          return AlertDialog(
            title: Text('Kayıt silinecek emin misiniz?'),
            content: Text('Sil butonuna bastıktan sonra bu işlem geri alınamaz.'),
            actions: [
              TextButton(
                onPressed: () {
                  studentsRemove(students.studentNo);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Kayıt Silindi'),),
                  );
                },
                child: Text('SİL'),
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
        }
    );
  }
}
