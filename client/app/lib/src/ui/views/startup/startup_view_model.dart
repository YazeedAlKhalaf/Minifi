import 'dart:async';

import 'package:minifi_app/src/app/generated/router/router.gr.dart';
import 'package:minifi_app/src/ui/global/custom_base_view_model.dart';

class StartupViewModel extends CustomBaseViewModel {
  Future handleStartup() async {
    Timer(
      Duration(seconds: 1),
      () => navigateToHomeView(),
    );
  }

  Future navigateToHomeView() async {
    await navigationService.pushNamedAndRemoveUntil(Routes.homeViewRoute);
  }
}
