import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FitnessCoachChatScreen extends StatefulWidget {
  const FitnessCoachChatScreen({super.key});

  @override
  State<FitnessCoachChatScreen> createState() => _FitnessCoachChatScreenState();
}

class _FitnessCoachChatScreenState extends State<FitnessCoachChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {
      "text": "Hello! I am your live Gemini AI Fitness Coach. Ask me absolutely anything about custom workout routines, diet macros, target recovery models, or motivation guidelines!",
      "isUser": false,
      "time": "8:39 AM"
    }
  ];
  bool _isTyping = false;

  // Your working API key from Google AI Studio
  final String _apiKey = "AQ.Ab8RN6KyTRQF6BGDUe3AIhg5eRdSFVolqlrynkqlwXlf2Upy8w";

  void _sendMessage() async {
    final String text = _messageController.text.trim();
    if (text.isEmpty) return;

    _messageController.clear();
    setState(() {
      _messages.add({"text": text, "isUser": true, "time": _getCurrentTime()});
      _isTyping = true;
    });
    _scrollToBottom();

    try {
      // Direct production URL endpoint configuration required for Cloud wrapped keys
      final url = Uri.parse(
          'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=$_apiKey'
      );

      // Sending the precisely structured JSON request body matching the v1 API specifications
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": text}
              ]
            }
          ],
          "systemInstruction": {
            "parts": [
              {
                "text": "You are an elite, unrestricted AI personal trainer inside the FitLog application. Answer accurately and conversationally. Keep tips practical, professional, energetic, and concise (under 4 sentences)."
              }
            ]
          }
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['candidates'] != null && data['candidates'].isNotEmpty) {
          final String aiReply = data['candidates'][0]['content']['parts'][0]['text'].toString().trim();

          if (!mounted) return;
          setState(() {
            _isTyping = false;
            _messages.add({"text": aiReply, "isUser": false, "time": _getCurrentTime()});
          });
        } else {
          throw Exception("No text response content generated.");
        }
      } else {
        throw Exception("Server responded with code ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add({
          "text": "⚠️ Gemini Live Integration Error:\n$e",
          "isUser": false,
          "time": _getCurrentTime()
        });
      });
    } finally {
      _scrollToBottom();
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final amPm = now.hour >= 12 ? 'PM' : 'AM';
    return "$hour:$minute $amPm";
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161616),
        elevation: 1,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFFCCFF00),
                child: Icon(Icons.psychology, size: 18, color: Colors.black)
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("FitLog Full AI Engine", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                Text("Online • Direct REST Protocol", style: TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final bool isUser = message["isUser"];
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFFCCFF00) : const Color(0xFF161616),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft: Radius.circular(isUser ? 12 : 2),
                        bottomRight: Radius.circular(isUser ? 2 : 12),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message["text"],
                          style: TextStyle(color: isUser ? Colors.black : Colors.white, fontSize: 14, height: 1.35),
                        ),
                        const SizedBox(height: 6),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(message["time"], style: TextStyle(color: isUser ? Colors.black54 : Colors.grey.shade600, fontSize: 9)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Live Gemini is crafting a response...", style: TextStyle(color: Colors.grey.shade600, fontSize: 12, fontStyle: FontStyle.italic)),
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(color: Color(0xFF161616), border: Border(top: BorderSide(color: Colors.black45, width: 0.5))),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        hintText: "Ask absolutely anything...",
                        hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(color: Color(0xFFCCFF00), shape: BoxShape.circle),
                      child: const Icon(Icons.send, color: Colors.black, size: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}