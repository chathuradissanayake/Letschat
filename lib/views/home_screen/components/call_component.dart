import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

Widget callComponent() {
  return Scaffold(
    // appBar: AppBar(
    //   title: Text('Call Log'),
    // ),
    body: CallLogList(),
    backgroundColor: Colors.transparent,
  );
}

class CallLogList extends StatefulWidget {
  @override
  _CallLogListState createState() => _CallLogListState();
}

class _CallLogListState extends State<CallLogList> {
  final Faker _faker = Faker();
  late List<CallLogItemModel> _callLogs;

  @override
  void initState() {
    super.initState();
    _callLogs = _generateCallLogs();
    _callLogs.sort((a, b) => a.callTimestamp.compareTo(b.callTimestamp));
  }

  List<CallLogItemModel> _generateCallLogs() {
    final List<CallLogItemModel> callLogs = [];

    for (int i = 0; i < 10; i++) {
      callLogs.add(CallLogItemModel(
        id: i,
        callerName: _faker.person.name(),
        callTimestamp: _generateRandomTimestamp(),
      ));
    }

    return callLogs;
  }

  String _generateRandomTimestamp() {
    final minutesAgo = Random().nextInt(60);
    return '$minutesAgo minutes ago';
  }

  void _deleteCallLog(int id) {
    setState(() {
      _callLogs.removeWhere((callLog) => callLog.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _callLogs.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(_callLogs[index].id.toString()),
          onDismissed: (direction) {
            _deleteCallLog(_callLogs[index].id);
          },
          background: Container(
            color: Colors.red,
            child: Icon(Icons.delete, color: Colors.white),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 16.0),
          ),
          child: CallLogItem(
            id: _callLogs[index].id,
            callerName: _callLogs[index].callerName,
            callTimestamp: _callLogs[index].callTimestamp,
            onDelete: () {
              _deleteCallLog(_callLogs[index].id);
            },
          ),
        );
      },
    );
  }
}

class CallLogItem extends StatelessWidget {
  final int id;
  final String callerName;
  final String callTimestamp;
  final VoidCallback onDelete;

  CallLogItem({
    required this.id,
    required this.callerName,
    required this.callTimestamp,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      title: Text(callerName),
      subtitle: Row(
        children: [
          Icon(Icons.call_received),
          SizedBox(width: 4),
          Text(callTimestamp),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.call),
        onPressed: () {
          // Add logic to handle the call button press
          // For example, you can navigate to a call screen
        },
      ),
      onLongPress: onDelete,
    );
  }
}

class CallLogItemModel {
  final int id;
  final String callerName;
  final String callTimestamp;

  CallLogItemModel({
    required this.id,
    required this.callerName,
    required this.callTimestamp,
  });
}

void main() {
  runApp(MaterialApp(
    home: callComponent(),
  ));
}
