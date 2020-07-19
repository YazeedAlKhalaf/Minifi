import 'package:auto_route/auto_route_annotations.dart';
import 'package:minifi_app/src/ui/views/add_shorturl/add_shorturl_view.dart';
import 'package:minifi_app/src/ui/views/edit_shorturl/edit_shorturl_view.dart';
import 'package:minifi_app/src/ui/views/startup/startup_view.dart';
import 'package:minifi_app/src/ui/views/home/home_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: AddShortUrlView),
    MaterialRoute(page: EditShortUrlView),
  ],
)
class $Router {}
