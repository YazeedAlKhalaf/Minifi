import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:minifi_app/src/providers/startup_provider.dart';
import 'package:minifi_app/src/ui/shared/app_colors.dart';
import 'package:minifi_app/src/ui/shared/ui_helpers.dart';

class StartupView extends StatefulWidget {
  @override
  _StartupViewState createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: StartupProvider(),
      onModelReady: (StartupProvider provider) {
        provider.handleStartupLogic();
      },
      builder: (
        BuildContext context,
        StartupProvider provider,
        Widget child,
      ) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/icon/minifi_logo_FULL.png',
                  width: blockSizeHorizontal(context) * 20,
                ),
                SizedBox(
                  height: blockSizeHorizontal(context) * 5,
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    primaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
