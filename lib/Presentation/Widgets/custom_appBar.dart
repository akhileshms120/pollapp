import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pollapp/Core/app_constants/colors.dart';
import 'package:pollapp/Core/app_constants/routes_constant.dart';
import 'package:pollapp/Presentation/Widgets/custom_widget.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isDarkMode;
  final double fontSize;

  const CustomAppBar({super.key, this.title = "",this.isDarkMode=false,this.fontSize=25});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomWidget.customTextWidget(text: title,fontSize:fontSize,textColor:AppColor.getTextColor(isDarkMode) ),
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


class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: GestureDetector(
        onTap: ()=>Get.toNamed(RoutesName.keralaPoliceScreen),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey, 
                child: Image.asset("assets/images/homeblack.png")
              ),
            ),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'KERALA POLICE',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  'Soft in Temperament, Firm in Action',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () {
            Get.toNamed(RoutesName.searchScreen);
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black),
          onPressed: () {
          },
        ),
      ],
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


