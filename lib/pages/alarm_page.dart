import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

// 간단한 알림 데이터 모델
class AlarmItem {
  final String title; // 알림 제목
  final String time; // 예: "방금 전", "2시간 전", "어제", 날짜 등
  bool isRead; // 읽었는지 여부를 나타내는 속성

  AlarmItem(this.title, this.time, {this.isRead = false});
}

class AlarmPage extends StatefulWidget {
  AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  // 예시 알림 데이터
  final List<AlarmItem> alarms = [
    AlarmItem('3월 신학기 출석체크 시스템 업데이트 안내', '방금 전', isRead: true), // 읽은 알림
    AlarmItem('2024학년도 1학기 시간표 변경 안내', '2시간 전'),
    AlarmItem('도서관 운영시간 변경 안내', '어제', isRead: true), // 읽은 알림
    AlarmItem('통계학과 방학 수학일정 안내', '2024.01.15'),
    AlarmItem('2024년도 1학기 장학금 신청 안내', '2024.01.13', isRead: true), // 읽은 알림
    AlarmItem('겨울방학 기간 도서관 이용 안내', '2024.01.13'),
  ];

  // 전체 읽음 처리
  void markAllAsRead() {
    setState(() {
      for (var alarm in alarms) {
        alarm.isRead = true; // 모든 알림을 읽음 처리
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F4F6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFFf3f4f6),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 "최근 알림" + "전체 없음" 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '최근 알림',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: markAllAsRead, // "전체 읽음" 버튼 클릭 시 호출
                  child: const Text(
                    '전체 읽음',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 알림 목록
            Expanded(
              child: ListView.separated(
                itemCount: alarms.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final alarm = alarms[index];
                  return _buildAlarmItem(alarm);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 알림 아이템
  Widget _buildAlarmItem(AlarmItem alarm) {
    return GestureDetector(
      onTap: () {
        // 알림 클릭 시 읽음 상태로 변경
        setState(() {
          alarm.isRead = true;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // 읽지 않은 알림은 파란색 원, 읽은 알림은 회색 원 아이콘으로 표시
                Icon(
                  Icons.circle,
                  size: 8,
                  color: alarm.isRead
                      ? Colors.grey
                      : Colors.blue, // 읽은 알림은 회색, 읽지 않은 알림은 파란색
                ),
                const SizedBox(width: 8),
                Text(
                  alarm.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black, // 텍스트 색상 검은색으로 변경
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // 시간
            Text(
              alarm.time,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black, // 텍스트 색상 검은색으로 변경
              ),
            ),
          ],
        ),
      ),
    );
  }
}
