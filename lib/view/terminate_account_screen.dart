import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/terminate_account_viewmodel.dart';
import 'welcome_screen.dart';

class TerminateAccountScreen extends StatelessWidget {
  const TerminateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TerminateAccountViewModel(),
      child: const _TerminateAccountView(),
    );
  }
}

class _TerminateAccountView extends StatelessWidget {
  const _TerminateAccountView();

  static const Color backgroundColor = Colors.black;
  static const Color cardBackgroundColor = Color(0xFF1C1C1E);
  static const Color accentColor = Color(0xFFD0FD3E);
  static const Color warningColor = Color(0xFFFF5A1F);
  static const Color textColor = Colors.white;
  static const Color secondaryTextColor = Color(0xFF8E8E93);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TerminateAccountViewModel>();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Row(
                  children: const [
                    Icon(Icons.desktop_windows, color: secondaryTextColor, size: 16),
                    SizedBox(width: 8),
                    Text(
                      'delete account',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF333333)),
                        color: const Color(0xFF1C1C1E),
                      ),
                      child: const Center(
                        child: Icon(Icons.person_outline, color: Colors.grey, size: 24),
                      ),
                    ),
                    const Text(
                      'FITLOG',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Icon(Icons.notifications_outlined, color: textColor, size: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
      body: viewModel.isLoading && viewModel.user == null
          ? const Center(child: CircularProgressIndicator(color: accentColor))
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'ATHLETE PROFILE',
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            'ACCOUNT',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            'Member Since',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'MAR 2023',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'PERSONAL DETAILS',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'EDIT ALL',
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildDetailCard('FULL NAME', viewModel.user?.name ?? 'Loading...'),
                  const SizedBox(height: 12),
                  _buildDetailCard('EMAIL ADDRESS', viewModel.user?.email ?? 'Loading...'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildStatCard('HEIGHT', viewModel.user?.height ?? '--', 'cm')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildStatCard('WEIGHT', viewModel.user?.weight ?? '--', 'kg')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildStatCard('BODY FAT', '10.2', '%')), // Body fat not in model yet
                    ],
                  ),
                  const SizedBox(height: 40),
                  _buildTerminateSection(context, viewModel),
                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }

  Widget _buildDetailCard(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: secondaryTextColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, String unit) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: secondaryTextColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(
                  unit,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTerminateSection(BuildContext context, TerminateAccountViewModel viewModel) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1210),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: warningColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.warning_amber_rounded, color: warningColor, size: 24),
              SizedBox(width: 16),
              Text(
                'TERMINATE\nACCOUNT',
                style: TextStyle(
                  color: warningColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'This action is permanent and cannot be undone. All workout history, physiological data, and earned badges will be purged from the Forge Performance servers.',
            style: TextStyle(
              color: secondaryTextColor,
              fontSize: 12,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: viewModel.toggleUnderstandRisks,
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFF3A3A3C)),
                    color: viewModel.understandRisks ? const Color(0xFF3A3A3C) : Colors.transparent,
                  ),
                  child: viewModel.understandRisks
                      ? const Icon(Icons.check, color: Colors.white, size: 12)
                      : null,
                ),
                const SizedBox(width: 12),
                const Text(
                  'I UNDERSTAND THE DATA LOSS RISKS',
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: viewModel.isLoading
                  ? null
                  : () async {
                      final success = await viewModel.terminateAccount();
                      if (success && context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                          (route) => false,
                        );
                      } else if (viewModel.error != null && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(viewModel.error!)),
                        );
                      }
                    },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: warningColor),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: viewModel.isLoading
                  ? const CircularProgressIndicator(color: warningColor)
                  : const Text(
                      'DELETE ACCOUNT',
                      style: TextStyle(
                        color: warningColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'REQUIRES MULTI-FACTOR VERIFICATION',
              style: TextStyle(
                color: Color(0xFF48484A),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      color: Colors.black,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem('Dash', Icons.grid_view_outlined, false),
          _buildNavItem('Train', Icons.fitness_center, false),
          _buildNavItem('Fuel', Icons.restaurant, false),
          _buildNavItem('Goals', Icons.history, false),
          _buildNavItem('Admin', Icons.fingerprint, true),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, IconData icon, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isSelected)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: accentColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.black, size: 20),
          )
        else
          Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? accentColor : Colors.white,
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

