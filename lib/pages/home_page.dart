// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 시간 포맷팅용
import 'dart:async'; // Timer 사용
import 'package:checkinapp/widgets/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 현재 시각(HH:mm:ss)와 날짜(월,일,요일) 문자열 변수
  String _currentTime = ''; // 예: 14:40:05
  String _currentDate = ''; // 예: 3월 21일 화요일
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // 초기 업데이트
    _updateDateTime();

    // 1초마다 시간/날짜 갱신 (날짜는 굳이 초 단위로 바꿀 필요는 없지만, 간단히 처리)
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateDateTime();
    });
  }

  // 현재 시간과 날짜를 업데이트
  void _updateDateTime() {
    // 로컬 시간
    final now = DateTime.now().toLocal();
    // 시분초 포맷
    final timeFormatted = DateFormat('HH:mm:ss').format(now);
    // 날짜+요일 (예: "3월 21일 화요일")
    final dateFormatted = DateFormat('M월 d일 EEEE', 'ko_KR').format(now);

    setState(() {
      _currentTime = timeFormatted;
      _currentDate = dateFormatted;
    });
  }

  @override
  void dispose() {
    // Timer 해제
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf3f4f6),
      // 상단 커스텀 AppBar
      appBar: CustomAppBar(
        onMenuPressed: () {
          Navigator.pushNamed(context, '/menu');
        },
        onNotificationsPressed: () {
          Navigator.pushNamed(context, '/alarm');
        },
        // onProfilePressed: () {
        //   Navigator.pushNamed(context, '/profile');
        // },
        titleText: '',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // (1) 인사말
            // Padding(
            //   padding: const EdgeInsets.only(left: 8), // 🔹 오른쪽으로 16px 이동
            //   child: Text(
            //     '고정윤님, 반가워요!',
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // const SizedBox(height: 16),

            // (2) 출석률 현황 카드
            _buildAttendanceRateCard(),
            const SizedBox(height: 16),

            // (3) 날짜/시간 + 출석 버튼 카드
            Card(
              elevation: 0, // 그림자 제거
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: const Color(0xFF3374F6),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // ★ 왼쪽 정렬 적용
                  children: [
                    // 날짜/요일 표시 (왼쪽 정렬)
                    Text(
                      '오늘은 $_currentDate이에요 :)',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 8),

                    // 시간을 포함한 Column (왼쪽 정렬)
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // ★ 텍스트 왼쪽 정렬
                      children: [
                        Text(
                          _currentTime,
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 16), // 버튼과 시간 사이 간격 조절
                        SizedBox(
                          width: double.infinity, // 버튼을 카드 가로 폭에 맞게 확장
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: 출석 처리 로직
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, // 버튼 배경색
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(15), // ★ 모서리 둥글게
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14), // 버튼 높이 조정
                            ),
                            child: const Text(
                              '출석',
                              style: TextStyle(
                                  fontFamily: 'SpoqaHanSans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF3374F6)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // (4) 출결관리 카드
            _buildAttendanceCard(),
            const SizedBox(height: 16),

            // (5) 공지사항 카드
            _buildNoticeCard(),
          ],
        ),
      ),
    );
  }

  // 출석률 현황 카드 (예시)
  Widget _buildAttendanceRateCard() {
    final ValueNotifier<double> _scaleNotifier = ValueNotifier(1.0);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/status');
      },
      onTapDown: (_) => _scaleNotifier.value = 0.95, // 클릭 시 작아짐
      onTapUp: (_) => _scaleNotifier.value = 1.0, // 손을 떼면 원래 크기로 복귀
      onTapCancel: () => _scaleNotifier.value = 1.0, // 클릭 취소 시 원래 크기로 복귀
      child: ValueListenableBuilder<double>(
        valueListenable: _scaleNotifier,
        builder: (context, scale, child) {
          return AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            child: child,
          );
        },
        child: Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('고정윤',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            const SizedBox(width: 5),
                            const Text('님이',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500))
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              '풀스택과 함께한 시간',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 4),
                            Image.asset(
                              'assets/flower2.png',
                              width: 40,
                              height: 40,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Transform.translate(
                      offset: Offset(-8, 0),
                      child: GestureDetector(
                        // 클릭 이벤트 추가
                        onTap: () {
                          Navigator.pushNamed(context, '/profile'); // 페이지 이동
                        },
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFE0E0E0),
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 45,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('현재 차시 출석률',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6B7280))),
                    Text('80%',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF3374F6))),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.4,
                    minHeight: 8,
                    backgroundColor: Color(0xFFE5E7EB),
                    color: Color(0xFF3374F6),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('현재 교과목 출석률',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6B7280))),
                    Text('95%',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF3374F6))),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.8,
                    minHeight: 8,
                    backgroundColor: Color(0xFFE5E7EB),
                    color: Color(0xFF3374F6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 출결관리 카드 (예시)
  Widget _buildAttendanceCard() {
    final ValueNotifier<double> _scaleNotifier = ValueNotifier(1.0);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/attendance');
      },
      onTapDown: (_) => _scaleNotifier.value = 0.95, // 터치 시 축소
      onTapUp: (_) => _scaleNotifier.value = 1.0, // 터치 해제 시 복구
      onTapCancel: () => _scaleNotifier.value = 1.0, // 터치 취소 시 복구
      child: ValueListenableBuilder<double>(
        valueListenable: _scaleNotifier,
        builder: (context, scale, child) {
          return AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            child: child,
          );
        },
        child: Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 0, // 그림자 제거
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('출결관리',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildAttendanceCircle('09:00', Colors.green),
                    _buildAttendanceCircle('10:00', Colors.green),
                    _buildAttendanceCircle('11:00', Colors.green),
                    _buildAttendanceCircle('13:00', Colors.red),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildAttendanceCircle('14:00', Colors.green),
                    _buildAttendanceCircle('15:00', Colors.green),
                    _buildAttendanceCircle('16:00', Colors.green),
                    _buildAttendanceCircle('17:00', Colors.green),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLegend(Colors.green, '출석'),
                    _buildLegend(Colors.red, '결석'),
                    _buildLegend(Colors.orange, '지각'),
                    _buildLegend(Color(0xFFD1D5DB), '미정'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 공지사항 카드 (예시)
  Widget _buildNoticeCard() {
    final ValueNotifier<double> _scaleNotifier = ValueNotifier(1.0);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/notice');
      },
      onTapDown: (_) => _scaleNotifier.value = 0.95, // 터치 시 축소
      onTapUp: (_) => _scaleNotifier.value = 1.0, // 터치 해제 시 원래 크기로 복구
      onTapCancel: () => _scaleNotifier.value = 1.0, // 터치 취소 시 복구
      child: ValueListenableBuilder<double>(
          valueListenable: _scaleNotifier,
          builder: (context, scale, child) {
            return AnimatedScale(
              scale: scale,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              child: child,
            );
          },
          child: Container(
            width: double.infinity, // 🔥 전체 너비 차지
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 0, // 그림자 제거
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('공지사항',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const _NoticeItem(
                          title: '2024년도 1학기 출석체크 시스템 변경..',
                          date: '2024.01.15'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const _NoticeItem(
                          title: '겨울방학 기간 출석체크 운영 안내', date: '2024.01.10'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const _NoticeItem(
                          title: '모바일 웹 업데이트 안내 (v2.1.0)', date: '2024.01.15'),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  // 출결관리 시간 + 동그라미
  Widget _buildAttendanceCircle(String time, Color color) {
    return Column(
      children: [
        Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        CircleAvatar(radius: 10, backgroundColor: color),
      ],
    );
  }

  // 출결관리 범례
  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}

// 공지사항 아이템
class _NoticeItem extends StatelessWidget {
  final String title;
  final String date;

  const _NoticeItem({Key? key, required this.title, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
