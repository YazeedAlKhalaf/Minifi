import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minifi_app/src/app/models/short_url.dart';
import 'package:minifi_app/src/ui/global/app_colors.dart';
import 'package:minifi_app/src/ui/global/ui_helpers.dart';
import 'package:minifi_app/src/ui/widgets/busy_overlay.dart';
import 'package:minifi_app/src/ui/widgets/rounded_button.dart';
import 'package:minifi_app/src/ui/widgets/text_link.dart';
import 'package:stacked/stacked.dart';

import './home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget child,
      ) {
        return BusyOverlay(
          show: model.isBusy,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: backgroundColor,
              elevation: 0.3,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'MINIFI',
                    style: TextStyle(
                      color: textColorBlack,
                      fontSize: blockSizeVertical(context) * 6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  model.setBusy(true);
                  model.notifyListeners();
                  model.setBusy(false);
                },
                child: FutureBuilder(
                  future: model.apiService.getShortUrls(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<ShortUrl>> snapshot,
                  ) {
                    if (snapshot.hasData && snapshot.data.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'You have no Short URLs!',
                              style: TextStyle(
                                fontSize: blockSizeVertical(context) * 3,
                                fontWeight: FontWeight.bold,
                                color: textColorBlack,
                              ),
                            ),
                            SizedBox(
                              height: blockSizeVertical(context) * 3,
                            ),
                            RoundedButton(
                              text: 'Refresh',
                              onPressed: () {
                                model.setBusy(true);
                                model.notifyListeners();
                                model.setBusy(false);
                              },
                              fontSize: blockSizeVertical(context) * 3,
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                            primaryColor,
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Something Went Wrong!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: blockSizeVertical(context) * 3,
                                  ),
                                ),
                                Text(
                                  'Please contact us at:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: blockSizeVertical(context) * 3,
                                  ),
                                ),
                                TextLink(
                                  'yazeedfady@gmail.com',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: blockSizeVertical(context) * 3,
                                    color: textColorLink,
                                  ),
                                  onPressed: () async {
                                    await model.launchEmail(
                                      email: 'yazeedfady@gmail.com',
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: blockSizeVertical(context) * 5,
                            ),
                            RoundedButton(
                              text: 'Try Again',
                              onPressed: () {
                                model.setBusy(true);
                                model.notifyListeners();
                                model.setBusy(false);
                              },
                              fontSize: blockSizeVertical(context) * 3,
                            ),
                          ],
                        ),
                      );
                    }
                    List<ShortUrl> shortUrls = List<ShortUrl>.from(
                      snapshot.data.reversed,
                    );
                    return ListView.builder(
                      itemCount: shortUrls.length,
                      itemBuilder: (
                        BuildContext context,
                        int index,
                      ) {
                        ShortUrl shortUrl = shortUrls[index];
                        return Card(
                          margin: EdgeInsets.all(
                            blockSizeVertical(context) * 2,
                          ),
                          color: textColorWhite,
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              25,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                              blockSizeVertical(context) * 3,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    TextLink(
                                      shortUrl.shortUrl,
                                      style: TextStyle(
                                        fontSize:
                                            blockSizeVertical(context) * 3,
                                        fontWeight: FontWeight.bold,
                                        color: textColorLink,
                                      ),
                                      onPressed: () async {
                                        await model.launchShortUrl(
                                          shortUrl: shortUrl.shortUrl,
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.content_copy,
                                        size: blockSizeVertical(context) * 3,
                                      ),
                                      onPressed: () async {
                                        await model.copyShortUrl(
                                          shortUrl: shortUrl.shortUrl,
                                        );
                                        Fluttertoast.showToast(
                                          msg: 'Copied Link Successfully!',
                                          fontSize:
                                              blockSizeVertical(context) * 3,
                                          toastLength: Toast.LENGTH_SHORT,
                                          textColor: textColorWhite,
                                          backgroundColor: primaryColor,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: blockSizeVertical(context),
                                ),
                                TextLink(
                                  shortUrl.originalUrl,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: blockSizeVertical(context) * 2,
                                    fontWeight: FontWeight.bold,
                                    color: textColorLink,
                                  ),
                                  onPressed: () async {
                                    await model.launchUrl(
                                      url: shortUrl.originalUrl,
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: blockSizeVertical(context) * 3,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Opacity(
                                      opacity: 0.5,
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.visibility,
                                            color: textColorBlack,
                                            size:
                                                blockSizeVertical(context) * 3,
                                          ),
                                          SizedBox(
                                            width: blockSizeVertical(context),
                                          ),
                                          Text(
                                            shortUrl.clicksNumber.toString(),
                                            style: TextStyle(
                                              color: textColorBlack,
                                              fontSize:
                                                  blockSizeVertical(context) *
                                                      3,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RoundedButton(
                                      text: 'Delete',
                                      onPressed: () async {
                                        await model.delete(
                                          shortUrl: shortUrl,
                                        );
                                      },
                                      fontSize:
                                          blockSizeVertical(context) * 2.5,
                                    ),
                                    RoundedButton(
                                      text: 'Edit',
                                      buttonColor: accentColor,
                                      onPressed: () {
                                        model.navigateToEditShortUrlView(
                                          shortUrl: shortUrl,
                                        );
                                      },
                                      fontSize:
                                          blockSizeVertical(context) * 2.5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                model.navigateToAddShortUrlView();
              },
              child: Icon(
                Icons.add,
                size: blockSizeVertical(context) * 6,
                color: textColorWhite,
              ),
            ),
          ),
        );
      },
    );
  }
}
