import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minifi_app/src/constants/config.dart';
import 'package:minifi_app/src/constants/route_names.dart';
import 'package:minifi_app/src/models/dialog_models.dart';
import 'package:minifi_app/src/models/short_url.dart';
import 'package:minifi_app/src/providers/base_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:string_validator/string_validator.dart';

class HomeProvider extends BaseProvider {
  navigateToAddShortUrlView() {
    navigationService.navigateTo(AddShortUrlViewRoute);
  }

  navigateToEditShortUrlView({
    @required ShortUrl shortUrl,
  }) {
    navigationService.navigateTo(
      EditShortUrlViewRoute,
      arguments: shortUrl,
    );
  }

  launchShortUrl({
    @required String shortUrl,
  }) async {
    final String url = '$BASE_URL/$shortUrl';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      dialogService.showDialog(
        title: 'Something went wrong!',
        description:
            'We have no clue what happened! You can copy the short url from the home screen.',
        buttonTitle: 'Ok, Thanks!',
        image: 'assets/images/gif/something_went_wrong.gif',
      );
    }
  }

  launchUrl({
    @required String url,
  }) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      dialogService.showDialog(
        title: 'Something went wrong!',
        description:
            'We have no clue what happened! You can copy the short url from the home screen.',
        buttonTitle: 'Ok, Thanks!',
        image: 'assets/images/gif/something_went_wrong.gif',
      );
    }
  }

  launchEmail({
    @required String email,
  }) async {
    await launch(
      'mailto:$email?subject=Error%20in%20MINIFI%20App&body=Describe%20your%20issue%20here.',
    );
  }

  delete({
    @required ShortUrl shortUrl,
  }) async {
    setBusy(true);

    DialogResponse dialogResponse = await dialogService.showConfirmationDialog(
      title: 'Are You Sure?',
      description: 'Are you sure you wanna delete this Short URL?',
      confirmationTitle: 'Yes, I\'m Sure!',
      cancelTitle: 'Nope',
      image: 'assets/images/gif/are_you_sure.gif',
    );

    if (dialogResponse.confirmed) {
      await apiService.deleteShortUrl(
        shortUrl: shortUrl,
      );
      notifyListeners();
    }
    setBusy(false);
  }

  copyShortUrl({
    @required String shortUrl,
  }) async {
    final String url = '$BASE_URL/$shortUrl';
    await Clipboard.setData(
      ClipboardData(
        text: url,
      ),
    );
  }
}
