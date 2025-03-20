import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F4F6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ────────────── 프로필 영역 ──────────────
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10), // 오른쪽으로 10 이동
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade300,
                        child: const Icon(Icons.person,
                            size: 45, color: Color(0xFF9CA3AF)),
                      ),
                    ),
                    const SizedBox(width: 10), // 아이콘과 텍스트 사이 여백 추가
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '김민지',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            '내 정보 관리',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(), // 아이콘을 오른쪽 정렬
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded,
                          color: Color(0xFF9CA3AF)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
            // ────────────── 홈, 출석률 현황, 출결 관리, 공지사항 영역 ──────────────
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 0,
              child: Column(
                children: [
                  _buildMenuItem(Icons.home, '홈', onTap: () {
                    Navigator.pushNamed(context, '/');
                  }),
                  _buildMenuItem(Icons.bar_chart, '출석률 현황', onTap: () {
                    Navigator.pushNamed(context, '/status');
                  }),
                  _buildMenuItem(Icons.edit_calendar, '출결 관리', onTap: () {
                    Navigator.pushNamed(context, '/attendance');
                  }),
                  _buildMenuItem(Icons.campaign, '공지사항', onTap: () {
                    Navigator.pushNamed(context, '/notice');
                  }),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // ────────────── 알림, 설정 영역 ──────────────
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 0,
              child: Column(
                children: [
                  _buildMenuItem(Icons.notifications, '알림', onTap: () {
                    Navigator.pushNamed(context, '/alarm');
                  }),
                  _buildMenuItem(Icons.settings, '설정', onTap: () {}),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // ────────────── 로그아웃 영역 ──────────────
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 0,
              child: _buildMenuItem(Icons.logout, '로그아웃', onTap: () {
                // 로그아웃 기능 추가
              }),
            ),
          ],
        ),
      ),
    );
  }

  // 메뉴 아이템 빌더
  Widget _buildMenuItem(IconData icon, String label, {VoidCallback? onTap}) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Icon(icon, color: Colors.black),
      ),
      title: Text(label, style: const TextStyle(fontSize: 15)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded,
          size: 15, color: Color(0xFF9CA3AF)),
      onTap: onTap,
    );
  }
}
