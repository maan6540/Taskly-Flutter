import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoplus/Models/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: unused_field
  late double _devicewidth, _deviceheight;
  // ignore: unused_field
  Box? _box;
  // ignore: unused_field
  String? _newTaskContent;

  Color mycolor = Colors.orange;

  _HomeScreenState();

  @override
  Widget build(BuildContext context) {
    _deviceheight = MediaQuery.of(context).size.height;
    _devicewidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceheight * 0.15,
        title: const Text(
          'Taskly!',
          style: TextStyle(
            fontSize: 25,
            letterSpacing: 3,
            color: Colors.white,
          ),
        ),
      ),
      body: _taskView(),
      floatingActionButton: _actionButton(),
    );
  }

  // TaskList Function to Create Task
  Widget _taskList() {
    // Task _newTask =
    //     Task(content: 'Go To Gym', timestamp: DateTime.now(), done: false);
    // _box?.add(_newTask.toMap());
    List tasks = _box!.values.toList();
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext _context, int _index) {
        var task = Task.fromMap(tasks[_index]);
        return ListTile(
          title: Text(
            task.content,
            style: TextStyle(
                decoration: task.done
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                fontSize: 20),
          ),
          subtitle: Text(
              '${task.timestamp.year} / ${task.timestamp.month} / ${task.timestamp.minute}'),
          trailing: Icon(
            task.done
                ? Icons.check_box_outlined
                : Icons.check_box_outline_blank,
            color: mycolor,
          ),
          onTap: () {
            task.done = !task.done;
            _box!.putAt(
              _index,
              task.toMap(),
            );
            setState(() {});
          },
          onLongPress: () {
            _box!.deleteAt(_index);
            setState(() {});
          },
        );
      },
    );

    // ListView(
    //   children: [
    //     ListTile(
    //       title: const Text(
    //         'Breakfast',
    //         style: TextStyle(decoration: TextDecoration.none, fontSize: 20),
    //       ),
    //       subtitle: Text(
    //           '${DateTime.now().year} / ${DateTime.now().month} / ${DateTime.now().day}'),
    //       trailing: const Icon(
    //         Icons.check_box,
    //         color: Colors.orange,
    //       ),
    //     ),
    //   ],
    // );
  }

  Widget _taskView() {
    Hive.openBox;
    return FutureBuilder(
      future: Hive.openBox('task'),
      // future: Future.delayed(
      //   const Duration(seconds: 2),
      // ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _box = snapshot.data;
          return _taskList();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // Action Button Function to Create Floating Action Button
  Widget _actionButton() {
    return FloatingActionButton(
      onPressed: _displayTaskPopup,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  void _displayTaskPopup() {
    showDialog(
      context: context,
      // ignore: no_leading_underscores_for_local_identifiers
      builder: (BuildContext _context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            onSubmitted: (value) {
              if (_newTaskContent != null) {
                var task = Task(
                    content: _newTaskContent!,
                    timestamp: DateTime.now(),
                    done: false);
                _box!.add(task.toMap());
                setState(() {
                  _newTaskContent = null;
                  Navigator.pop(context);
                });
              }
            },
            onChanged: (value) {
              setState(
                () {
                  _newTaskContent = value;
                },
              );
            },
          ),
        );
      },
    );
  }
}
