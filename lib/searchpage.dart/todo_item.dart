import 'package:calendar/searchpage.dart/colors.dart';
import 'package:calendar/searchpage.dart/todo.dart';
import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final onToDochange;
  final ondeleteitem;
  const TodoItem({super.key, required this.todo, this.onToDochange, this.ondeleteitem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDochange(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: const Color.fromARGB(146, 207, 197, 197),
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,),
        title: Text(
          todo.todoTExt!,
          style: TextStyle(
            
            color: tdBlack,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
          ),
          trailing: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.symmetric(vertical: 12),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: tdRed,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              color: Colors.white,
              iconSize: 18,
              icon: Icon(Icons.delete),
              onPressed: () {
                ondeleteitem(todo.id);
              },
            ),),
      ),
    );
  }
}