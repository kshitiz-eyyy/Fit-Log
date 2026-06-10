import 'package:flutter/material.dart';
import 'admin_panel_screen.dart';
import 'user_dashboard.dart';

class TestingGatewayScreen extends StatelessWidget {
  const TestingGatewayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              const Icon(
                Icons.terminal,
                color: Color(0xFFCCFF00),
                size: 64,
              ),
              const SizedBox(height: 16),
              const Text(
                "FITLOG SYSTEM GATEWAY",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFCCFF00),
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "SELECT AN ENVIRONMENT TO EXECUTE PIPELINE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 48),


              ElevatedButton.icon(
                icon: const Icon(Icons.admin_panel_settings, color: Colors.black, size: 20),
                label: const Text(
                  "LAUNCH SYSTEM ROOT (ADMIN)",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCCFF00),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminPanelScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),


              ElevatedButton.icon(
                icon: const Icon(Icons.directions_run, color: Color(0xFFCCFF00), size: 20),
                label: const Text(
                  "LAUNCH ATHLETE INSTANCE (USER)",
                  style: TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Color(0xFFCCFF00), width: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DashboardScreen()),
                  );
                },
              ),
              const SizedBox(height: 32),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF161616),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.shade900),
                ),
                child: const Text(
                  "DIAGNOSTIC PROCESS PLAN:\n1. Open ADMIN terminal viewport.\n2. Modify the challenge text field & save it.\n3. Exit via the power icon in the top right corner.\n4. Open USER dashboard viewport.\n5. Verify that your challenge has dynamic synchronization!",
                  style: TextStyle(color: Colors.grey, fontSize: 11, height: 1.5, fontFamily: 'monospace'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}