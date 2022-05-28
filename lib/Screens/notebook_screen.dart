import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/Screens/admin_screen.dart';
import 'package:untitled5/costants.dart';
import 'package:untitled5/models/student.dart';
import 'package:untitled5/validate/student_validation.dart';
import 'package:path_provider/path_provider.dart';

class NoteBook extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NoteBookState();
  }
}

class _NoteBookState extends State with StudentValidationMixin {

  var tfInpute = TextEditingController();

  Future<void> writeData() async {
    //Dosya sistemine ulaşılır
    var ad = await getApplicationDocumentsDirectory();

    var filePath = await ad.path;

    var file = File("$filePath/dosyam.txt");

    if(tfInpute.text.toString().isNotEmpty){
      //Girdi alınarak dosyaya yazılır
      file.writeAsString(tfInpute.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notunuz Kaydedildi'),),
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lütfen Notunuzu Giriniz'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
    tfInpute.text = "";
    print(tfInpute.text);
  }


  //if kontrol edilecek
  Future<void> readData() async {

    try{
      //Dosya sistemine ulaşılır
      var ad = await getApplicationDocumentsDirectory();

      var filePath = await ad.path;

      var file = File("$filePath/dosyam.txt");

      String dataRead = await file.readAsString();

      if(!(tfInpute.text.toString().isNotEmpty && !(tfInpute.text.contains("")))){
        tfInpute.text = dataRead;
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Notunuz Bulunmamaktadır'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }

    }catch(e){
      print(e);
    }
  }

  Future<void> removeData() async {

    //Dosya sistemine ulaşılır
    var ad = await getApplicationDocumentsDirectory();

    var filePath = await ad.path;

    var file = File("$filePath/dosyam.txt");

    //Dosya var mı
    if(file.existsSync()){
      file.delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Notunuz Silindi'),
        ),
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Silinebilecek Bir Notunuz Bulunmamakta'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
    tfInpute.text = "";

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child:SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not Defterim",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 20.0
                  ),
                ),
                SizedBox(
                  height: 80.0,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 5,
                  controller: tfInpute,
                  decoration: InputDecoration(
                      hintText: "Notunuzu Giriniz"
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, top: 50.0, right: 10.0, bottom: 10.0),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        color: kPrimaryColor,
                        onPressed: (){
                          writeData();
                        },
                        child: Text(
                          "Not Defterime Kaydet",
                          style: TextStyle(color: Colors.white),
                        )
                    ) ,
                  ) ,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        color: Colors.deepPurpleAccent,
                        onPressed: (){readData();},
                        child: Text(
                          "Not Defterimi Oku",
                          style: TextStyle(color: Colors.white),
                        )
                    ) ,
                  ) ,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        color: Colors.lightBlueAccent,
                        onPressed: (){removeData();},
                        child: Text(
                          "Notu Sil",
                          style: TextStyle(color: Colors.white),
                        )
                    ) ,
                  ) ,
                ),
                SizedBox(
                  height: 120.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}