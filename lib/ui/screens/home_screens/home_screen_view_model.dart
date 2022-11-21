import 'dart:math';

import 'package:logger/logger.dart';
import 'package:on_call_protection/core/others/base_view_model.dart';
import 'package:on_call_protection/core/services/auth_service.dart';
import 'package:on_call_protection/core/services/local_storage_service.dart';
import 'package:on_call_protection/locator.dart';

import '../../../core/services/database_service.dart';

class HomeViewModel extends BaseViewModel {
  AuthService authService = locator<AuthService>();
  final databaseService = locator<DatabaseService>();
  LocalStorageService localStorageService = locator<LocalStorageService>();
  bool isFloadButtonActive = true;

  final log = Logger();
  HomeViewModel() {
    getRadomQuote();
    getQuoteOfTheDay();
  }
  String? quote = '';
  String? author = '';
  String? quoteOfTheDay = '';
  String? authorOfTheDay = '';
  //
  //project
  updateFloatButton(index) {
    if (index == 0) {
      isFloadButtonActive = true;
    } else {
      isFloadButtonActive = false;
    }

    notifyListeners();
  }
  //

  getRadomQuote() async {
    int randomNumber = Random().nextInt(databaseService.quotesList.length - 1);
    log.i('>>>>>>>>>>>>> $randomNumber');
    quote = databaseService.quotesList[randomNumber].quote;
    author = databaseService.quotesList[randomNumber].author;
    notifyListeners();
  }

  getQuoteOfTheDay() async {
    log.i(DateTime.now().toString());
    DateTime date1 = DateTime.parse(localStorageService.lastDateOfTheDayQuote);
    Duration difference = DateTime.now().difference(date1);
    int days = difference.inDays;
    if (days >= 1) {
      int randomNumber =
      Random().nextInt(databaseService.quotesList.length - 1);
      quoteOfTheDay = databaseService.quotesList[randomNumber].quote;
      authorOfTheDay = databaseService.quotesList[randomNumber].author;
      updateTodayQuote(
          newDateTime: DateTime.now().toString(), newRandomNo: randomNumber);
    } else {
      quoteOfTheDay = databaseService
          .quotesList[localStorageService.newRandomQuoteIndexofTheDay].quote;
      authorOfTheDay = databaseService
          .quotesList[localStorageService.newRandomQuoteIndexofTheDay].author;
    }
  }

  updateTodayQuote({required int newRandomNo, required String newDateTime}) {
    localStorageService.lastDateOfTheDayQuote = newDateTime;
    localStorageService.newRandomQuoteIndexofTheDay = newRandomNo;
    notifyListeners();
  }
}
