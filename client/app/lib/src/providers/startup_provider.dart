import 'dart:async';

import 'package:minifi_app/src/constants/route_names.dart';
import 'package:minifi_app/src/providers/base_provider.dart';

class StartupProvider extends BaseProvider {
  handleStartupLogic() async {
    Timer(Duration(seconds: 2), () {
      navigationService.navigateToAndRemoveUntill(HomeViewRoute);
    });

    // await apiService.getShortUrls().then(
    //       (value) => print(
    //         "Value: $value",
    //       ),
    //     );
  }
}
