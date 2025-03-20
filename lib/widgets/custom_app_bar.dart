import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // systemOverlayStyle 설정용

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onProfilePressed;
  final VoidCallback? onNotificationsPressed;
  final VoidCallback? onMenuPressed;

  const CustomAppBar({
    Key? key,
    this.onProfilePressed,
    this.onNotificationsPressed,
    this.onMenuPressed,
    required String titleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFFf3f4f6),
      // surfaceTintColor가 투명하면, Material 3의 오버레이 효과가 적용되지 않습니다.
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 8, top: 8),
        child: Image.asset(
          'assets/logo3.png', // ✅ assets 폴더 경로 포함
          width: 70,
          height: 70, // 원하는 높이로 조정
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10), // 🔹 아이콘들을 왼쪽으로 이동
          child: Row(
            mainAxisSize: MainAxisSize.min, // 🔹 최소 크기로 맞춤
            children: [
              // IconButton(
              //   icon: const Icon(Icons.person, color: Color(0xFFa6a6a6)),
              //   iconSize: 27,
              //   onPressed: onProfilePressed,
              // ),
              IconButton(
                icon: const Icon(Icons.notifications, color: Color(0xFFa6a6a6)),
                iconSize: 27,
                onPressed: onNotificationsPressed,
              ),
              IconButton(
                icon: const Icon(Icons.menu, color: Color(0xFFa6a6a6)),
                iconSize: 27,
                onPressed: onMenuPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
