// ignore_for_file: avoid_print

import 'package:capstone/authentication/main_page.dart';
import 'package:capstone/board/board_page.dart';
import 'package:capstone/home/home_page.dart';
import 'package:capstone/main.dart';
import 'package:capstone/mypage/my_page.dart';
import 'package:capstone/timetable/timetable_page.dart';
import 'package:flutter/material.dart';
import 'package:capstone/groups/group_page.dart'; // 스터디 그룹

import 'package:firebase_auth/firebase_auth.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const TimeTablePage(),
    const BoardPage(),
    GroupPage(), // 스터디 그룹 페이지 연결
    const MyPage()
  ];

  @override
  void initState() {
    super.initState();

    _checkState();
  }

  Future<void> _checkState() async {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
          );
        }
      }
    });

    if (appUser == null) {
      await fetchUserData();
    }

    print(appUser?.userName);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: _pages[_currentIndex], // 페이지와 연결
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("홈"),
                selectedColor: Colors.purple),
            SalomonBottomBarItem(
                icon: const Icon(Icons.calendar_today_rounded),
                title: const Text("시간표"),
                selectedColor: Colors.pink),
            SalomonBottomBarItem(
                icon: const Icon(Icons.question_answer_rounded),
                title: const Text("질의응답"),
                selectedColor: Colors.orange),
            SalomonBottomBarItem(
                icon: const Icon(Icons.group),
                title: const Text("스터디그룹"),
                selectedColor: Colors.teal),
            SalomonBottomBarItem(
                icon: const Icon(Icons.person),
                title: const Text("마이페이지"),
                selectedColor: Colors.blueGrey)
          ],
        ),
      ),
    );
  }
}
