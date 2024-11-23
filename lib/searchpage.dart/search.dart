import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:calendar/searchpage.dart/colors.dart';
import 'package:calendar/searchpage.dart/todo.dart';
import 'package:calendar/searchpage.dart/search_result.dart';
// import 'package:calendar/dashboard.dart'; // Adjust this import based on your file structure

class Search extends StatefulWidget {
  Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final List<Todo> todolist = Todo.todoList(); // Your todo list data
  String searchQuery = '';
  List<String> recentSearches = [];

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  Future<void> _loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList('recentSearches') ?? [];
    });
  }

  Future<void> _saveSearchQuery(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    recentSearches.add(query);
    if (recentSearches.length > 20) {
      recentSearches.removeAt(0); // Keep only the last 20 searches
    }
    await prefs.setStringList('recentSearches', recentSearches);
  }

  void _searchAndNavigate() {
    if (searchQuery.isNotEmpty) {
      _saveSearchQuery(searchQuery);
    }

    final filteredResults = todolist
        .where((todo) => todo.todoTExt!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResults(
          results: filteredResults,
          onToDoChange: _handleTochange,
          onDeleteItem: _deleteToDoItem,
        ),
      ),
    );
  }

  void _handleTochange(Todo toDo) {
    setState(() {
      toDo.isDone = !toDo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todolist.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(235, 36, 105, 62),
        title: Text("Search Tasks"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            searchBox(),
            SizedBox(height: 20),
            _buildRecentSearches(), // Display recent searches
          ],
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.white,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       IconButton(
      //         icon: Icon(Icons.home, color: Colors.black),
      //         onPressed: () {
      //           Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(builder: (context) => Dashboard()),
      //           );
      //         },
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.calendar_today, color: Colors.black),
      //         onPressed: () {
      //           // Navigate to Calendar screen (update with actual route)
      //           Navigator.pushNamed(context, '/calendar');
      //         },
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.notifications, color: Colors.black),
      //         onPressed: () {
      //           // Navigate to Notifications screen (update with actual route)
      //           Navigator.pushNamed(context, '/notifications');
      //         },
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.search, color: Colors.black),
      //         onPressed: () {
      //           // Optionally handle search icon press
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget searchBox() {
    return TextField(
      onChanged: (value) {
        searchQuery = value;
      },
      onSubmitted: (value) {
        _searchAndNavigate();
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        prefixIcon: Icon(Icons.search, color: tdBlack),
        border: OutlineInputBorder(),
        hintText: 'Search for tasks...',
      ),
    );
  }

  Widget _buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recent Searches:", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        ...recentSearches.map((search) {
          return ListTile(
            title: Text(search),
            onTap: () {
              setState(() {
                searchQuery = search;
              });
              _searchAndNavigate();
            },
          );
        }).toList(),
      ],
    );
  }
}
