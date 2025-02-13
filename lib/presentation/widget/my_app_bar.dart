import 'package:flutter/material.dart';

import '../../common/constant/constant.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onPressed;
  const MyAppBar({super.key, required this.title, required this.onPressed});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      leading: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: kPurple,
        ),
      ),
      elevation: 0,
      title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
      centerTitle: true,
      shape: Border(
        bottom: BorderSide(color: kLightGray, width: 1),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
