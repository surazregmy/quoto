import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quoto/components/custom_button.dart';
import 'package:quoto/models/quote.dart';
import 'package:quoto/screens/favourite_quote_screen.dart';

import '../constants.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = 'main_screen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final realTimeDatabase = FirebaseDatabase.instance.reference();
  var user;
  String errorMessage;
  IconData favIconData = EvaIcons.heartOutline;
  Quote quote;

  @override
  void initState() {
    super.initState();
    getRandomQuotes();
  }

  void getRandomQuotes() async {
    Quote randomQuote = await Quote().getRandomQuote();
    if (randomQuote != null) {
      setState(() {
        print(randomQuote.quoteText);
        print(randomQuote.quoteAuthor);
        quote = randomQuote;
        setState(() {
          favIconData = EvaIcons.heartOutline;
        });
      });
    } else {
      setState(() {
        errorMessage =
            "Some Error Occured! May be you are not connected with Internet!";
        print(errorMessage);
      });
    }
  }

  void markFovourite(context) async {
    try {
      await realTimeDatabase.child("quotes").push().set({
        'quoteText': quote.quoteText,
        'quoteAuthor': quote.quoteAuthor,
      }).then((value) {
        raiseSnackBar(context, "Marked as Favourite!!!");
        setState(() {
          favIconData = EvaIcons.heart;
        });
      });
    } catch (exception) {
      print(exception);
      raiseSnackBar(context, "Error in Marking Favourite");
    }
  }

  void raiseSnackBar(context, title) {
    final snackBar = SnackBar(content: Text(title));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "Quoto",
                          style: kheadingTextStyle,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      alignment: Alignment.bottomRight,
                      child: CustomButton(
                        inkColor: Colors.brown.shade300,
                        iconColor: Colors.white,
                        icon: EvaIcons.bookmarkOutline,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, FavouriteQuoteScreen.routeName);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(25),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 8,
                            child: quote != null
                                ? Column(
                                    children: [
                                      Expanded(
                                        flex: 9,
                                        child: Center(
                                          child: Text(
                                            '"${quote.quoteText}"',
                                            style: kQuoteTextStyle,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            '- ${quote.quoteAuthor}',
                                            style: kQuoteAuthorTextStyle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : spinner,
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.bottomRight,
                              child: CustomButton(
                                icon: favIconData,
                                iconColor: Colors.red,
                                onPressed: () => markFovourite(context),
                              ),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFaa00ff),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Center(
                        child: CustomButton(
                          inkColor: Colors.green.shade300,
                          iconColor: Colors.white,
                          icon: EvaIcons.refreshOutline,
                          onPressed: () => getRandomQuotes(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
