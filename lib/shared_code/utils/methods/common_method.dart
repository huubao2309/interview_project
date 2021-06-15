import 'dart:async';
import 'dart:math';

import 'package:device_info/device_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:interview_project/data/shared_preferences/shared_preferences.dart';
import 'package:interview_project/shared_code/utils/materials/constant.dart';
import 'package:interview_project/shared_code/utils/materials/system.dart';
import 'package:url_launcher/url_launcher.dart';

bool isNumeric(String s) {
  if (s.isEmpty) {
    return false;
  }
  return double.tryParse(s) != null;
}

double doubleRound(double val, int places) {
  final mod = pow(10.0, places);
  return (val * mod).round().toDouble() / mod;
}

void printWrappedLog(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Future<bool> checkPermission() async {
  if (platformDevice == TargetPlatform.android) {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final result = await Permission.storage.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    } else {
      return true;
    }
  } else {
    return true;
  }
  return false;
}

Error createError(String errorStr) {
  final Error error = ArgumentError(errorStr);
  return error;
}

Future<void> clearSPrefCache() async {
  await SPref.instance.set(SPrefCache.KEY_ACCESS_TOKEN, '');
}

String formatNumber(String s) {
  final tmp = s.replaceAll(RegExp('[đ,]'), '');
  var value = '';
  if (tmp.isNotEmpty) {
    value = '${NumberFormat.decimalPattern('en').format(int.parse(tmp))}đ';
  }

  return value;
}

String formatInputAmountNumber(String amount) {
  final tmp = amount.replaceAll(RegExp('[đ,]'), '');
  var value = '';
  if (tmp.isNotEmpty) {
    value = '${NumberFormat.decimalPattern('en').format(int.parse(tmp))}';
  }

  return value;
}

int removeFormat(String amount) {
  if (amount == '') {
    return 0;
  }
  return int.parse(amount.replaceAll(RegExp('[đ,]'), ''));
}

bool checkInputMinimumAmount(String amount, int minimumAmount) {
  final tmp = amount.replaceAll(RegExp('[đ,]'), '');
  if (tmp.isNotEmpty) {
    if (int.parse(tmp) >= minimumAmount) {
      return true;
    }
  }

  return false;
}

Map<String, dynamic> readAndroidBuildData(AndroidDeviceInfo build) {
  return <String, dynamic>{
    'version.securityPatch': build.version.securityPatch,
    'version.sdkInt': build.version.sdkInt,
    'version.release': build.version.release,
    'version.previewSdkInt': build.version.previewSdkInt,
    'version.incremental': build.version.incremental,
    'version.codename': build.version.codename,
    'version.baseOS': build.version.baseOS,
    'board': build.board,
    'bootloader': build.bootloader,
    'brand': build.brand,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'host': build.host,
    'id': build.id,
    'manufacturer': build.manufacturer,
    'model': build.model,
    'product': build.product,
    'supported32BitAbis': build.supported32BitAbis,
    'supported64BitAbis': build.supported64BitAbis,
    'supportedAbis': build.supportedAbis,
    'tags': build.tags,
    'type': build.type,
    'isPhysicalDevice': build.isPhysicalDevice,
    'androidId': build.androidId,
    'systemFeatures': build.systemFeatures,
  };
}

Map<String, dynamic> readIosDeviceInfo(IosDeviceInfo data) {
  return <String, dynamic>{
    'name': data.name,
    'systemName': data.systemName,
    'systemVersion': data.systemVersion,
    'model': data.model,
    'localizedModel': data.localizedModel,
    'identifierForVendor': data.identifierForVendor,
    'isPhysicalDevice': data.isPhysicalDevice,
    'utsname.sysname:': data.utsname.sysname,
    'utsname.nodename:': data.utsname.nodename,
    'utsname.release:': data.utsname.release,
    'utsname.version:': data.utsname.version,
    'utsname.machine:': data.utsname.machine,
  };
}

bool checkValidateDateInstallment(DateTime selectedDate) {
  final dateNow = DateTime.now();
  if (selectedDate.isAfter(dateNow.subtract(const Duration(days: 3)))) {
    return true;
  }

  return false;
}

Future<void> launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    // ignore: only_throw_errors
    throw 'Could not launch $url';
  }
}

Future<bool> checkEveryMinutes({required DateTime now, required String timeCheck, required int minutes}) async {
  if (timeCheck.toString().isEmpty) {
    return false;
  }

  final parseVersionTime = DateTime.parse(timeCheck);
  if (!parseVersionTime.isAfter(now.subtract(Duration(minutes: minutes)))) {
    return true;
  }

  return false;
}

String convertVersionCodeOfiOS({required String versionName}) {
  if (versionName.isEmpty) {
    return '1000';
  }

  final listSplitVersionName = versionName.split('.');
  final versionMajor = listSplitVersionName.elementAt(0);
  final versionMinor = listSplitVersionName.elementAt(1);
  final versionPatch = listSplitVersionName.elementAt(2);

  return (int.parse(versionMajor) * 1000 + int.parse(versionMinor) * 100 + int.parse(versionPatch)).toString();
}
