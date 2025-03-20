import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // systemOverlayStyle 설정용
import 'package:intl/date_symbol_data_local.dart';
import 'pages/home_page.dart';
import 'pages/menu_page.dart';
import 'pages/attendance_management_page.dart';
import 'pages/attendance_status_page.dart';
import 'pages/notice_page.dart';
import 'pages/alarm_page.dart';
import 'pages/profile_page.dart';
// (다른 페이지들도 import)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko_KR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CheckIn App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // AppBar에 대한 기본 테마 설정
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark, // 상태 표시줄 아이콘 색상 등을 고정
        ),
        scaffoldBackgroundColor: Colors.white, // 전체 배경색 지정 (원하는 색으로 변경)
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),             // 홈화면
        '/menu': (context) => const MenuPage(),         // 메뉴화면
        '/attendance': (context) => const AttendanceManagementPage(), // 출결관리화면
        '/status': (context) => const AttendanceStatusPage(),         // 출석률현황화면
        '/notice': (context) => NoticePage(),           // 공지사항화면
        '/alarm': (context) => AlarmPage(),             // 알림함화면
        '/profile': (context) => const ProfilePage(),   // 내정보화면
      },
    );
  }
}
