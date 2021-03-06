import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:yorglass_ik/models/task.dart';

UserTask userTaskFromJson(String str) => UserTask.fromJson(json.decode(str));

String userTaskToJson(UserTask data) => json.encode(data.toJson());

List<UserTask> userTaskListFromJson(List<dynamic> listOfString) =>
    (listOfString).map((e) => UserTask.fromJson(e)).toList();

class UserTask {
  String id;
  String taskId;
  String userId;
  DateTime lastUpdate;
  DateTime nextActive;
  DateTime nextdeadline;
  int count;
  int complete;
  int point;
  Task task;

  UserTask(
      {@required this.id,
      @required this.taskId,
      @required this.userId,
      @required this.lastUpdate,
      @required this.nextActive,
      @required this.nextdeadline,
      @required this.count,
      @required this.complete,
      @required this.point,
      this.task});

  factory UserTask.fromJson(Map<String, dynamic> json) => UserTask(
        id: json["id"],
        taskId: json["taskid"],
        userId: json["userid"],
        lastUpdate: json["lastupdate"] == null
            ? DateTime.now()
            : DateTime.tryParse(json["lastupdate"]),
        nextActive: json["nextactive"] == null
            ? DateTime.now()
            : DateTime.tryParse(json["nextactive"]),
        nextdeadline: json["nextdeadline"] == null
            ? DateTime.now()
            : DateTime.tryParse(json["nextdeadline"]),
        count: json["count"],
        complete: json["complete"],
        point: json["point"],
        task: json["task"] != null ? taskFromJson(json["task"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "taskid": taskId,
        "userid": userId,
        "lastupdate": iso8601string(lastUpdate),
        "nextactive": iso8601string(nextActive),
        "nextdeadline": iso8601string(nextdeadline),
        "count": count,
        "complete": complete,
        "point": point,
        "task": task != null ? taskToJson(task) : null,
      };

  String iso8601string(value) => value == null ? null : value.toIso8601String();
}

//{
//  "id":"id",
//  "name": "",
//  "point": 1,
//  "interval": 1,
//  "counter": 2
//}
