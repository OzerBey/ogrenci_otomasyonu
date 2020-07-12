class Student {
  int id;
  String firstName;
  String lastName;
  int grade;
  String status; //_status olunca private bi alan oldugunu belirtiyor dart dilinde public private vs yoktur
  Student(String firstName, String lastName, int grade) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.grade = grade;
  }
  //ikinci constructor dart dlinde named structor denir
  Student.withId(int id, String firstName, String lastName, int grade) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.grade = grade;
  }
  String get getStatus {
    //if else blocklarında sadece bi tanesi çalisir
    String message = "";
    if (this.grade >= 50) {
      message = " GEÇTİ";
    } else if (this.grade >= 40) {
      message = " BÜTÜNLEMEYE KALDI";
    } else {
      message = " KALDI";
    }
    this.status=message;
    return this.status;
    //return message;
  }
}
