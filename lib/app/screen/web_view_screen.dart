import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:furry_friend/app/screen/sign_up_screen.dart';
import 'package:furry_friend/app/widget/common_widget.dart';
import 'package:furry_friend/app/widget/widget_color.dart';
import 'package:furry_friend/domain/providers/user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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
        backgroundColor: WidgetColor.cleanWhite,
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
      context.pop();
      return true;
    }
  }

  void setWebViewController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(widget.socialType == 'google'
          ? "Mozilla/5.0 AppleWebKit/535.19 Chrome/56.0.0 Mobile Safari/535.19"
          : null)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {},
        onNavigationRequest: (request) {
          final url = request.url;
          if (url.startsWith(dotenv.env['FURRY_FRIEND_URL'] ?? "")) {
            socialSignUpRoute(url);
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

  void socialSignUpRoute(String url) {
    String socialType = widget.socialType;
    String code = '';
    switch (socialType) {
      case "kakao":
        {
          code = url.substring(url.indexOf('code=') + 5);
          break;
        }
      case "naver":
      case "google":
        {
          code = Uri.decodeComponent(
              url.substring(url.indexOf('code=') + 5).split('&').first);
          break;
        }
    }
    context
        .read<UserProvider>()
        .socialLogin(context, socialType, code)
        .then((isSign) {
      if (isSign) {
        context.pushReplacementNamed('signUp', pathParameters: {
          "isSocialSign": "true",
          "loginType": socialType,
        });
      }
    });
  }
}
