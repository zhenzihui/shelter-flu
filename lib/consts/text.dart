import 'package:get/get.dart';
import 'package:shelter_client/consts/strings.dart';

class Message extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'zh_CN': {
      loginFingerprint: "指纹登录",
      loginPassword: "密码登录",
      loginViaThirdPartApp: "使用第三方帐号登录",
      release: "释放",
      yourLocalDrive: "你的存储空间",
      allFilesInOneBox: "一站式存储各种格式",
      serverAddress: "服务器地址",
      password: "密码",
      username: "帐号",
      login: "登录",
      resVideo: "视频资源",
      resAudio: "音频资源",
      resPhoto: "图像资源",
      resFile: "文档资源",
      resFlash: "动态资源",
      resFolder: "我的文件夹",
      resOther: "其他资源",
      resFav: "我的收藏夹",
      titleAllFunctions: "全部功能",
      tabHome: "主页",
      tabConn: "连接",
      tabRadar: "发现",
    },
    'en_US': {
      loginFingerprint: "login by fingerprint",
      loginPassword: "login by password",
      loginViaThirdPartApp: "use third-part account",
      release: "Release",
      yourLocalDrive: "your local drive",
      allFilesInOneBox: "all files in one box",
      serverAddress: "server",
      login: "login",
    }
  };

}