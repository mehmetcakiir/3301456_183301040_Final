import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/DataContract/Faculties.dart';
import 'package:untitled5/Facultiesdao.dart';
import 'package:untitled5/Screens/students_name_screen.dart';

class FacultiesScreen extends StatefulWidget {
  const FacultiesScreen({Key? key}) : super(key: key);

  @override
  State<FacultiesScreen> createState() => _FacultiesScreenState();
}

class _FacultiesScreenState extends State<FacultiesScreen> {

  late String imageNames;

  Future<List<Faculties>> facultiesShow() async{

    List<Faculties> facultiesList = await Facultiesdao().allFaculties();
    return facultiesList;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teknolo Fakültesi Bölümleri"),
      ),
      body: FutureBuilder<List<Faculties>>(
        future: facultiesShow(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var facultiesList = snapshot.data;
            return ListView.builder(
              itemCount: facultiesList!.length,
              itemBuilder: (context,index) {
                var faculties = facultiesList[index];
                if(faculties.facultyId == 1){
                  imageNames = 'bilgisayar';
                }
                if(faculties.facultyId == 2){
                  imageNames = 'makine';
                }
                if(faculties.facultyId == 3){
                  imageNames = 'elektrik';
                }
                if(faculties.facultyId == 4){
                  imageNames = 'metalurji';
                }
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => StudentsName(faculty: faculties)));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Text(faculties.facultyName)
                            Image.asset(
                              'assets/images/$imageNames.PNG',
                              height: 200,
                              width: 300,
                              fit: BoxFit.fitWidth,
                            ),
                          ],
                        ),
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
    );
  }
}
