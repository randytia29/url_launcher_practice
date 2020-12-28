import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Url Launcher Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LaunchButton('Call', () async {
              await call('+621500888');
            }),
            LaunchButton('SMS', () async {
              await sendSMS('+621500888');
            }),
            LaunchButton('Email', () async {
              await sendEmail('jennie.kim@blackpink.com');
            }),
            LaunchButton('URL', () async {
              // await openUrl('https://www.amazon.com/',
              //     forceWebView: true, enableJavaScript: true);
              await openUrl('amazon.com/',
                  forceWebView: true, enableJavaScript: true);
            })
          ],
        ),
      ),
    );
  }
}

class LaunchButton extends StatelessWidget {
  final String text;
  final Function onTap;

  LaunchButton(this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: RaisedButton(
        child: Text(text),
        color: Colors.blue[100],
        onPressed: onTap,
      ),
    );
  }
}

Future<void> call(String phoneNumber) async {
  await launch('tel:$phoneNumber');
}

Future<void> sendEmail(String email) async {
  await launch('mailto:$email');
}

Future<void> sendSMS(String phoneNumber) async {
  await launch('sms:$phoneNumber');
}

Future<void> openUrl(String url,
    {bool forceWebView = false, bool enableJavaScript = false}) async {
  if (await canLaunch(url)) {
    await launch(url,
        forceWebView: forceWebView, enableJavaScript: enableJavaScript);
  }
}
