import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtubeflutter/models/student.dart';

// ignore: must_be_immutable
class StudentAdd extends StatefulWidget {
  List<Student> students;

  StudentAdd(this.students);

  @override
  State<StatefulWidget> createState() {
    return _StudentAdd();
  }
}

class _StudentAdd extends State<StudentAdd> {
  var formKey = GlobalKey<FormState>();

  Student student = Student("", "", 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add New Student"),
          backgroundColor: Colors.greenAccent,
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                buildFirstNameField(),
                buildLastNameField(),
                buildGradeField(),
                buildSubmitButton(),//alanların aşağısında bir adet buton koyudum
              ],
            ),
          ),
        ));
  }

  Widget buildFirstNameField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Öğrencinin adı : ", hintText: " Yasin"),
      onSaved: (String value) {
        student.firstName = value;
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Öğrencinin Soyadı: ", hintText: "Özer"),
      onSaved: (String value) {
        student.lastName = value;
      },
    );
  }

  Widget buildGradeField() {
    return TextFormField(
      decoration:
      InputDecoration(labelText: "Öğrencinin Notu: ", hintText: "100"),
      onSaved: (String value) {
        student.grade = int.parse(value); //value as int;
      },
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("Öğrenciyi Kaydet"),
      onPressed: () {
        formKey.currentState.save();//formdaki bütün save kısımlarını çalıştırır
       widget.students.add(student);//widget insatnce si üst class ın
        Navigator.pop(context);//ekleme işlemi yapılınca bi önceki sayfaya otomatik gitmek için ** pop diyince stack yapısında en üsttekini çıkarıyor
      },
    );
  }
}