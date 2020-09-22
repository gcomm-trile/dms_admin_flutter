import 'package:dms_admin/Pages/Home/components/dashboard.dart';
import 'package:dms_admin/Pages/Home/components/product_page.dart';
import 'package:dms_admin/Pages/Home/home_page.dart';
import 'package:fluro/fluro.dart' as ModularRouter;
import 'package:flutter/material.dart';
import 'package:dms_admin/Pages/Login/login_page.dart';
import 'package:dms_admin/Pages/Signup/signup_page.dart';
import 'package:dms_admin/Pages/Welcome/welcome_page.dart';

class FluroRouter {
  static const String dashboard = Dashboard.routeName;
  static const String product = ProductPage.routeName;

  static ModularRouter.Router router = ModularRouter.Router();

  static ModularRouter.Handler _welcomeHandler = ModularRouter.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          WelcomePage());

  static ModularRouter.Handler _loginHandler = ModularRouter.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          LoginPage());

  static ModularRouter.Handler _signupHandler = ModularRouter.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          SignUpPage());
  static ModularRouter.Handler _homeHandler = ModularRouter.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          HomePage());

  static ModularRouter.Handler _dashboardHandler = ModularRouter.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Dashboard());
  static ModularRouter.Handler _productHandler = ModularRouter.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          ProductPage());

  // static ModularRouter.Handler _projectHandler = ModularRouter.Handler(
  //     handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
  //         ProjectPage(username: params['username'][0]));
  static void setupRouter() {
    router.define('welcome',
        handler: _welcomeHandler,
        transitionType: ModularRouter.TransitionType.inFromBottom);

    router.define('login',
        handler: _loginHandler,
        transitionType: ModularRouter.TransitionType.inFromBottom);

    router.define('signup',
        handler: _signupHandler,
        transitionType: ModularRouter.TransitionType.inFromBottom);

    router.define('home',
        handler: _homeHandler,
        transitionType: ModularRouter.TransitionType.inFromBottom);
    router.define('dashboard',
        handler: _dashboardHandler,
        transitionType: ModularRouter.TransitionType.inFromBottom);
    router.define('product',
        handler: _productHandler,
        transitionType: ModularRouter.TransitionType.inFromBottom);
  }
}
