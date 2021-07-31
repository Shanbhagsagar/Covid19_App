import 'package:flutter/material.dart';
import 'package:tweet_webview/tweet_webview.dart';

class IcmrNews extends StatelessWidget {
  static const String id = 'icmr_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('ICMR Twitter'),
      ),
      body: TweetWebView.tweetUrl("https://twitter.com/ICMRDELHI"),
    );
  }
}
