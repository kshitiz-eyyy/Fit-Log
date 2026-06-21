import '../model/quote_model.dart'; // Adjust path if necessary

abstract class QuoteRepository {
  Future<List<QuoteModel>> fetchAllQuotes();
}