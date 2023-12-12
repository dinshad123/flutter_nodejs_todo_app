import 'package:flutter/material.dart';

class TodoBox extends StatefulWidget {
  const TodoBox({super.key});

  @override
  State<TodoBox> createState() => _TodoBoxState();
}

class _TodoBoxState extends State<TodoBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return TodoBoxEditScreen();
        // }));
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
         const   Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: SafeArea(
                  child: Text(
                'Title:fsdgfhgdsfsdfgdshfgdsfsdhfgdshfgshdfsdfhds',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: SafeArea(
                  child: Text(
                'Content:fsadfhsdgfdshfgdnfvdfvsdvcsdchgdsgch',
              )),
            ),
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(),
                IconButton(
                    onPressed: () {},
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
