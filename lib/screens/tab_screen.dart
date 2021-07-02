import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sekolahku/screens/student/home_screen.dart';
import 'package:sekolahku/screens/teacher/teacher_home_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.assignment_ind_rounded)),
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              HomeScreen(),
              TeacherHomeScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
