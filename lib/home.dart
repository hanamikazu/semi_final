import 'package:flutter/material.dart';
import 'package:semi_final/update.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List tasks = [];

  @override
  void initState() {
    super.initState();
    getTask();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Get and Updating Data'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index){
            final todo = tasks[index] as Map;
            return Card(
              child: ListTile(
                leading: SizedBox(
                height: 20,
                child: Text('${index + 1}')),
                title: Text(todo['title']),
                subtitle: Text(todo['body']),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    updateTasks(todo);
                    if (value == 'edit') {
                    } else if (value == 'delete') {}
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                    )
                  ],
                ),
            ),
            );
    }),
    );
  }
  Future<void> getTask() async{
    final url = 'https://jsonplaceholder.typicode.com/posts';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = convert.jsonDecode(response.body) as List;

    setState(() {
      tasks = json;
    });
  }

  Future<void> updateTasks(Map todo) async{
    final route = MaterialPageRoute(
        builder: (context) => Update(todo: todo));
    await Navigator.push(context, route);
    getTask();
  }
}

