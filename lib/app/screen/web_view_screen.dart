import 'dart:async';

import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/sign_up_screen.dart';
import 'package:furry_friend/app/widget/common_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  String siteUrl = "";
  String socialType = "";

  WebViewScreen({super.key, required this.siteUrl, this.socialType = ''});

  @override
  State<StatefulWidget> createState() => _WebViewState();
}

class _WebViewState extends State<WebViewScreen> {
  double progress = 0;

  WebViewController _controller = WebViewController();

  @override
  void initState() {
    setWebViewController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(context, onTap: () {
          backAction();
        }),
        body: SafeArea(
            child: WillPopScope(
                onWillPop: () => backAction(),
                child: Stack(
                  children: [
                    WebViewWidget(controller: _controller),
                    if (progress < 1.0)
                      LinearProgressIndicator(value: progress)
                    else
                      Container(),
                  ],
                ))));
  }

  Future<bool> backAction() async {
    if (_controller != null && await _controller!.canGoBack()) {
      _controller!.goBack();
      return false;
    } else {
      Navigator.pop(context);
      return true;
    }
  }

  void setWebViewController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..runJavaScriptReturningResult("document.documentElement.innerText")
          .then((value) {})
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {},
        onNavigationRequest: (request) {
          final url = request.url;
          if (url.startsWith('https://furry-friend-kappa.vercel.app/oauth2/')) {
            String socialType = widget.socialType;
            if (socialType == 'kakao') {
              socialType = url.substring(url.indexOf('code=') + 5);
            }

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => SignUpScreen(
                          loginType: 'kakao|$socialType',
                          isSocialSign: true,
                        )));
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        onProgress: (progress) {
          if (mounted) {
            setState(() {
              this.progress = progress / 100;
            });
          }
        },
      ))
      ..loadRequest(Uri.parse(widget.siteUrl));
  }
}
