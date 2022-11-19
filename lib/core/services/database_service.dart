import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import '../models/body/quotes_body.dart';
import '../others/logger_customizations/custom_logger.dart';

class DatabaseService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static final Logger log = CustomLogger(className: 'DATABASE SERVICE');
  List<QuotesBody> quotesList = [];

  getData() async {
    final _db = FirebaseFirestore.instance;

    try {
      final snapshot = await _db.collection('Data').doc('quotes').get();

      List data = snapshot.data()?['quotesList'];
      log.d(data.toString());

      // data.forEach((element) {
      //   quotesList.add(QuotesBody.fromJson(element));
      // });
      // log.d(quotesList.first.quote);
      // log.d(quotesList.first.author);
      for (int i = 0; i < data.length; i++) {
        List quote = data[i].toString().split('--');
        if (quote.length > 1) {
          quotesList.add(QuotesBody(quote: quote[0], author: '--' + quote[1]));
        }
      }

      log.d('===========================[${data.length}');
      log.d(data.last);
      log.d('===========================[${quotesList.length}');
      log.d(quotesList.last.quote);
      log.d(quotesList.last.author);
    } catch (e, s) {
      log.d('Exception @DatabaseService/getUserGeneralProfile');
      log.d(s.toString());
    }
  }
}
