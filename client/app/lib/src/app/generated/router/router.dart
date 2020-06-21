import 'package:auto_route/auto_route_annotations.dart';
import 'package:minifi_app/src/ui/views/add_shorturl/add_shorturl_view.dart';
import 'package:minifi_app/src/ui/views/edit_shorturl/edit_shorturl_view.dart';
import 'package:minifi_app/src/ui/views/startup/startup_view.dart';
import 'package:minifi_app/src/ui/views/home/home_view.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  StartupView startupViewRoute;

  HomeView homeViewRoute;

  AddShortUrlView addShortUrlViewRoute;

  EditShortUrlView editShortUrlViewRoute;
}
