import 'package:flutter/cupertino.dart';
import 'package:minifi_app/src/providers/base_provider.dart';

class AddShortUrlProvider extends BaseProvider {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isFieldOriginalUrlValid;
  TextEditingController controllerOriginalUrl = TextEditingController();

  submit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      setBusy(true);
      bool isSuccess =
          await apiService.createShortUrl(controllerOriginalUrl.text);

      isSuccess
          ? navigationService.pop()
          : dialogService.showDialog(
              title: 'Something Went Wrong!',
              description:
                  'Somethng went wrong or the internet connection is off!\nTry again later.',
              buttonTitle: 'OK!',
            );
      setBusy(false);
    }
  }
}
