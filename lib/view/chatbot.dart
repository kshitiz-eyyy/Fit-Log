import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FitnessCoachChatScreen extends StatefulWidget {
  const FitnessCoachChatScreen({super.key});

  @override
  State<FitnessCoachChatScreen> createState() => _FitnessCoachChatScreenState();
}

class _FitnessCoachChatScreenState extends State<FitnessCoachChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;

  late GenerativeModel _model;

  @override
  void initState() {
    super.initState();
    // Using gemini-1.5-flash for the best balance of speed and performance
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    _model = GenerativeModel(
      model: 'gemini-3.5-flash',
      apiKey: 'AQ.Ab8RN6KRBFR5i2KKHGbQyUbjgj0J4pBETchJTTQhs-fHeGMPxw',
    );
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;
    final userText = _controller.text;

    setState(() {
      _messages.add({"text": userText, "isUser": true});
      _messages.add({"text": "", "isUser": false}); // Placeholder for stream
      _isLoading = true;
    });
    _controller.clear();

    try {
      // Using generateContentStream for instant response rendering
      final responseStream = _model.generateContentStream([
        Content.text("You are a professional fitness coach for FitLog. Answer: $userText")
      ]);

      await for (final chunk in responseStream) {
        if (chunk.text != null) {
          setState(() {
            _messages.last["text"] += chunk.text!;
          });
        }
      }
    } catch (e) {
      setState(() {
        _messages.last["text"] = "Error: Could not reach the AI. Check your API key or connection.";
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: const Text("Kshitiz AI Coach", style: TextStyle(color: Color(0xFFCCFF00))),
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return Align(
                    alignment: msg["isUser"] ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: msg["isUser"] ? const Color(0xFFCCFF00) : const Color(0xFF161616),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        msg["text"],
                        style: TextStyle(color: msg["isUser"] ? Colors.black : Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_isLoading) const LinearProgressIndicator(color: Color(0xFFCCFF00)),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: const Color(0xFF161616),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Ask your coach...",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFFCCFF00)),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}