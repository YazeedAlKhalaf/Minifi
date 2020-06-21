import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:minifi_app/src/app/generated/locator/locator.dart';
import 'package:minifi_app/src/app/services/api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CustomBaseViewModel extends BaseViewModel {
  final NavigationService navigationService = locator<NavigationService>();
  final DialogService dialogService = locator<DialogService>();
  final ApiService apiService = locator<ApiService>();

  void copyText({
    @required String text,
  }) {
    Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
  }
}
