class Task {
  int? id;
  String title;
  String description;
  DateTime dueDate;
  String priority;

  Task({
    this.id, 
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
  });

  // Convert Task to Map (for inserting/updating in SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(), 
      'priority': priority,
    };
  }

  // Create a Task from SQLite Map result
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'], 
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      priority: map['priority'],
    );
  }
}
