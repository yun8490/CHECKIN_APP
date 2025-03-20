import 'package:checkinapp/pages/profile_update_page.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf3f4f6),
      // 상단 커스텀 AppBar 사용
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '김민수님의 정보',
          style: TextStyle(
              fontFamily: 'TossProductSans',
              color: Colors.black87,
              fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 프로필 이미지 + 플러스 아이콘
            // const SizedBox(height: 16),
            // _buildProfileSection(),
            // const SizedBox(height: 16),

            // 정보 목록
            Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              elevation: 0,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildProfileSection(),
                  const SizedBox(height: 16),
                  _buildInfoRow('이름', '김민수', context),
                  const SizedBox(height: 1),
                  _buildInfoRow('휴대폰 번호', '010-1234-5678', context),
                  const SizedBox(height: 1),
                  _buildInfoRow('이메일 주소', 'minsu123@cu.ac.kr', context),
                  const SizedBox(height: 1),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // 수정 불가능한 학번, 학과, 학교, 학년 정보 목록
            Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              elevation: 0,
              child: Column(
                children: [
                  const SizedBox(height: 1),
                  _buildInfoRow2('학번', '2021123456'),
                  const SizedBox(height: 1),
                  _buildInfoRow2('학과', '컴퓨터공학과'),
                  const SizedBox(height: 1),
                  _buildInfoRow2('학년', '3학년'),
                  const SizedBox(height: 1),
                  _buildInfoRow2('학교명', '대구가톨릭대학교'),
                  const SizedBox(height: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 1) 프로필 영역 (원형 아바타 + 플러스 아이콘)
  Widget _buildProfileSection() {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 원형 아바타
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
              child: Icon(
                Icons.person,
                size: 65,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            // 플러스 아이콘 (오른쪽 하단)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // TODO: 프로필 이미지 변경 로직
                },
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Color(0xFF9CA3AF),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 2) 수정 가능한 정보 행 (예: "이름" - "김민수")
  //
  Widget _buildInfoRow(String label, String value, BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontFamily: 'TossProductSans', // 등록한 폰트 이름
          color: Colors.black,
          fontSize: 16,
          // fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // Row 크기 최소화
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 13),
            child: Text(value,
                style: TextStyle(
                  fontFamily: 'TossProductSans', // 등록한 폰트 이름
                  color: Color(0xFF9CA3AF),
                  fontSize: 16,
                )),
          ),
          const Icon(Icons.arrow_forward_ios_rounded,
              size: 15, color: Color(0xFF9CA3AF)),
        ],
      ),
      onTap: () {
        // TODO: 수정 페이지 이동 등 (필요하다면)
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileUpdatePage(
                      label: label,
                      value: value,
                    )));
      },
    );
  }

  Widget _buildInfoRow2(String label, String value) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontFamily: 'TossProductSans', // 등록한 폰트 이름
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // Row 크기 최소화
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'TossProductSans', // 등록한 폰트 이름
                color: Color(0xFF9CA3AF),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        // TODO: 수정 페이지 이동 등 (필요하다면)
      },
    );
  }
}
