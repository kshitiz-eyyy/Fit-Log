import 'package:flutter/material.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({super.key});

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  int rating = 0;
  final TextEditingController feedbackController = TextEditingController();

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color neonGreen = Color(0xFFC6FF00);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: const AssetImage('assets/images/logo.png'),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "PERFORMANCE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: neonGreen),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      color: neonGreen,
                      size: 55,
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "14 DAY STREAK!",
                            style: TextStyle(
                              color: neonGreen,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "You're crushing your performance goals. Keep the momentum going!",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Enjoying the\nexperience?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Your feedback fuels our precision.\nRate your training journey so far.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                            (index) => IconButton(
                          iconSize: 48,
                          onPressed: () {
                            setState(() {
                              rating = index + 1;
                            });
                          },
                          icon: Icon(
                            rating > index
                                ? Icons.star
                                : Icons.star_border,
                            color: rating > index
                                ? neonGreen
                                : Colors.white38,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "OPTIONAL FEEDBACK",
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: feedbackController,
                      maxLines: 5,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText:
                        "Tell us what you love or how we can improve...",
                        hintStyle:
                        const TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: neonGreen,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Rating: $rating ⭐\n${feedbackController.text}",
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "SUBMIT REVIEW",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "MAYBE LATER",
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}