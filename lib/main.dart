import 'package:flutter/material.dart';
import 'package:storing_data_sql_app/data.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: HomeApp(),
  ));
}

class HomeApp extends StatefulWidget {
  HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  final dynamic _textController = TextEditingController();
  List<Data> datas = [];
  late Data currentData;
  final Helper help = Helper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Learing SQL'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Enter a text',
            ),
          ),
          FlatButton(
            onPressed: () {
              currentData = Data(textss: _textController.text);
              help.insertText(currentData);
            },
            child: Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
          ),
          FlatButton(
            onPressed: () async {
              List<Data> listData = await help.getData();

              setState(() {
                datas = listData;
              });
            },
            child: Text(
              'Show Data',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.pink,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text('${datas[index].id}'),
                  title: Text('${datas[index].textss}'),
                );
              },
              itemCount: datas.length,
            ),
          )
        ],
      ),
    );
  }
}
