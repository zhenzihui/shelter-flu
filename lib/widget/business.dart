import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/colors.dart';
import '../consts/constants.dart';

//通用的页面组件
//页面返回appbar
backAppbar({Widget? title, List<Widget>? actions, Color? backgroundColor}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    title: title,
    actions: actions,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        Get.back();
      },
    ),
  );
}

//带padding的container
class PaddingContainer extends StatelessWidget {
  final double paddingValue;
  final Widget? child;

  const PaddingContainer({
    super.key,
    required this.paddingValue,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: key,
      padding: EdgeInsets.only(left: paddingValue, right: paddingValue),
      child: child,
    );
  }
}

//自带翻译的Text
class TRText extends Text {
  final String txt;

  TRText(
    this.txt, {
    super.key,
    TextStyle? style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    super.textScaleFactor,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
  }) : super(txt.tr);
}

//功能选项
class FunCard extends StatelessWidget {
  //use primary color by default
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final String desc;
  final String imageSrc;


  const FunCard(
      {super.key,
      this.backgroundColor,
      required this.desc,
      this.borderRadius,
      required this.imageSrc});

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? context.theme.cardTheme.color;
    return ClipRRect(
      borderRadius: cardRadius,
      child: Container(
        color: bg,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageSrc, width: MediaQuery.sizeOf(context).width / 6,),
            const SizedBox(
              height: 10,
            ),
            Text(
              desc,
              style: TextStyle(color: functionText),
            )
          ],
        ),
      ),
    );
  }
}

