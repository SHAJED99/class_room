import 'package:class_room/src/views/pages/main_pages/student/student_screens/student_home_screen.dart';
import 'package:class_room/src/views/widgets/buttons/bottom_nav_bar.dart';
import 'package:class_room/src/views/widgets/other/custom_alive.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class StudentWrappedScreen extends StatefulWidget {
  const StudentWrappedScreen({super.key});

  @override
  State<StudentWrappedScreen> createState() => _StudentWrappedScreenState();
}

class _StudentWrappedScreenState extends State<StudentWrappedScreen> {
  List<Tuple2<Widget, IconData>> pageList = [
    const Tuple2(StudentHomeScreen(), Icons.home),
    Tuple2(Container(), Icons.edit_note_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
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
