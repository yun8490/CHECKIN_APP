import 'package:flutter/material.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage(
      {super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  State<ProfileUpdatePage> createState() => _profileUpdatePageState();
}

class _profileUpdatePageState extends State<ProfileUpdatePage> {
  late TextEditingController _controller;
  late FocusNode _focusNode = FocusNode();
  bool _isButtonEnabled = false;
  bool _isCancelIconVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _controller.addListener(_updateButtonState); // 텍스트 변경시 버튼 상태 업데이트
    _focusNode.addListener(_onFocusChange); // 키보드 엔터 클릭시 cancel 아이콘 안보이게 하기
  }

  @override
  void dispose() {
    _controller.removeListener(_updateButtonState);
    _focusNode.removeListener(_onFocusChange);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // 텍스트 병경 시 버튼 상태 업데이트
  void _updateButtonState() {
    setState(() {
      // 이름을 그대로면(변경하지 않았을 경우) true, 변경했다면 false
      _isButtonEnabled =
          (_controller.text == widget.value || _controller.text == '');
      _isCancelIconVisible = true;
    });
  }

  // 키보드 엔터 클릭시 아이콘 버튼 안보이게 하기
  void _onFocusChange() {
    setState(() {
      _isCancelIconVisible = _focusNode.hasFocus && _controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 16, top: 20, bottom: 9),
                child: Text(
                  '${widget.label}을 입력해주세요', // 여기에서 widget.label 사용
                  style: TextStyle(
                    fontFamily: 'TossProductSans',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                '${widget.label}', // 여기에서도 widget.label 사용
                style: TextStyle(
                  fontFamily: 'TossProductSans',
                  fontSize: 14,
                  color:
                      _focusNode.hasFocus ? Color(0xFF3374F6) : Colors.black87,
                ),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
              child: TextField(
                controller: _controller,
                autofocus: true,
                focusNode: _focusNode,
                decoration: InputDecoration(
                    suffixIcon: _isCancelIconVisible
                        ? GestureDetector(
                            onTap: () {
                              _controller.clear();
                              setState(() {
                                _isCancelIconVisible = false;
                              });
                            },
                            child: Icon(
                              Icons.cancel_rounded,
                              color: Color(0xFF9CA3AF),
                              size: 20,
                            ),
                          )
                        : null,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF3374F6)))),
                textInputAction: TextInputAction.go,
                onSubmitted: (value) {
                  // 키보드에서 엔터 터치시 실행하는 부분
                  print('입력한 ${widget.label} : ${_controller.text}');
                  setState(() {
                    _isCancelIconVisible = false;
                  });
                },
                style: TextStyle(
                  fontFamily: 'TossProductSans',
                  fontSize: 17,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedPadding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        duration: const Duration(milliseconds: 0),
        curve: Curves.easeOut,
        child: SizedBox(
          width: double.infinity,
          height: 65,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Color(0xFF3374F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // 둥근 모서리 제거
              ),
            ),
            onPressed: _isButtonEnabled
                ? null // 이름을 변경하지 않았을 때 버튼 비활성화,
                : () {
                    // 이름을 변경하여 작성했을 때 버튼 활성화
                    print('입력한 ${widget.label} : ${_controller.text}');
                  },
            child: const Text(
              '확인',
              style: TextStyle(
                  fontFamily: 'TossProductSans',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
