import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

// 간단한 공지사항 데이터 모델
class Notice {
  final String title; // 공지 제목
  final String time; // 게시 시간 (예: "방금 전", "2시간 전", "어제", "2024.01.13" 등)
  bool isRead; // 읽었는지 여부를 저장

  Notice(this.title, this.time, {this.isRead = false});
}

// 공지사항 세부 페이지
class NoticeDetailPage extends StatelessWidget {
  final Notice notice;

  NoticeDetailPage({required this.notice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F4F6), // 공지사항 페이지와 동일한 배경색
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: const Color(0xFFF3F4F6), // 전체 배경색을 공지사항 페이지와 동일한 회색으로 설정
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목을 포함한 컨테이너 박스
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white, // 세부 공지사항의 배경을 흰색으로 설정
                borderRadius: BorderRadius.circular(8),
                // 그림자 제거
                boxShadow: [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notice.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '작성일: ${notice.time}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  // 공지 세부 내용
                  Text(
                    '2024년 1학기부터 출석체크 시스템이 다음과 같이 변경됩니다:\n\n'
                    '● QR코드 기반 출석체크 시스템 도입\n'
                    '● 실시간 출석 현황 확인 기능 추가\n'
                    '● 결석 사유서 온라인 제출 시스템 구축\n\n'
                    '새로운 시스템은 2024년 3월 2일부터 전면 시행될 예정입니다.\n\n'
                    '자세한 사항은 첨부된 매뉴얼을 참고해 주시기 바랍니다.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  // 매뉴얼 다운로드 버튼 추가
                  _buildDownloadButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 매뉴얼 다운로드 버튼 UI
  Widget _buildDownloadButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white, // 흰색 배경
        borderRadius: BorderRadius.circular(30), // 둥근 모서리
        border: Border.all(color: Color(0xFFBDBDBD)), // 회색 테두리
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.picture_as_pdf, // PDF 아이콘
            color: Color(0xFF4B4B4B), // 아이콘 색
            size: 18,
          ),
          SizedBox(width: 10), // 아이콘과 텍스트 사이 간격
          Text(
            '매뉴얼 다운로드',
            style: TextStyle(
              color: Color(0xFF4B4B4B), // 텍스트 색
              fontSize: 14, // 텍스트 크기
              fontWeight: FontWeight.w500, // 텍스트 두께
            ),
          ),
        ],
      ),
    );
  }
}

class NoticePage extends StatefulWidget {
  NoticePage({Key? key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  // 예시 공지사항 데이터
  final List<Notice> notices = [
    Notice('3월 신학기 출석체크 시스템 업데이트 안내', '방금 전'),
    Notice('2024학년도 1학기 시간표 변경 안내', '2시간 전'),
    Notice('도서관 운영시간 변경 안내', '어제'),
    Notice('통계학과 방학 수학일정 안내', '2024.01.15'),
    Notice('2024년도 1학기 장학금 신청 안내', '2024.01.13'),
    Notice('겨울방학 기간 도서관 이용 안내', '2024.01.13'),
  ];

  // 페이지 네비게이션을 위한 페이지 번호
  int currentPage = 1;
  int itemsPerPage = 6;

  @override
  Widget build(BuildContext context) {
    // 페이지에 맞는 공지사항 데이터 필터링
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    List<Notice> currentNotices = notices.sublist(
        startIndex, endIndex > notices.length ? notices.length : endIndex);

    // 전체 페이지 수 계산
    int totalPages = (notices.length / itemsPerPage).ceil();

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
      backgroundColor: const Color(0xFFF3F4F6), // 공지사항 페이지와 동일한 배경색
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1) 페이지 타이틀
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Text(
              '공지사항',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
                fontFamily: 'Roboto', // Roboto 폰트 적용
              ),
            ),
          ),

          // 2) 공지사항 목록 (ListView)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView.separated(
                itemCount: currentNotices.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final notice = currentNotices[index];
                  return _buildNoticeItem(notice, context);
                },
              ),
            ),
          ),

          // 3) 페이지네이션 영역
          Padding(
            padding: const EdgeInsets.only(bottom: 140, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalPages, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _buildPageButton('${index + 1}', onPressed: () {
                    setState(() {
                      currentPage = index + 1;
                    });
                  }),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // 공지사항 아이템 UI
  Widget _buildNoticeItem(Notice notice, BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          notice.isRead = true; // 클릭 시 읽은 상태로 변경
        });
        // 클릭 시 NoticeDetailPage로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoticeDetailPage(notice: notice),
          ),
        );
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
        child: Row(
          children: [
            // 읽음 여부 아이콘 (왼쪽에 배치)
            Icon(
              Icons.circle,
              color: notice.isRead ? Colors.green : Colors.red,
              size: 10, // 글자 크기에 맞게 아이콘 크기 조정
            ),
            const SizedBox(width: 12), // 아이콘과 제목 간의 간격

            // 공지 제목
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notice.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto', // Roboto 폰트 적용
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 작성 시간
                  Text(
                    notice.time,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      fontFamily: 'Roboto', // Roboto 폰트 적용
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 페이지 번호 버튼
  Widget _buildPageButton(String text, {void Function()? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: text == '$currentPage' ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: text == '$currentPage' ? Colors.blue : Colors.transparent,
          ),
        ),
        child: text == '$currentPage'
            ? Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  fontSize: 14,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  fontSize: 14,
                ),
              ),
      ),
    );
  }
}
