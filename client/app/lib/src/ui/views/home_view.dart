import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minifi_app/src/ui/widgets/text_link.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:minifi_app/src/models/short_url.dart';
import 'package:minifi_app/src/providers/home_provider.dart';
import 'package:minifi_app/src/ui/shared/app_colors.dart';
import 'package:minifi_app/src/ui/shared/ui_helpers.dart';
import 'package:minifi_app/src/ui/widgets/rounded_button.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: HomeProvider(),
      builder: (
        BuildContext context,
        HomeProvider provider,
        Widget child,
      ) {
        return Scaffold(
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
                    fontSize: blockSizeHorizontal(context) * 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                provider.setBusy(true);
                setState(() {});
                provider.setBusy(false);
              },
              child: FutureBuilder(
                future: provider.apiService.getShortUrls(),
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
                              fontSize: blockSizeHorizontal(context) * 7,
                              fontWeight: FontWeight.bold,
                              color: textColorBlack,
                            ),
                          ),
                          SizedBox(
                            height: blockSizeHorizontal(context) * 5,
                          ),
                          RoundedButton(
                            text: 'Refresh',
                            onPressed: () {
                              provider.setBusy(true);
                              setState(() {});
                              provider.setBusy(false);
                            },
                            fontSize: blockSizeHorizontal(context) * 5,
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
                                  fontSize: blockSizeHorizontal(context) * 7,
                                ),
                              ),
                              Text(
                                'Please contact us at:',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: blockSizeHorizontal(context) * 7,
                                ),
                              ),
                              TextLink(
                                'yazeedfady@gmail.com',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: blockSizeHorizontal(context) * 7,
                                  color: textColorLink,
                                ),
                                onPressed: () async {
                                  await provider.launchEmail(
                                    email: 'yazeedfady@gmail.com',
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: blockSizeHorizontal(context) * 5,
                          ),
                          RoundedButton(
                            text: 'Try Again',
                            onPressed: () {
                              provider.setBusy(true);
                              setState(() {});
                              provider.setBusy(false);
                            },
                            fontSize: blockSizeHorizontal(context) * 5,
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
                          blockSizeHorizontal(context) * 3,
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
                            blockSizeHorizontal(context) * 5,
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
                                          blockSizeHorizontal(context) * 6,
                                      fontWeight: FontWeight.bold,
                                      color: textColorLink,
                                    ),
                                    onPressed: () async {
                                      await provider.launchShortUrl(
                                        shortUrl: shortUrl.shortUrl,
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.content_copy,
                                      size: blockSizeHorizontal(context) * 6,
                                    ),
                                    onPressed: () async {
                                      await provider.copyShortUrl(
                                        shortUrl: shortUrl.shortUrl,
                                      );
                                      Fluttertoast.showToast(
                                        msg: 'Copied Link Successfully!',
                                        fontSize:
                                            blockSizeHorizontal(context) * 6,
                                        toastLength: Toast.LENGTH_SHORT,
                                        textColor: textColorWhite,
                                        backgroundColor: primaryColor,
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: blockSizeHorizontal(context) * 5,
                              ),
                              TextLink(
                                shortUrl.originalUrl,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: blockSizeHorizontal(context) * 5,
                                  fontWeight: FontWeight.bold,
                                  color: textColorLink,
                                ),
                                onPressed: () async {
                                  await provider.launchUrl(
                                    url: shortUrl.originalUrl,
                                  );
                                },
                              ),
                              SizedBox(
                                height: blockSizeHorizontal(context) * 10,
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
                                              blockSizeHorizontal(context) * 8,
                                        ),
                                        SizedBox(
                                          width:
                                              blockSizeHorizontal(context) * 2,
                                        ),
                                        Text(
                                          shortUrl.clicksNumber.toString(),
                                          style: TextStyle(
                                            color: textColorBlack,
                                            fontSize:
                                                blockSizeHorizontal(context) *
                                                    8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RoundedButton(
                                    text: 'Delete',
                                    onPressed: () async {
                                      await provider.delete(
                                        shortUrl: shortUrl,
                                      );
                                    },
                                    fontSize: blockSizeHorizontal(context) * 4,
                                  ),
                                  RoundedButton(
                                    text: 'Edit',
                                    buttonColor: accentColor,
                                    onPressed: () {
                                      provider.navigateToEditShortUrlView(
                                        shortUrl: shortUrl,
                                      );
                                    },
                                    fontSize: blockSizeHorizontal(context) * 4,
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
              provider.navigateToAddShortUrlView();
            },
            child: Icon(
              Icons.add,
              size: blockSizeHorizontal(context) * 10,
              color: textColorWhite,
            ),
          ),
        );
      },
    );
  }
}
