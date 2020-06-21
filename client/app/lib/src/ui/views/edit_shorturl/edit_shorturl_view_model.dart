import 'package:flutter/material.dart';
import 'package:minifi_app/src/app/models/short_url.dart';
import 'package:minifi_app/src/ui/global/custom_base_view_model.dart';

class EditShortUrlViewModel extends CustomBaseViewModel {
  inititate({
    @required ShortUrl shortUrlFromFunc,
  }) {
    shortUrl = shortUrlFromFunc;
    notifyListeners();

    controllerOriginalUrl.text = shortUrl.originalUrl;
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ShortUrl shortUrl;

  bool isFieldOriginalUrlValid;
  TextEditingController controllerOriginalUrl = TextEditingController();

  submit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      setBusy(true);
      bool isSuccess = await apiService.updateShortUrl(
        shortUrl: shortUrl,
        newOriginialUrl: controllerOriginalUrl.text,
      );

      isSuccess
          ? navigationService.back()
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
