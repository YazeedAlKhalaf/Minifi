import 'package:flutter/material.dart';
import 'package:minifi_app/src/constants/route_names.dart';
import 'package:minifi_app/src/ui/views/add_shorturl_view.dart';
import 'package:minifi_app/src/ui/views/edit_shorturl_view.dart';
import 'package:minifi_app/src/ui/views/home_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
      break;
    case AddShortUrlViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: AddShortUrlView(),
      );
      break;
    case EditShortUrlViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: EditShortUrlView(
          shortUrl: settings.arguments,
        ),
      );
      break;
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text(
              'No route defined for ${settings.name}',
            ),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({
  String routeName,
  Widget viewToShow,
}) {
  return MaterialPageRoute(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow,
  );
}
