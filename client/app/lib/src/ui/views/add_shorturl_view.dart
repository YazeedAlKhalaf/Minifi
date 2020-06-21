import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:string_validator/string_validator.dart';
import 'package:minifi_app/src/providers/add_shorturl_provider.dart';
import 'package:minifi_app/src/ui/shared/app_colors.dart';
import 'package:minifi_app/src/ui/shared/ui_helpers.dart';
import 'package:minifi_app/src/ui/widgets/rounded_button.dart';

class AddShortUrlView extends StatefulWidget {
  @override
  _AddShortUrlViewState createState() => _AddShortUrlViewState();
}

class _AddShortUrlViewState extends State<AddShortUrlView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: AddShortUrlProvider(),
      builder: (
        BuildContext context,
        AddShortUrlProvider provider,
        Widget child,
      ) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: textColorWhite,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Create a short link',
              style: TextStyle(
                color: textColorBlack,
                fontSize: blockSizeHorizontal(context) * 7,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(
                blockSizeHorizontal(context) * 8,
              ),
              child: Form(
                key: provider.formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: provider.controllerOriginalUrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                        ),
                        labelText: 'Long url',
                        hintText: 'e.g: https://example.com',
                        labelStyle: TextStyle(
                          fontSize: blockSizeHorizontal(context) * 5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      keyboardType: TextInputType.url,
                      validator: (url) {
                        if (url.trim().isEmpty) {
                          return 'Long URL can\'t be empty!';
                        } else if (!isURL(
                          url,
                          {
                            "protocols": [
                              'http',
                              'https',
                            ],
                            "require_tld": true,
                            "require_protocol": true,
                            "allow_underscores": false,
                            "host_whitelist": false,
                            "host_blacklist": false,
                          },
                        )) {
                          return 'The URL you entered is not valid!';
                        }
                      },
                    ),
                    SizedBox(
                      height: blockSizeHorizontal(context) * 7,
                    ),
                    RoundedButton(
                      text: 'Shorten',
                      onPressed: () async {
                        await provider.submit();
                      },
                      padding: EdgeInsets.symmetric(
                        horizontal: blockSizeHorizontal(context) * 10,
                        vertical: blockSizeHorizontal(context) * 3,
                      ),
                      fontSize: blockSizeHorizontal(context) * 7,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
