import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shelter_client/consts/constants.dart';
import 'package:shelter_client/widget/business.dart';
import 'package:shelter_client/widget/form.dart';

import '../../consts/strings.dart';
import '../../routes.dart';
import 'logic.dart';

class LoginByPasswordPage extends StatelessWidget {
  LoginByPasswordPage({Key? key}) : super(key: key);

  final logic = Get.put(LoginByPasswordLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppbar(title: TRText(login)),
      body: PaddingContainer(
        paddingValue: horizontalPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  inputWithLabel(serverAddress.tr,
                      icon: const Icon(Icons.wifi), onChange: (text) {}),
                  inputWithLabel(username.tr,
                      icon: const Icon(Icons.account_circle_outlined),
                      onChange: (text) {}),
                  inputWithLabel(password.tr,
                      icon: const Icon(Icons.password), onChange: (text) {}),
                ],
              ),
            ),
            positiveButton(login.tr,
                minimumSize: Size(MediaQuery.sizeOf(context).width, 50),
                onPressed: () {
                  Get.toNamed(routeHome);
                })
          ],
        ),
      ),
    );
  }
}
