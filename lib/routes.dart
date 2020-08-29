import 'package:flutter/material.dart';
import 'package:quoto/screens/favourite_quote_screen.dart';
import 'package:quoto/screens/main_screen.dart';

//Enlist All Routes here
final Map<String, WidgetBuilder> routes = {
  MainScreen.routeName: (context) => MainScreen(),
  FavouriteQuoteScreen.routeName: (context) => FavouriteQuoteScreen(),
};
