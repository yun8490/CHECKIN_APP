import 'package:flutter/material.dart';
// CustomAppBar가 있는 파일을 import
import '../widgets/custom_app_bar.dart';

class AttendanceStatusPage extends StatelessWidget {
  const AttendanceStatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단에 CustomAppBar 사용
      backgroundColor: Color(0xFFf3f4f6),
      appBar: AppBar(
        backgroundColor: Color(0xFFf3f4f6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 1) 차시별 출석률(지원금)
            _buildSessionAttendanceCard(),
            const SizedBox(height: 16),
            // 2) 수업별 출석률(학점)
            _buildCourseAttendanceCard(),
            const SizedBox(height: 16),
            // 3) 전체 출석률
            _buildTotalAttendanceCard(),
          ],
        ),
      ),
    );
  }

  // ------------------ 차시별 출석률(지원금) ------------------
  Widget _buildSessionAttendanceCard() {
    Color progressColor = Color(0xFF3374F6); // 파란색
    return Card(
      color: Colors.white,
      elevation: 0, // 그림자 제거
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '차시별 출석률(지원금)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildProgressRow(
              label: '1차시',
              value: 1.0,
              percentText: '100%',
              progressColor: progressColor,
            ),
            const SizedBox(height: 12),
            _buildProgressRow(
              label: '2차시',
              value: 0.85,
              percentText: '85%',
              progressColor: progressColor,
            ),
            const SizedBox(height: 12),
            _buildProgressRow(
              label: '3차시',
              value: 0.75,
              percentText: '75%',
              progressColor: progressColor,
            ),
            const SizedBox(height: 12),
            _buildProgressRow(
              label: '4차시',
              value: 0.65,
              percentText: '65%',
              progressColor: progressColor,
            ),
            const SizedBox(height: 16),
            const Text(
              '예상 수령 금액: 320,000원',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------ 수업별 출석률(학점) ------------------
  Widget _buildCourseAttendanceCard() {
    Color progressColor = Colors.green; // 초록색
    return Card(
      color: Colors.white,
      elevation: 0, // 그림자 제거
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '수업별 출석률(학점)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildProgressRow(
              label: 'SW전공인턴십실습프로젝트(2학점)',
              value: 0.3,
              percentText: '30%',
              progressColor: progressColor,
            ),
            const SizedBox(height: 12),
            _buildProgressRow(
              label: 'SW전공인턴십실습프로젝트(3학점)',
              value: 0.25,
              percentText: '25%',
              progressColor: progressColor,
            ),
            const SizedBox(height: 12),
            _buildProgressRow(
              label: 'SW전공인턴십실습프로젝트(4학점)',
              value: 0.4,
              percentText: '40%',
              progressColor: progressColor,
            ),
            const SizedBox(height: 12),
            _buildProgressRow(
              label: 'SW전공인턴십실습프로젝트(5학점)',
              value: 0.7,
              percentText: '70%',
              progressColor: progressColor,
            ),
          ],
        ),
      ),
    );
  }

  // ------------------ 전체 출석률 ------------------
  Widget _buildTotalAttendanceCard() {
    Color progressColor = Colors.red; // 빨간색
    return Card(
      color: Colors.white,
      elevation: 0, // 그림자 제거
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '전체 출석률',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildProgressRow(
              label: '전체 출석률',
              value: 1.0,
              percentText: '100%',
              progressColor: progressColor,
            ),
            const SizedBox(height: 16),
            // 출석/지각/결석 정보
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: const [
                    Text('출석', style: TextStyle(color: Colors.black54)),
                    SizedBox(height: 4),
                    Text('24회', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: const [
                    Text('지각', style: TextStyle(color: Colors.black54)),
                    SizedBox(height: 4),
                    Text('24회', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: const [
                    Text('결석', style: TextStyle(color: Colors.black54)),
                    SizedBox(height: 4),
                    Text('0회', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ------------------ 공통 함수: 라벨 + 진행도 + 퍼센트 ------------------
  Widget _buildProgressRow({
    required String label,
    required double value,
    required String percentText,
    required Color progressColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade300,
                  color: progressColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(percentText, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}
