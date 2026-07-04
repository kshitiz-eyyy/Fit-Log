import 'package:fitlog/theme/app_theme.dart';
import 'package:fitlog/view/user_profile.dart';
import 'package:fitlog/viewmodel/rate_view_model.dart';
import 'package:flutter/material.dart';

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
    final colors = AppTheme.colorsOf(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: colors.textPrimary,
                          size: 22,
                        ),
                      ),
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "PERFORMANCE",
                        style: TextStyle(
                          color: colors.textPrimary,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications_none,
                          color: colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colors.surfaceCard,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: colors.neonAccent),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: colors.neonAccent,
                          size: 55,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            "You're crushing your performance goals. Keep the momentum going!",
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: colors.surfaceCard,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Enjoying the\nexperience?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Your feedback fuels our precision.\nRate your training journey so far.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colors.textSecondary,
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
                              onPressed: () => _viewModel.setRating(index + 1),
                              icon: Icon(
                                _viewModel.rating > index
                                    ? Icons.star
                                    : Icons.star_border,
                                color: _viewModel.rating > index
                                    ? colors.neonAccent
                                    : colors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "OPTIONAL FEEDBACK",
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _viewModel.feedbackController,
                          maxLines: 5,
                          style: TextStyle(color: colors.textPrimary),
                          decoration: InputDecoration(
                            hintText:
                                "Tell us what you love or how we can improve...",
                            hintStyle: TextStyle(
                              color: colors.textSecondary.withValues(alpha: 0.6),
                            ),
                            filled: true,
                            fillColor: colors.background,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: colors.border),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: colors.border),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.neonAccent,
                              foregroundColor: colors.background,
                            ),
                            onPressed: _viewModel.isSubmitting
                                ? null
                                : () async {
                                    if (_viewModel.rating == 0) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Please select a star rating first.",
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    final success =
                                        await _viewModel.submitReview();
                                    if (!context.mounted) return;

                                    if (success) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Review saved to cloud (${_viewModel.rating} stars)",
                                          ),
                                        ),
                                      );
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfileScreen(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            _viewModel.errorMessage ??
                                                "Failed to save review.",
                                          ),
                                        ),
                                      );
                                    }
                                  },
                            child: _viewModel.isSubmitting
                                ? SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: colors.background,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : const Text(
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
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "MAYBE LATER",
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
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
