import 'package:get/get.dart';
import 'package:shelter_client/pages/functions/view.dart';
import 'package:shelter_client/pages/home/view.dart';
import 'package:shelter_client/pages/login/view.dart';
import 'package:shelter_client/pages/loginByPassword/view.dart';
const routeIndex = "/";
const routeLoginPassword = "/login-password";
const routeHome = "/home";

const transition = Transition.cupertino;
var routes = [
  GetPage(name: routeIndex, page: () => LoginPage(), transition: transition),
  GetPage(name: routeLoginPassword, page: () => LoginByPasswordPage(), transition: transition),
  GetPage(name: routeHome, page: () => const HomePage(), transition: transition),
];