import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../model/quote_model.dart';
import '../repo/quote_repository.dart';

class QuoteViewModel extends ChangeNotifier {
  final QuoteRepository _quoteRepository;

  List<QuoteModel> _quotes = [];
  String _currentQuote = "Loading motivation...";
  bool _isLoading = true;
  Timer? _rotationTimer;


  String get currentQuote => _currentQuote;
  bool get isLoading => _isLoading;

  QuoteViewModel({required QuoteRepository quoteRepository})
      : _quoteRepository = quoteRepository {
    loadQuotes();
  }

  Future<void> loadQuotes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _quotes = await _quoteRepository.fetchAllQuotes();
      _pickRandomQuote();
      _startRotationTimer();
    } catch (e) {
      _currentQuote = "Consistency beats talent every single day.";
      debugPrint("Error loading quotes: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _pickRandomQuote() {
    if (_quotes.isNotEmpty) {
      final random = Random();
      _currentQuote = _quotes[random.nextInt(_quotes.length)].text;
      notifyListeners();
    }
  }

  void _startRotationTimer() {
    _rotationTimer?.cancel();

    _rotationTimer = Timer.periodic(const Duration(minutes: 2), (timer) {
      _pickRandomQuote();
    });
  }

  @override
  void dispose() {
    _rotationTimer?.cancel();
    super.dispose();
  }
}