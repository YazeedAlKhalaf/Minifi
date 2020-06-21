import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:minifi_app/src/app/constants/config.dart';
import 'package:minifi_app/src/app/generated/router/router.gr.dart';
import 'package:minifi_app/src/app/models/short_url.dart';
import 'package:minifi_app/src/ui/global/custom_base_view_model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeViewModel extends CustomBaseViewModel {
  navigateToAddShortUrlView() {
    navigationService.navigateTo(Routes.addShortUrlViewRoute);
  }

  navigateToEditShortUrlView({
    @required ShortUrl shortUrl,
  }) {
    navigationService.navigateTo(
      Routes.editShortUrlViewRoute,
      arguments: EditShortUrlViewArguments(
        shortUrl: shortUrl,
      ),
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
