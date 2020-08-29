import 'package:quoto/services/network_helper.dart';

const quoteApiUrl =
    'https://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json';

class Quote {
  String quoteText;
  String quoteAuthor;

  Quote({
    this.quoteText,
    this.quoteAuthor,
  });

  Future getRandomQuote() async {
    NetworkHelper networkHelper = NetworkHelper(url: quoteApiUrl);
    var quoteData = await networkHelper.getData();
    if (quoteData != null) {
      return Quote(
        quoteText: quoteData['quoteText'],
        quoteAuthor: quoteData['quoteAuthor'],
      );
    }
    return null;
  }
}
