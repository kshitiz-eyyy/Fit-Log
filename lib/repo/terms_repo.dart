
import 'dart:async';

abstract class TermsRepo {

  Future<String> fetchTerms();
}