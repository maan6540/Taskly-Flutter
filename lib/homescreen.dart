import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: unused_field
  late double _devicewidth, _deviceheight;

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
      body: _taskList(),
      floatingActionButton: _actionButton(),
    );
  }

  // TaskList Function to Create Task
  Widget _taskList() {
    return ListView(
      children: [
        ListTile(
          title: const Text(
            'Lunch',
            style:
                TextStyle(decoration: TextDecoration.lineThrough, fontSize: 20),
          ),
          subtitle: Text(
              '${DateTime.now().year} / ${DateTime.now().month} / ${DateTime.now().day}'),
          trailing: const Icon(
            Icons.check_box_outlined,
            color: Colors.orange,
          ),
        ),
        ListTile(
          title: const Text(
            'Breakfast',
            style: TextStyle(decoration: TextDecoration.none, fontSize: 20),
          ),
          subtitle: Text(
              '${DateTime.now().year} / ${DateTime.now().month} / ${DateTime.now().day}'),
          trailing: const Icon(
            Icons.check_box,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  // Action Button Function to Create Floating Action Button
  Widget _actionButton() {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
