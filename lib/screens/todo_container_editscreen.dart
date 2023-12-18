import 'dart:convert';
import 'package:fluter_nodejs_todo_app/screens/todo_list_screen.dart';
import 'package:fluter_nodejs_todo_app/services/config.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class TodoBoxContainerEditScreen extends StatefulWidget {
  final token;
  String? title;
  String? description;
  TodoBoxContainerEditScreen(
      {required this.token, this.title, this.description, super.key});

  @override
  State<TodoBoxContainerEditScreen> createState() =>
      _TodoBoxContainerEditScreenState();
}

class _TodoBoxContainerEditScreenState
    extends State<TodoBoxContainerEditScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late String userId;

  @override
  void initState() {
    super.initState();
    if (widget.title != null && widget.description != null) {
      _titleController.text = widget.title!;
      _descriptionController.text = widget.description!;
    }
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
  }

  void addTodo() async {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      var todoData = {
        'title': _titleController.text,
        'desc': _descriptionController.text,
        'userId': userId,
      };

      var response = await http.post(Uri.parse(addTodoAdress),
          body: jsonEncode(todoData),
          headers: {"Content-Type": "application/json"});
      // print('${response.body}');

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (jsonResponse['status']) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return ToDoListScreen(
            token: widget.token,
          );
        }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "STACK  UP  YOUR  DO'S",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  'Title',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: 20,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          addTodo();
                        },
                        icon: const Icon(Icons.folder),
                        label: const Text('Submit')),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
