import 'dart:convert';
import 'package:fluter_nodejs_todo_app/avatars.dart';
import 'package:fluter_nodejs_todo_app/screens/todo_container_editscreen.dart';
import 'package:fluter_nodejs_todo_app/screens/todolist_components/todolist_containers.dart';
import 'package:fluter_nodejs_todo_app/services/config.dart';
import 'package:fluter_nodejs_todo_app/sharedPreferenceManager/shared_prefernce_manager.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class ToDoListScreen extends StatefulWidget {
  final token;

  const ToDoListScreen({this.token, super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  SharedPrefernceManager sharedPrefernceManager = SharedPrefernceManager();
  late String email;
  late String userId;
  List? items;
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
    userId = decodedToken['_id'];
    getTodoList(userId);
  }

  void getTodoList(userId) async {
    var regBody = {'userId': userId};

    try {
      var response = await http.post(
        Uri.parse(getTodoData),
        body: jsonEncode(regBody),
        headers: {"Content-Type": "application/json"},
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        items = jsonResponse['success'];
        setState(() {});
        print(items?[0]);
      } else {
        // Handle non-200 status code or unexpected response
        print('Request failed with status: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (e) {
      // Handle other exceptions (e.g., network error)
      print('Error during HTTP request: $e');
    }
  }

  void deleteTodo(id) async {
    var regBody = {"id": id};
    var httpRespone = await http.post(Uri.parse(deleteTodoData),
        body: jsonEncode(regBody),
        headers: {"Content-Type": "application/json"});
    var jsonResponse = jsonDecode(httpRespone.body);
    if (jsonResponse['status']) {
      getTodoList(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Column(
        children: <Widget>[
          ListTile(
              // leading: Text(email),
              ),
          const Spacer(),
          TextButton(
              onPressed: () {
                sharedPrefernceManager.removeDataSP('token');
                print('delete data');
              },
              child: const Text('Sign out'))
        ],
      )),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: Image.asset(
          logo,
          width: 170,
        ),
        titleSpacing: 0.0,
        actions: [
          Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.deepPurple[300],
                ));
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TodoBoxContainerEditScreen(
                token: widget.token,
              );
            }));
          },
          backgroundColor: Colors.deepPurple[300],
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: Column(
        children: [
          const SizedBox(
            height: 2,
          ),
          Divider(
            thickness: 5,
            height: 3,
            color: Colors.deepPurple[300],
          ),
          Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // crossAxisSpacing: 6.0, // Adjust the spacing between columns
                    // mainAxisSpacing: 6.0,
                  ),
                  itemCount: items == null ? null : items?.length,
                  itemBuilder: (context, index) {
                    return items == null
                        ? null
                        : todoBox(context, items!, index);
                    // TodoBox(
                    //     todoData: items!,
                    //     index: index,
                    //     token: widget.token,
                    //   );
                  })),
        ],
      ),
    );
  }

  Widget todoBox(BuildContext context, List items, int index) {
    return InkWell(
      onTap: () async {
        if (widget.token != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TodoBoxContainerEditScreen(
              token: widget.token,
              description: items[index]['description'],
              title: items[index]['title'],
            );
          }));
        }
      },
      child: Container(
        margin: EdgeInsets.all(8),
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 255, 232, 139)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: SafeArea(
                  child: Text(
                '${items[index]['title']}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: SafeArea(
                child: Text(
                  '${items[index]['description']}',
                ),
              ),
            ),
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(),
                IconButton(
                    onPressed: () {
                      deleteTodo(items[index]['_id']);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
