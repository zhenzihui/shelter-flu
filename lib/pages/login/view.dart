import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shelter_client/consts/colors.dart';
import 'package:shelter_client/consts/strings.dart';
import 'package:shelter_client/routes.dart';

import 'logic.dart';

//登录页
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final logic = Get.put(LoginPageLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: ClipRect(
                  child: Transform(
                    transform: Matrix4.identity()..scale(1.2),
                    child: Image.asset(
                      "assets/images/login_bg.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.1,
                  child: Container(
                    padding: EdgeInsets.only(left: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${release.tr}→",
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            yourLocalDrive.tr,
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            allFilesInOneBox.tr,
                            style: TextStyle(
                                fontSize: 10, color: plainText),
                          ),
                        ]),
                  )),
            ]),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const FingerPrintLoginButton(),
                        LoginButton(onPressed: (){
                          stderr.writeln(' Get.toNamed(routeLoginPassword)');
                          Get.toNamed(routeLoginPassword);
                        })
                      ],
                    ),
                  ),
                  Text(loginViaThirdPartApp.tr),
                  //第三方登录不用那么宽，取屏幕一半
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              "assets/images/nintendo.png",
                              width: 20,
                            ),
                            Image.asset(
                              "assets/images/weibo.png",
                              width: 20,
                            ),
                            Image.asset(
                              "assets/images/instagram.png",
                              width: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(" ")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//指纹登录按钮
class FingerPrintLoginButton extends StatelessWidget {
  const FingerPrintLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    var color = textBlue;

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          minimumSize: Size(130, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Row(
        children: [
          Icon(
            Icons.fingerprint,
            color: color,
          ),
          Text(
            loginFingerprint.tr,
            style: TextStyle(fontSize: 14, color: color),
          ),
        ],
      ),
    );
  }
}

//密码登录按钮
class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: loginBtnBg,
          minimumSize: Size(130, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Text(
        loginPassword.tr,
        style: const TextStyle(fontSize: 14, color: plainText),
      ),
    );
  }
}
