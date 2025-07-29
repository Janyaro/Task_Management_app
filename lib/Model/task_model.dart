class Task {
  int? id;
  String title;
  String description;
  DateTime dueDate;
  String priority;
  String status;

  Task({
    this.id, 
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.status
  });

  // Convert Task to Map (for inserting/updating in SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(), 
      'priority': priority,
      'status':status
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
      status: map['status']
    );
  }
}
