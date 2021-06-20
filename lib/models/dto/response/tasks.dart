// To parse this JSON data, do
//
//     final tasksResponse = tasksResponseFromJson(jsonString);

import 'dart:convert';

TasksResponse tasksResponseFromJson(String str) => TasksResponse.fromJson(json.decode(str));

String tasksResponseToJson(TasksResponse data) => json.encode(data.toJson());

class TasksResponse {
  TasksResponse({
    this.code,
    this.description,
    this.tasks,
  });

  String code;
  String description;
  List<Task> tasks;

  factory TasksResponse.fromJson(Map<String, dynamic> json) => TasksResponse(
    code: json["code"] == null ? null : json["code"],
    description: json["description"] == null ? null : json["description"],
    tasks: json["tasks"] == null ? null : List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "description": description == null ? null : description,
    "tasks": tasks == null ? null : List<dynamic>.from(tasks.map((x) => x.toJson())),
  };
}

class Task {
  Task({
    this.id,
    this.name,
    this.employeeId,
    this.expectedCompletionTime,
    this.actualCompletionTime,
    this.expectedOutput,
    this.actualOutput,
    this.importance,
    this.cost,
    this.supervisor,
    this.assignedDate,
    this.taskExpiry,
    this.startedDate,
    this.completedDate,
    this.comments,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.outputs,
  });

  dynamic id;
  String name;
  dynamic employeeId;
  dynamic expectedCompletionTime;
  dynamic actualCompletionTime;
  dynamic expectedOutput;
  dynamic actualOutput;
  dynamic importance;
  dynamic cost;
  dynamic supervisor;
  DateTime assignedDate;
  dynamic taskExpiry;
  dynamic startedDate;
  dynamic completedDate;
  dynamic comments;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  List<Output> outputs;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    employeeId: json["employee_id"] == null ? null : json["employee_id"],
    expectedCompletionTime: json["expected_completion_time"] == null ? null : json["expected_completion_time"],
    actualCompletionTime: json["actual_completion_time"],
    expectedOutput: json["expected_output"] == null ? null : json["expected_output"],
    actualOutput: json["actual_output"],
    importance: json["importance"] == null ? null : json["importance"],
    cost: json["cost"] == null ? null : json["cost"],
    supervisor: json["supervisor"] == null ? null : json["supervisor"],
    assignedDate: json["assigned_date"] == null ? null : DateTime.parse(json["assigned_date"]),
    taskExpiry: json["task_expiry"] == null ? null : json["task_expiry"],
    startedDate: json["started_date"],
    completedDate: json["completed_date"],
    comments: json["comments"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    outputs: json["outputs"] == null ? null : List<Output>.from(json["outputs"].map((x) => Output.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "employee_id": employeeId == null ? null : employeeId,
    "expected_completion_time": expectedCompletionTime == null ? null : expectedCompletionTime,
    "actual_completion_time": actualCompletionTime,
    "expected_output": expectedOutput == null ? null : expectedOutput,
    "actual_output": actualOutput,
    "importance": importance == null ? null : importance,
    "cost": cost == null ? null : cost,
    "supervisor": supervisor == null ? null : supervisor,
    "assigned_date": assignedDate == null ? null : assignedDate.toIso8601String(),
    "task_expiry": taskExpiry == null ? null : taskExpiry,
    "started_date": startedDate,
    "completed_date": completedDate,
    "comments": comments,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "outputs": outputs == null ? null : List<dynamic>.from(outputs.map((x) => x.toJson())),
  };
}

class Output {
  Output({
    this.id,
    this.taskId,
    this.outputType,
    this.outputValue,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic taskId;
  String outputType;
  String outputValue;
  DateTime createdAt;
  DateTime updatedAt;

  factory Output.fromJson(Map<String, dynamic> json) => Output(
    id: json["id"] == null ? null : json["id"],
    taskId: json["task_id"] == null ? null : json["task_id"],
    outputType: json["output_type"] == null ? null : json["output_type"],
    outputValue: json["output_value"] == null ? null : json["output_value"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "task_id": taskId == null ? null : taskId,
    "output_type": outputType == null ? null : outputType,
    "output_value": outputValue == null ? null : outputValue,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
