import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pollapp/Core/app_constants/colors.dart';
import 'package:pollapp/Presentation/Widgets/custom_widget.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isDarkMode;

  const CustomAppBar({super.key, this.title = "",this.isDarkMode=false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: isDarkMode?AppColor.darkBackground:AppColor.lightBackground,
      elevation: 0,
      leading: IconButton(
        icon:
        CustomWidget.iconWidget(icon:Icons.arrow_back,iconColor:Colors.white,isDarkMode: isDarkMode),
        onPressed: () => Get.back(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
