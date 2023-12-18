// import 'dart:convert';
// import 'package:fluter_nodejs_todo_app/screens/todo_list_screen.dart';
// import 'package:fluter_nodejs_todo_app/services/config.dart';
// import 'package:http/http.dart' as http;
// import 'package:fluter_nodejs_todo_app/screens/todo_container_editscreen.dart';
// import 'package:fluter_nodejs_todo_app/sharedPreferenceManager/shared_prefernce_manager.dart';
// import 'package:flutter/material.dart';

// class TodoBox extends StatefulWidget {
//   int index;
//   List todoData;
//   var token;
//   TodoBox(

//       // {required this.title,
//       // required this.description,
//       {required this.index,
//       required this.todoData,
//       required this.token,
     
//       key});

//   @override
//   State<TodoBox> createState() => _TodoBoxState();
// }

// class _TodoBoxState extends State<TodoBox> {
//   late String id;

 
//   @override
//   void initState() {
//     super.initState();
//     var decodedToken = jsonDecode(widget.token);
//     id = decodedToken['_id'];
//   }

//   void deleteTodo(id) async {
//     var regBody = {"id": id};
//     var httpRespone = await http.post(Uri.parse(deleteTodoData),
//         body: jsonEncode(regBody),
//         headers: {"Content-Type": "application/json"});
//     var jsonResponse = jsonDecode(httpRespone.body);
//     if (jsonResponse['status']) {
//       await getTodoData(jsonResponse['userid']);
//     }
//   }

//   SharedPrefernceManager pref = SharedPrefernceManager();
//   dynamic tokenData(SharedPrefernceManager pref) async {
//     return await pref.getDataSP('token');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () async {
//         var mainTokenData = await tokenData(pref);
//         if (mainTokenData != null) {
//           Navigator.push(context, MaterialPageRoute(builder: (context) {
//             return TodoBoxContainerEditScreen(
//               token: mainTokenData,
//               description: widget.todoData[widget.index]['description'],
//               title: widget.todoData[widget.index]['title'],
//             );
//           }));
//         }
//       },
//       child: Container(
//         margin: EdgeInsets.all(8),
//         height: 150,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: const Color.fromARGB(255, 255, 232, 139)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 10, top: 5),
//               child: SafeArea(
//                   child: Text(
//                 '${widget.todoData[widget.index]['title']}',
//                 style:
//                     const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               )),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 10, top: 5),
//               child: SafeArea(
//                 child: Text(
//                   '${widget.todoData[widget.index]['description']}',
//                 ),
//               ),
//             ),
//             Expanded(
//                 child: Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 const Spacer(),
//                 IconButton(
//                     onPressed: () {
//                       deleteTodo(widget.todoData[widget.index]['_id']);
//                     },
//                     icon: const Icon(
//                       Icons.delete,
//                       color: Colors.red,
//                     ))
//               ],
//             ))
//           ],
//         ),
//       ),
//     );
//   }

 
// }
