import 'package:fitlog/view/user_profile.dart';
import 'package:flutter/material.dart';
// TODO: Adjust these paths based on your actual directory configuration

import 'package:fitlog/viewmodel/rate_view_model.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({super.key});

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  late final RateViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = RateViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color neonGreen = Color(0xFFC6FF00);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  // Top Header Row
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfileScreen()),
                          );
                        },
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                      ),
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "PERFORMANCE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none, color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Info Banner
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF111111),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: neonGreen),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.local_fire_department, color: neonGreen, size: 55),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 6),
                              Text(
                                "You're crushing your performance goals. Keep the momentum going!",
                                style: TextStyle(color: Colors.white70, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Main Interactive Card
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
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        const SizedBox(height: 30),

                        // Interactive Stars
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            5,
                                (index) => IconButton(
                              iconSize: 48,
                              onPressed: () => _viewModel.setRating(index + 1),
                              icon: Icon(
                                _viewModel.rating > index ? Icons.star : Icons.star_border,
                                color: _viewModel.rating > index ? neonGreen : Colors.white38,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "OPTIONAL FEEDBACK",
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Form input linked directly to the ViewModel controller
                        TextField(
                          controller: _viewModel.feedbackController,
                          maxLines: 5,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Tell us what you love or how we can improve...",
                            hintStyle: const TextStyle(color: Colors.white38),
                            filled: true,
                            fillColor: Colors.black,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Submission Processing Button
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: neonGreen,
                              foregroundColor: Colors.black,
                            ),
                            onPressed: _viewModel.isSubmitting
                                ? null
                                : () async {
                              if (_viewModel.rating == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Please select a star rating first.")),
                                );
                                return;
                              }

                              bool success = await _viewModel.submitReview();
                              if (context.mounted && success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Rating Locked: ${_viewModel.rating} ⭐\n${_viewModel.feedbackController.text}",
                                    ),
                                  ),
                                );
                                // Return safely back to profile hub upon completion
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                                );
                              }
                            },
                            child: _viewModel.isSubmitting
                                ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2.5),
                            )
                                : const Text(
                              "SUBMIT REVIEW",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Neutral action button redirect
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const ProfileScreen()),
                            );
                          },
                          child: const Text(
                            "MAYBE LATER",
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}