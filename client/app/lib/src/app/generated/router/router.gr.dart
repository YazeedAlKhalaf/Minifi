// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:minifi_app/src/ui/views/startup/startup_view.dart';
import 'package:minifi_app/src/ui/views/home/home_view.dart';
import 'package:minifi_app/src/ui/views/add_shorturl/add_shorturl_view.dart';
import 'package:minifi_app/src/ui/views/edit_shorturl/edit_shorturl_view.dart';
import 'package:minifi_app/src/app/models/short_url.dart';

abstract class Routes {
  static const startupViewRoute = '/';
  static const homeViewRoute = '/home-view-route';
  static const addShortUrlViewRoute = '/add-short-url-view-route';
  static const editShortUrlViewRoute = '/edit-short-url-view-route';
  static const all = {
    startupViewRoute,
    homeViewRoute,
    addShortUrlViewRoute,
    editShortUrlViewRoute,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.startupViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => StartupView(),
          settings: settings,
        );
      case Routes.homeViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeView(),
          settings: settings,
        );
      case Routes.addShortUrlViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddShortUrlView(),
          settings: settings,
        );
      case Routes.editShortUrlViewRoute:
        if (hasInvalidArgs<EditShortUrlViewArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<EditShortUrlViewArguments>(args);
        }
        final typedArgs = args as EditShortUrlViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => EditShortUrlView(shortUrl: typedArgs.shortUrl),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//EditShortUrlView arguments holder class
class EditShortUrlViewArguments {
  final ShortUrl shortUrl;
  EditShortUrlViewArguments({@required this.shortUrl});
}
