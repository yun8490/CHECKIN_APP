import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceManagementPage extends StatelessWidget {
  const AttendanceManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0), // 간격 조정
        child: Column(
          children: [
            // 1) 달력 부분 (앱 넓이를 다 쓰는 실제 달력)
            _buildCalendar(),
            // SizedBox(height: 16),
            // 2) 선택된 날짜(2월 5일) 출결 현황 (파란색 박스)
            _buildAttendanceDetailBox(),
          ],
        ),
      ),
    );
  }

  // 실제 달력을 표시하는 위젯
  Widget _buildCalendar() {
    return TableCalendar(
      locale: 'ko_KR', // 한글 설정
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, date) {
          return Align(
            alignment: Alignment.center,
            child: Text(
              '${date.year}년 ${date.month}월',
              style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          );
        },
        dowBuilder: (context, day) {
          final koreanWeekdays = ['월', '화', '수', '목', '금', '토', '금금'];
          return Center(
            child: Text(
              koreanWeekdays[day.weekday - 1], // 1(월)~7(일)
              style: GoogleFonts.roboto(
                color: day.weekday == DateTime.saturday || day.weekday == DateTime.sunday
                    ? Colors.red
                    : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
      calendarFormat: CalendarFormat.month,
      daysOfWeekHeight: 30,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.blue.shade100,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Color(0xFF3374F6),
          shape: BoxShape.circle,
        ),
        defaultTextStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        weekendTextStyle: GoogleFonts.roboto(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      selectedDayPredicate: (day) {
        return day.day == 5 && day.month == 3; // 3월 5일 선택
      },
    );
  }

  // 파란색 박스 (2024년 2월 5일 출결현황 + 시간별 리스트)
  Widget _buildAttendanceDetailBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF3374F6), // 파란 배경
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // 상단 바 (타이틀 + X 버튼)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '2025년 3월 5일 출결현황',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  // TODO: 닫기 로직
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 시간별 리스트
          Column(
            children: [
              _buildTimeSlot('09:00 ~ 10:00', '결석', Colors.red),
              const SizedBox(height: 8),
              _buildTimeSlot('10:00 ~ 11:00', '지각', Colors.orange),
              const SizedBox(height: 8),
              _buildTimeSlot('11:00 ~ 12:00', '출석', Colors.green),
              const SizedBox(height: 8),
              _buildTimeSlot('13:00 ~ 14:00', '출석', Colors.green),
              const SizedBox(height: 8),
              _buildTimeSlot('14:00 ~ 15:00', '출석', Colors.green),
              const SizedBox(height: 8),
              _buildTimeSlot('15:00 ~ 16:00', '출석', Colors.green),
              const SizedBox(height: 8),
              _buildTimeSlot('16:00 ~ 17:00', '출석', Colors.green),
              const SizedBox(height: 8),
              _buildTimeSlot('17:00 ~ 18:00', '결석', Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  // 시간 슬롯 하나 (흰색 카드 + "결석/지각/출석" 색상)
  Widget _buildTimeSlot(String timeRange, String status, Color statusColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white, // 흰색 배경
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              timeRange,
              style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            status,
            style: GoogleFonts.roboto(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}