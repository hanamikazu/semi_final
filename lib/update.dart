import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:semi_final/home.dart';

class Update extends StatefulWidget {
  final Map todo;
  const Update({super.key, required this.todo});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool toEdit = false;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null){
      toEdit = true;
      final title = todo['title'];
      final body = todo['body'];
      titleController.text = title;
      bodyController.text = body;
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Edit Task'),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('title'),
              ),
              keyboardType: TextInputType.multiline,
              minLines: 2,
              maxLines: 10,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: bodyController,
              decoration: const InputDecoration(
                label: Text('body description'),
              ),
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: 50,
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () async {
                  edit();
                  final route = await Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const Home()));
                },
                child: const Text('Save'))
          ],
        ),
      ),
    );
  }
  Future<void> edit() async {
    final todo = widget.todo;
    if (todo == null) {
      return;
    }

    final id = todo['_id'];
    final title = titleController.text;
    final desc = bodyController.text;
    final body1 = {
      'title' : title,
      'body' : desc
    };

    final url = 'https://jsonplaceholder.typicode.com/posts/$id';
    final uri = Uri.parse(url);
    final response = await http.put(uri,
    body: jsonEncode(body1),
    headers: {"content-type": "application/json"});
  }
}
