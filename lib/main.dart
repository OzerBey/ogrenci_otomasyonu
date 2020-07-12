import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtubeflutter/models/student.dart';
import 'package:youtubeflutter/screens/student_add.dart';
final Color darkBlue = Color.fromARGB(255, 18, 32, 47);
void main() {
  //void main =>runApp(myApp));
  runApp(
      MyApp()); // runApp(new MyApp()); ile aynı anlama gelir yeni bir çağırım yapar
}

class MyApp extends StatelessWidget {
  //StatelessWidget mirasa alırklen içindeki metodu override etmemiz lazım
  @override
  Widget build(BuildContext context) {
    //widget türünde bişe döndürmeliyiz
    return MaterialApp(
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
        debugShowCheckedModeBanner: false,
        home: HomeScreen());
  }
}

/*class MaterialApp extends Widget{// material altındaki home gibi yapıların arka plan mantıgı bu şekilde düşünülebilir
    MaterialApp({Widget home}){
    }
  }*/
class HomeScreen extends StatefulWidget {
  //bir sreenin statefulwidget olması için statefulwidgtten extends etmesi lazım
  State<StatefulWidget> createState() {
    //kullanılan yerleri yeniden çiziyor --build :çizmek demek zaten
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State {
  List<Student> students = [
    Student.withId(1, "Zeki", "Çevik", 25),
    Student.withId(2, "Turist ", "Ömer", 40),
    Student.withId(3, "Yasin", "Özer", 100)
  ];

  Student selectedStudent = Student.withId(0, "Hiç", "Kimse", 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("                 ÖĞRENCİ TAKİP SİSTEMİ"),
        ),
        body: buildBody());
  }

  /*Widget buildBody() {
      //Widget yerine Center da koyabilriz ama center koyarsak sonraki eklemelerde sıkıntı çıkabilir
      return Center(
        child: Text("YASİN ÖZER"),
      );
    }*/
  Widget buildBody() {
    return Column(
      //ROW(satır) YANYANA column ise sütunsal yazdırır
      children: <Widget>[
        Expanded(
          //expanded koyuldugu zaman ekranın tamamını güvenli alan alıyor yani kaplıyor
          child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(students[index].firstName +
                      " " +
                      students[index].lastName),
                  subtitle: Text("Sınavdan aldığı not : " +
                      students[index].grade.toString() +
                      " [" +
                      students[index].getStatus +
                      "] "),
                  leading: avatarSec(),
                  trailing: buildStatusIcon(students[index]
                      .grade), // Icon(Icons.done),//böylede olabilir duruma göre değiştirmede olacak şekilde olur güncel hali öyle yaptım
                  onTap: () {
                    setState(() {
                      this.selectedStudent = students[
                          index]; //print (students[index].firstName);//  print("Tıklandı");
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      this.selectedStudent = students[index];
                    });

                    print("Uzun basıldı");
                  },
                ); //return Text(students[index].firstName);// burada yapılan dip dibe yazaken diğeri boşluklu yazar
              }),
        ),
        Text("                                    Seçili Öğrenci :" +
            selectedStudent.firstName +
            " " +
            selectedStudent.lastName +
            "\n _____________________________________________________________________"),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                  color: Colors.green,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add),
                      SizedBox(
                        width: 5.0,
                      ), //boşluk bırakmak için
                      Text("YENİ ÖĞRENCİ")
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                StudentAdd(students))); //context =en geniş widget agacı demek
                  }),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                  color: Colors.deepPurpleAccent,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add),
                      SizedBox(
                        width: 5.0,
                      ), //boşluk bırakmak için
                      Text("GÜNCELLE")
                    ],
                  ),
                  onPressed: () {
                    _navigateAddPage(context);
                    print("GÜNCELLE BUTONU");
                  }),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                  color: Colors.red,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add),
                      SizedBox(
                        width: 5.0,
                      ), //boşluk bırakmak için
                      Text("SİL")
                    ],
                  ),
                  onPressed: () {
                    print("SİL BUTONU");
                  }),
            )
          ],
        )
      ], // <Widget>[Text("YASİN"), Text("ÖZER"), Text("ALİ")],
    );
  }

  Widget buildStatusIcon(int grade) {
    // dart dilind tipini elirtmeden de return yapabilrisin ama sonrada anlaşımlası zor olacagı için tipini belirtmek sonra kodu tekrar okumada kolaylık saglar
    if (grade >= 50) {
      return Icon(Icons.done);
    } else if (grade >= 40) {
      return Icon(Icons.album);
    } else {
      return Icon(Icons.clear);
    }
  }
  void _navigateAddPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentAdd(students)),
    ).then((result) => setState(() {}));
  }
  avatarSec() {
    return CircleAvatar(
      backgroundImage: NetworkImage(
          "https://media-exp1.licdn.com/dms/image/C4E03AQGNIlammIZPvw/profile-displayphoto-shrink_400_400/0?e=1596672000&v=beta&t=oN1O9YGr4mFp5QiB09rX6Qw2h2ywoJa3tPFvk6fPuGI"),
    );
  }
}


