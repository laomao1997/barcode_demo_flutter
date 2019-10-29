import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import './service/service_method.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String barcode;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('条形码扫描'),

        ),
        body: Container(
          margin: EdgeInsets.only(top: 0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FutureBuilder(
                future: request(barcode),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    Map projectItem=snapshot.data;

                    return ProjectMessage(projectItem:projectItem);

                  }else{
                    return Center(
                        child:Text('请扫描条形码')
                    );
                  }
                },
              ),
              //Text(barcode),
              MaterialButton(
                onPressed: scan,
                child: Text("扫描"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await scanner.scan();
      setState(() => this.barcode = barcode);
    } on Exception catch (e) {
      if (e == scanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    }
  }
}

class ProjectMessage extends StatelessWidget {
  final Map projectItem;

  ProjectMessage({Key key,this.projectItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title:new Text('书名',style: TextStyle(fontWeight: FontWeight.w500),),
              subtitle: new Text(projectItem['title']),
              leading: new Icon(Icons.account_box,color: Colors.lightBlue,),
            ),
            new Divider(),
            ListTile(
              title:new Text('出版社',style: TextStyle(fontWeight: FontWeight.w500),),
              subtitle: new Text(projectItem['publisher']),
              leading: new Icon(Icons.account_box,color: Colors.lightBlue,),
            ),
            new Divider(),
            new Image.network(projectItem['image'])
          ],
        ),
      ),
    );
  }
}

class Qrscan {
}