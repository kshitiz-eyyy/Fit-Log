import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

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
      "text": "Hello! I am your AI Fitness Coach. Based on your current CNS metrics, your recovery is peaking today. Ask me anything about your training blocks, meal goals, hydration tracking, or grab some quick motivation!",
      "isUser": false,
      "time": "8:39 AM"
    }
  ];
  bool _isTyping = false;
  String _activeIntent = "";
  GenerativeModel? _model;

  final String _apiKey = "AQ.Ab8RN6Lb3kj46LrTKifeKnOKpIdtRGkX1M-3B7__f-otGFha5Q";

  @override
  void initState() {
    super.initState();
    _initializeGemini();
  }

  void _initializeGemini() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
      systemInstruction: Content.system(
          "You are an elite, highly professional AI personal trainer and fitness coach integrated within the FitLog ecosystem. "
              "Analyze user queries, provide motivating fitness or nutrition advice, and keep instructions actionable. "
              "Keep your responses concise (2-4 sentences maximum). If the user mentions chest, back, diet, or water, "
              "give a great contextual reply and tell them you can guide them to that specific dashboard section."
      ),
    );
  }

  void _sendMessage() async {
    final String text = _messageController.text.trim();
    if (text.isEmpty) return;

    _messageController.clear();
    setState(() {
      _messages.add({"text": text, "isUser": true, "time": _getCurrentTime()});
      _isTyping = true;
    });
    _scrollToBottom();

    _setIntentByKeywords(text);

    try {
      if (_model == null) throw Exception("Model uninitialized");

      final content = [Content.text(text)];
      final response = await _model!.generateContent(content);
      final aiReply = response.text?.trim() ?? "Understood. Let's adjust your metrics for today.";

      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add({"text": aiReply, "isUser": false, "time": _getCurrentTime()});
      });
    } catch (e) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add({"text": _getFallbackAIResponse(text), "isUser": false, "time": _getCurrentTime()});
      });
    } finalPath() {
      _scrollToBottom();
    }
    finalPath();
  }

  void _setIntentByKeywords(String query) {
    final lower = query.toLowerCase();
    if (lower.contains("chest") || lower.contains("bench") || lower.contains("push day")) { _activeIntent = "chest"; }
    else if (lower.contains("back") || lower.contains("pull up") || lower.contains("row")) { _activeIntent = "back"; }
    else if (lower.contains("diet") || lower.contains("meal") || lower.contains("eat") || lower.contains("calori")) { _activeIntent = "diet"; }
    else if (lower.contains("water") || lower.contains("hydrat")) { _activeIntent = "water"; }
    else if (lower.contains("quote") || lower.contains("motivat") || lower.contains("tired")) { _activeIntent = "motivation"; }
  }

  String _getFallbackAIResponse(String query) {
    final lower = query.toLowerCase();

    if (lower.contains("yes") || lower.contains("sure") || lower.contains("ok") || lower.contains("guide") || lower.contains("check")) {
      if (_activeIntent == "chest") { _activeIntent = ""; return "Go to Chest Exercise section! Head directly to the 'Library' tab in your main navigation menu to begin your routine."; }
      if (_activeIntent == "back") { _activeIntent = ""; return "Go to Back Exercise section! Open the 'Library' or 'Features' tab to view your complete pull and back tracking metrics."; }
      if (_activeIntent == "diet") { _activeIntent = ""; return "Go to Meal Log section! Tap back to your Home Dashboard and locate your nutrition card to log your food targets."; }
      if (_activeIntent == "water") { _activeIntent = ""; return "Go to Hydration section! Tap back to your Home Dashboard and use the fluid tracking counter cards."; }
      if (_activeIntent == "motivation") { _activeIntent = ""; return "Go to Motivation screen! Open your personal milestones under your profile to track your consecutive active streaks."; }
    }

    if (_activeIntent == "chest") return "Since your central nervous system fatigue is tracking exceptionally low today, it's a great opportunity for high-intensity chest tracking. Would you like me to guide you to the Chest Exercise section?";
    if (_activeIntent == "back") return "Your posterior chain recovery looks optimal today. Would you like me to guide you directly to your customized Back Exercise section?";
    if (_activeIntent == "diet") return "Current Metric Status: You've consumed 1,840 out of your 2,600 kcal ceiling. Would you like me to point you to the Meal Log section to manage your dynamic target macros?";
    if (_activeIntent == "water") return "Your current system records sit at 2.4 Liters logged. Do you want me to show you how to update your daily inputs on the Hydration section?";
    if (_activeIntent == "motivation") return "⚡️ Protocol Check: 'Discipline is the bridge between goals and accomplishment.' Do you want me to guide you straight to the Motivation screen to see your active streaks?";

    _activeIntent = "";
    return "Understood. Tell me explicitly: are we reviewing your target chest movements, checking back workouts, logging meal data, tracking water baselines, or pulling up motivation windows?";
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
        _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
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
            const CircleAvatar(radius: 16, backgroundColor: Color(0xFFCCFF00), child: Icon(Icons.smart_toy, size: 18, color: Colors.black)),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("AI Coach", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                Text("Online • Kinetic Cloud Protocol", style: TextStyle(color: Colors.grey, fontSize: 11)),
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
                        Text(message["text"], style: TextStyle(color: isUser ? Colors.black : Colors.white, fontSize: 14, height: 1.35)),
                        const SizedBox(height: 6),
                        Align(alignment: Alignment.bottomRight, child: Text(message["time"], style: TextStyle(color: isUser ? Colors.black54 : Colors.grey.shade600, fontSize: 9))),
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
              child: Align(alignment: Alignment.centerLeft, child: Text("Coach is analyzing metrics...", style: TextStyle(color: Colors.grey.shade600, fontSize: 12, fontStyle: FontStyle.italic))),
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
                        hintText: "Ask about your training, diet, motivation...",
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