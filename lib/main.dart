import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import './service/service_method.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 9787121321580
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
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FutureBuilder(
                future: request(barcode),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map projectItem = snapshot.data;

                    return ProjectMessage(projectItem: projectItem);
                  } else {
                    return Center(child: Text('请扫描条形码'));
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

  ProjectMessage({Key key, this.projectItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Column(
        children: <Widget>[
          new ListTile(
            title: new Text(
              '书名',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: new Text(projectItem['title']),
          ),
          new Divider(),
          new ListTile(
            title: new Text(
              '出版社',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: new Text(projectItem['publisher']),
          ),
          new Divider(),
          new Image.network(
            projectItem['image'],
            height: 100.0, //设置图片的高
            width: 100.0, //设置图片的宽
            fit: BoxFit.fitHeight,
            //BoxFit.fill  全图显示，显示可能拉伸或者充满
            //BoxFit.contain  全图显示 显示原比例，不需充满
            //BoxFit.cover 显示可能拉伸可能剪裁充满  BoxFit.fitWidth显示可能拉伸可能剪裁，宽度充满
            //BoxFit.fitHeight 显示可能拉伸可能充满，高度充满
            //BoxFit.scaleDown  效果和contain差不多,但是此属性不允许显示超过源图片大小，可小不可大
            alignment: Alignment.center, //可以控制实际图片在容器内的位置
          ),
          new Divider(),
          new ListTile(
            title: new Text(
              '豆瓣评分',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: new Text(projectItem['rating']['average']),
          ),
          new Divider(),
          new ListTile(
            title: new Text(
              '作者',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: new Text(getAuthorStr(projectItem['author'])),
          ),
          new Divider(),
          new ListTile(
            title: new Text(
              '内容',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: new Text(projectItem['catalog']),
          ),
        ],
      ),
    );
  }

  String getAuthorStr(List<dynamic> list) {
    String authorStr = '';
    for (int i = 0; i < list.length; i++) {
      authorStr += list[i].toString();
      authorStr += '\n';
    }
    return authorStr;
  }
}

class Qrscan {}
