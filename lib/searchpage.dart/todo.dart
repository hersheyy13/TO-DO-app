class Todo {
  String? id;
  String? todoTExt;
  bool isDone;

  Todo({  
    required this.id,
    required this.todoTExt,
    this.isDone = false,
  });
  static List<Todo> todoList() {
    return [
      Todo(id: '1', todoTExt: 'morning excercise',isDone: true),
      Todo(id: '2', todoTExt: 'check emails',isDone: true),
      Todo(id: '3', todoTExt: 'Buy bread'),
      Todo(id: '3', todoTExt: 'team meeting'),
      Todo(id: '3', todoTExt: 'work on mobile apps for 2 hours'),
      Todo(id: '3', todoTExt: 'dinner with jenny'),
    ];
  }
}