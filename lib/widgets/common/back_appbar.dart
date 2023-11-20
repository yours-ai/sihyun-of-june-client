import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import '../../constants.dart';

class BackAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const BackAppbar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.background,
      elevation: 0,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: Container(
          padding: const EdgeInsets.only(left: 15),
          child: Icon(
            PhosphorIcons.arrow_left,
            color: ColorConstants.gray,
            size: 32,
          ),
        ),
      ),
    );
  }
}
