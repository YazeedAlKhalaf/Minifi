// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../ui/views/add_shorturl/add_shorturl_view.dart';
import '../../../ui/views/edit_shorturl/edit_shorturl_view.dart';
import '../../../ui/views/home/home_view.dart';
import '../../../ui/views/startup/startup_view.dart';
import '../../models/short_url.dart';

class Routes {
  static const String startupView = '/';
  static const String homeView = '/home-view';
  static const String addShortUrlView = '/add-short-url-view';
  static const String editShortUrlView = '/edit-short-url-view';
  static const all = <String>{
    startupView,
    homeView,
    addShortUrlView,
    editShortUrlView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.addShortUrlView, page: AddShortUrlView),
    RouteDef(Routes.editShortUrlView, page: EditShortUrlView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    StartupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StartupView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    AddShortUrlView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddShortUrlView(),
        settings: data,
      );
    },
    EditShortUrlView: (data) {
      var args = data.getArgs<EditShortUrlViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => EditShortUrlView(shortUrl: args.shortUrl),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// EditShortUrlView arguments holder class
class EditShortUrlViewArguments {
  final ShortUrl shortUrl;
  EditShortUrlViewArguments({@required this.shortUrl});
}
