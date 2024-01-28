import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:provider/provider.dart';
import 'package:task/core/model/user_model.dart';
import 'package:task/core/networkStatus/network_status.dart';

import '../../widgets/action_dialog.dart';
import '../httpHelper/http_helper.dart';
import '../router/router.dart';

class HomeProvider extends ChangeNotifier {
  static HomeProvider get(context) => Provider.of<HomeProvider>(context);

  static HomeProvider listenFalse(context) =>
      Provider.of<HomeProvider>(context, listen: false);

  List<UsersModel>? usersModel;
  NetworkStatus? usersStatus;

  Future<void> getUsers() async {
    try {
      usersStatus = NetworkStatus.loading;
      final r = await HttpHelper.instance.httpGet('users');
      if (r.statusCode >= 200 && r.statusCode < 300) {
        usersModel = (json.decode(r.body) as List)
            .map((e) => UsersModel.fromJson(e))
            .toList();
        usersStatus = NetworkStatus.success;
      } else {
        usersStatus = NetworkStatus.error;
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }
}
