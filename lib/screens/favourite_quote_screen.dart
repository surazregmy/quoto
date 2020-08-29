import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:quoto/components/custom_button.dart';
import 'package:quoto/constants.dart';

class FavouriteQuoteScreen extends StatefulWidget {
  static const String routeName = 'fovourite_quote_screen';
  @override
  _FavouriteQuoteScreenState createState() => _FavouriteQuoteScreenState();
}

class _FavouriteQuoteScreenState extends State<FavouriteQuoteScreen> {
  final realTimeDatabase = FirebaseDatabase.instance.reference();

  void delete(snapshotKey) async {
    await realTimeDatabase.child('quotes').child(snapshotKey).remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  CustomButton(
                    iconColor: Colors.grey,
                    icon: EvaIcons.arrowBack,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    "Saved Quotes",
                    style: kQuoteTextStyle,
                  ),
                ],
              ),
            ),
            Flexible(
              child: FirebaseAnimatedList(
                  defaultChild: spinner,
                  query: realTimeDatabase
                      .child('quotes')
                      .orderByChild('timeOfFav')
                      .limitToLast(10),
                  itemBuilder: (_, DataSnapshot snapshot,
                      Animation<double> animation, int x) {
                    return SafeArea(
                      child: Card(
                          child: Column(
                        children: [
                          ListTile(
                            subtitle: Text(
                              snapshot.value['quoteText'],
                              style: kQuoteSavedTextStyle,
                            ),
                            title: Text(
                              snapshot.value['quoteAuthor'],
                              style: kQuoteSavedAuthorTextStyle,
                            ),
                          ),
                          ButtonBar(
                            children: [
                              CustomButton(
                                icon: EvaIcons.heart,
                                iconColor: Colors.red.shade300,
                                onPressed: () => delete(snapshot.key),
                              )
                            ],
                          )
                        ],
                      )),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
