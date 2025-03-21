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

  // 날짜별 출결 정보 저장 (출석, 지각, 결석 횟수)
  Map<DateTime, Map<String, int>> attendanceData = {
    DateTime(2025, 3, 21): {
      '출석': 8,
      '지각': 1,
      '결석': 2,
    },
    DateTime(2025, 3, 22): {
      '출석': 5,
      '지각': 3,
      '결석': 0,
    },
    DateTime(2025, 3, 23): {
      '출석': 6,
      '지각': 2,
      '결석': 1,
    },
  };

  // 날짜 클릭 시 출결현황 박스를 보이게 하거나 숨기는 함수
  void _onDaySelected(DateTime selectedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });

    // BottomSheet로 출결현황 박스 띄우기
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 모달창 크기 조정 가능하게 설정
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          height:
              MediaQuery.of(context).size.height * 0.65, // 화면 높이의 65%까지만 모달을 띄움
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
              // 시간별 리스트
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

  // 출결 현황을 시간별로 보여주는 위젯
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

  // 출결 횟수 표시를 달력 셀에 나타내는 함수
  Widget _buildAttendanceSummary(DateTime date) {
    // 날짜에 대한 출결 정보 가져오기
    var data = attendanceData[date];
    if (data == null) return Container(); // 데이터가 없으면 빈 컨테이너 반환

    return Container(
      padding: const EdgeInsets.all(4),
      color: Colors.white.withOpacity(0.8),
      child: Column(
        children: [
          Text(
            '결석: ${data['결석'] ?? 0}',
            style: GoogleFonts.roboto(color: Colors.red),
          ),
          Text(
            '지각: ${data['지각'] ?? 0}',
            style: GoogleFonts.roboto(color: Colors.orange),
          ),
          Text(
            '출석: ${data['출석'] ?? 0}',
            style: GoogleFonts.roboto(color: Colors.green),
          ),
        ],
      ),
    );
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
                  markerBuilder: (context, date, events) {
                    // 출결 현황을 표시하는 함수
                    var data = attendanceData[date];
                    if (data == null) return SizedBox(); // 데이터가 없으면 빈 컨테이너 반환

                    return Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        color: Colors.white.withOpacity(0.8),
                        child: Column(
                          children: [
                            Text(
                              '결석: ${data['결석'] ?? 0}',
                              style: GoogleFonts.roboto(color: Colors.red),
                            ),
                            Text(
                              '지각: ${data['지각'] ?? 0}',
                              style: GoogleFonts.roboto(color: Colors.orange),
                            ),
                            Text(
                              '출석: ${data['출석'] ?? 0}',
                              style: GoogleFonts.roboto(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          ],
        ),
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
