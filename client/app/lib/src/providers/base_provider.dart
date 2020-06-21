import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:minifi_app/src/locator.dart';
import 'package:minifi_app/src/services/api_service.dart';
import 'package:minifi_app/src/services/dialog_service.dart';
import 'package:minifi_app/src/services/navigation_service.dart';

class BaseProvider extends ChangeNotifier {
  final NavigationService navigationService = locator<NavigationService>();
  final DialogService dialogService = locator<DialogService>();
  final ApiService apiService = locator<ApiService>();

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

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
