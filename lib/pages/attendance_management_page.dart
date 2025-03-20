import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceManagementPage extends StatefulWidget {
  const AttendanceManagementPage({Key? key}) : super(key: key);

  @override
  _AttendanceManagementPageState createState() =>
      _AttendanceManagementPageState();
}

class _AttendanceManagementPageState extends State<AttendanceManagementPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now(); // the currently focused day
  bool _isAttendanceBoxVisible = false;
  double _attendanceBoxHeight = -300; // 처음에는 숨김 상태로 시작

  // 날짜 클릭 시 출결현황 박스를 보이게 하거나 숨기는 함수
  void _onDaySelected(DateTime selectedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });

    // BottomSheet로 출결현황 박스 띄우기 (높이 조정)
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 모달창 크기 조정 가능하게 설정
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          height:
              MediaQuery.of(context).size.height * 0.65, // 화면 높이의 60%까지만 모달을 띄움
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Color(0xFF3374F6),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // 컨텐츠 높이에 맞게 설정
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_selectedDay.year}년 ${_selectedDay.month}월 ${_selectedDay.day}일 출결현황',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                // 스크롤 가능하도록 설정
                child: ListView(
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
                    const SizedBox(height: 20), // 맨 아래 여백 추가 (너무 붙지 않도록)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 출결현황 박스를 닫는 함수
  void _closeAttendanceBox() {
    Navigator.pop(context); // BottomSheet 닫기
  }

  // 터치로 박스를 내릴 때
  void _onTapToClose() {
    Navigator.pop(context); // BottomSheet 닫기
  }

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
        // 전체 내용을 스크롤 가능하게 만듬
        child: Column(
          children: [
            // Custom Header (날짜, 이전/다음 버튼)
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // 왼쪽 날짜, 오른쪽 버튼
                children: [
                  // 날짜 텍스트 왼쪽 정렬
                  Text(
                    '${_focusedDay.year}년 ${_focusedDay.month}월',
                    style: GoogleFonts.roboto(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  // 이전/다음 버튼
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_left),
                        onPressed: () {
                          setState(() {
                            _focusedDay = DateTime(
                                _focusedDay.year, _focusedDay.month - 1);
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_right),
                        onPressed: () {
                          setState(() {
                            _focusedDay = DateTime(
                                _focusedDay.year, _focusedDay.month + 1);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // TableCalendar 위젯
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return day.isSameDate(_selectedDay);
              },
              onDaySelected: (selectedDay, focusedDay) {
                _onDaySelected(selectedDay);
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Color(0xFF3374F6),
                  shape: BoxShape.circle,
                ),
                defaultTextStyle:
                    GoogleFonts.roboto(fontWeight: FontWeight.bold),
                weekendTextStyle: GoogleFonts.roboto(
                    color: Colors.red, fontWeight: FontWeight.bold),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false, // "형식" 버튼 숨기기
                leftChevronVisible: false, // 기본 "이전" 버튼 숨기기
                rightChevronVisible: false, // 기본 "다음" 버튼 숨기기
                titleCentered: false, // 제목 중앙 정렬 비활성화
                titleTextStyle: TextStyle(color: Colors.transparent),
                headerPadding: EdgeInsets.only(bottom: 0), // 상단 간격을 줄이기
              ),
              daysOfWeekHeight: 20, // 요일 높이 수정 (기본값보다 높게 설정하여 텍스트가 잘리지 않도록)
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  final koreanWeekdays = [
                    '일',
                    '월',
                    '화',
                    '수',
                    '목',
                    '금',
                    '토'
                  ]; // 한글 요일
                  return Center(
                    child: Text(
                      koreanWeekdays[day.weekday % 7], // 일요일부터 토요일까지 한글로 표시
                      style: GoogleFonts.roboto(
                        color: day.weekday == DateTime.saturday ||
                                day.weekday == DateTime.sunday
                            ? Colors.red
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 시간 슬롯 하나 (흰색 카드 + "결석/지각/출석" 색상)
  Widget _buildTimeSlot(String timeRange, String status, Color statusColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              timeRange,
              style: GoogleFonts.roboto(fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            status,
            style: GoogleFonts.roboto(
                color: statusColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// DateTimeComparison 확장 추가 (isSameDate 메서드 정의)
extension DateTimeComparison on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
