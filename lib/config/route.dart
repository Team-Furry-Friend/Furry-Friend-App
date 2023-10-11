import 'package:flutter/material.dart';
import 'package:furry_friend/app/screen/basket_list_screen.dart';
import 'package:furry_friend/app/screen/chat_details_screen.dart';
import 'package:furry_friend/app/screen/login_email_screen.dart';
import 'package:furry_friend/app/screen/login_screen.dart';
import 'package:furry_friend/app/screen/main_screen.dart';
import 'package:furry_friend/app/screen/product_details_screen.dart';
import 'package:furry_friend/app/screen/product_write_screen.dart';
import 'package:furry_friend/app/screen/sign_up_screen.dart';
import 'package:furry_friend/app/screen/web_view_screen.dart';
import 'package:furry_friend/common/utils.dart';
import 'package:furry_friend/domain/model/post/post.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return Utils.util.isLogin() ? const MainScreen() : LoginScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'main',
          path: 'main',
          builder: (BuildContext context, GoRouterState state) {
            return const MainScreen();
          },
        ),
        GoRoute(
          name: 'login',
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return LoginScreen();
          },
        ),
        GoRoute(
          name: 'loginEmail',
          path: 'loginEmail',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginEmailScreen();
          },
        ),
        GoRoute(
          name: 'product',
          path: 'product/:pid',
          builder: (BuildContext context, GoRouterState state) {
            return ProductDetailsScreen(
                pid: int.parse(state.pathParameters["pid"]!));
          },
        ),
        GoRoute(
          name: 'productDetails',
          path: 'productDetails/:pid',
          builder: (BuildContext context, GoRouterState state) {
            return ProductDetailsScreen(
                pid: int.parse(state.pathParameters["pid"]!));
          },
        ),
        GoRoute(
          name: 'productWrite',
          path: 'productWrite',
          builder: (BuildContext context, GoRouterState state) {
            return ProductWriteScreen(
              post: state.extra != null ? state.extra as Post : null,
            );
          },
        ),
        GoRoute(
          name: 'basket',
          path: 'basket',
          builder: (BuildContext context, GoRouterState state) {
            return const BasketListScreen();
          },
        ),
        GoRoute(
          name: 'signUp',
          path: 'signUp/:isSocialSign/:loginType',
          builder: (BuildContext context, GoRouterState state) {
            final isSocialSign =
                toBoolean(state.pathParameters["isSocialSign"]!);
            final loginType = state.pathParameters["loginType"]!;
            return SignUpScreen(
                isSocialSign: isSocialSign, loginType: loginType);
          },
        ),
        GoRoute(
          name: 'webView',
          path: 'webView/:siteUrl/:socialType',
          builder: (BuildContext context, GoRouterState state) {
            final siteUrl = state.pathParameters["siteUrl"]!;
            final socialType = state.pathParameters["socialType"]!;
            return WebViewScreen(siteUrl: siteUrl, socialType: socialType);
          },
        ),
        GoRoute(
          name: 'chatDetails',
          path: 'chatDetails/:roomId',
          builder: (BuildContext context, GoRouterState state) {
            return ChatDetailsScreen(
                roomId: int.parse(state.pathParameters["roomId"]!));
          },
        ),
      ],
    ),
  ],
);

bool toBoolean(String text) {
  return text.toLowerCase() != "false";
}
