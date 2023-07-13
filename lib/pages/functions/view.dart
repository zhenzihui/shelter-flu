import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shelter_client/consts/colors.dart';
import 'package:shelter_client/consts/constants.dart';
import 'package:shelter_client/consts/strings.dart';
import 'package:shelter_client/widget/business.dart';

import 'logic.dart';
//全部功能
class FunctionsPage extends StatelessWidget {
  const FunctionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(FunctionsLogic());

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: backAppbar(title: TRText(titleAllFunctions)),
        body: PaddingContainer(
      paddingValue: horizontalPadding,
      child: functionList(context),
    ));
  }

  functionList(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 20,
      children: <Widget>[
        FunCard(desc: resVideo.tr, imageSrc: "assets/images/res_video.png"),
        FunCard(desc: resAudio.tr, imageSrc: "assets/images/res_audio.png"),
        FunCard(desc: resPhoto.tr, imageSrc: "assets/images/res_photo.png"),
        FunCard(desc: resFile.tr, imageSrc: "assets/images/res_file.png"),
        FunCard(desc: resFlash.tr, imageSrc: "assets/images/res_flash.png"),
        FunCard(desc: resFolder.tr, imageSrc: "assets/images/res_folder.png"),
        FunCard(desc: resOther.tr, imageSrc: "assets/images/res_other.png"),
        FunCard(desc: resFav.tr, imageSrc: "assets/images/res_fav.png"),

      ],
    );
  }
}
