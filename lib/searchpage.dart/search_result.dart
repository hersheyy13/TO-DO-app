import 'package:flutter/material.dart';
import 'package:calendar/searchpage.dart/todo.dart';
import 'package:calendar/searchpage.dart/todo_item.dart';

class SearchResults extends StatelessWidget {
  final List<Todo> results;
  final Function(Todo) onToDoChange;
  final Function(String) onDeleteItem;

  const SearchResults({
    Key? key,
    required this.results,
    required this.onToDoChange,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Results"),
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return TodoItem(
            todo: results[index],
            onToDochange: onToDoChange,
            ondeleteitem: onDeleteItem,
          );
        },
      ),
    );
  }
}
