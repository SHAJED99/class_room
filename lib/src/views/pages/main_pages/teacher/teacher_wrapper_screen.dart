// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:class_room/app_constants.dart';
import 'package:class_room/src/views/pages/main_pages/teacher/teacher_screens/add_question_screen.dart';
import 'package:class_room/src/views/pages/main_pages/teacher/teacher_screens/teacher_home_screen.dart';
import 'package:class_room/src/views/widgets/buttons/bottom_nav_bar.dart';
import 'package:class_room/src/views/widgets/other/custom_alive.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class TeacherWrappedScreen extends StatefulWidget {
  const TeacherWrappedScreen({super.key});

  @override
  State<TeacherWrappedScreen> createState() => _TeacherWrappedScreenState();
}

class _TeacherWrappedScreenState extends State<TeacherWrappedScreen> {
  List<Tuple2<Widget, IconData>> pageList = [
    Tuple2(TeacherHomeScreen(), Icons.home),
    Tuple2(Container(), Icons.edit_note_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: [for (var e in pageList) CustomAlive(child: e.item1)],
      ),
      bottomNavigationBar: Row(
        children: [
          for (var e in pageList)
            BottomNavBar(
              onTap: () {},
              child: Icon(e.item2),
            ),
        ],
      ),
    );
  }
}
