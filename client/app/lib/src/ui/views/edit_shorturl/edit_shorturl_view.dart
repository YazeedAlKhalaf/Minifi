import 'package:flutter/material.dart';
import 'package:minifi_app/src/app/models/short_url.dart';
import 'package:minifi_app/src/ui/global/app_colors.dart';
import 'package:minifi_app/src/ui/global/ui_helpers.dart';
import 'package:minifi_app/src/ui/views/edit_shorturl/edit_shorturl_view_model.dart';
import 'package:minifi_app/src/ui/widgets/busy_overlay.dart';
import 'package:stacked/stacked.dart';
import 'package:string_validator/string_validator.dart';
import 'package:minifi_app/src/ui/widgets/rounded_button.dart';

class EditShortUrlView extends StatefulWidget {
  final ShortUrl shortUrl;

  EditShortUrlView({
    @required this.shortUrl,
  });
  @override
  _EditShortUrlViewState createState() => _EditShortUrlViewState();
}

class _EditShortUrlViewState extends State<EditShortUrlView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EditShortUrlViewModel(),
      onModelReady: (EditShortUrlViewModel model) {
        model.inititate(
          shortUrlFromFunc: widget.shortUrl,
        );
      },
      builder: (
        BuildContext context,
        EditShortUrlViewModel model,
        Widget child,
      ) {
        return BusyOverlay(
          show: model.isBusy,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: textColorWhite,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Edit a short link',
                style: TextStyle(
                  color: textColorBlack,
                  fontSize: blockSizeVertical(context) * 3,
                ),
              ),
              iconTheme: IconThemeData(
                color: textColorBlack,
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(
                  blockSizeVertical(context) * 4,
                ),
                child: Form(
                  key: model.formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: model.controllerOriginalUrl,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                          ),
                          labelText: 'Long url',
                          hintText: 'e.g: https://example.com',
                          labelStyle: TextStyle(
                            fontSize: blockSizeVertical(context) * 3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        keyboardType: TextInputType.url,
                        validator: (String url) {
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
                          } else if (url == model.shortUrl.originalUrl) {
                            return 'New Long URL can\'t be exactly the same as the old one!';
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: blockSizeVertical(context) * 5,
                      ),
                      RoundedButton(
                        text: 'Update',
                        onPressed: () async {
                          await model.submit();
                        },
                        padding: EdgeInsets.symmetric(
                          horizontal: blockSizeVertical(context) * 3,
                          vertical: blockSizeVertical(context) * 2,
                        ),
                        fontSize: blockSizeVertical(context) * 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
