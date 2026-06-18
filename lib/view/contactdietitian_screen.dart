import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const neon = Color(0xFFD7FF00);

    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF111111),
        selectedItemColor: neon,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: 4,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: "Train",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: "Fuel",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop),
            label: "Cycle",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: "Insights",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: "Support",
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              _header(),
              const SizedBox(height: 20),
              _nutritionistCard(),
              const SizedBox(height: 20),
              _chatSection(),
              const SizedBox(height: 20),
              _mealLogs(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/profile.jpg"),
          ),
          const SizedBox(width: 12),
          const Text(
            "PERFORMANCE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
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
          )
        ],
      ),
    );
  }

  Widget _nutritionistCard() {
    const neon = Color(0xFFD7FF00);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: neon,
            child: const CircleAvatar(
              radius: 42,
              backgroundImage: AssetImage("assets/nutritionist.jpg"),
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "Dr. Sarah Chen",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "SENIOR PERFORMANCE NUTRITIONIST",
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: neon,
              foregroundColor: Colors.black,
              shape: const StadiumBorder(),
            ),
            onPressed: () {},
            icon: const Icon(Icons.phone),
            label: const Text("SCHEDULE CALL"),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: neon),
              foregroundColor: neon,
              shape: const StadiumBorder(),
            ),
            onPressed: () {},
            icon: const Icon(Icons.videocam),
            label: const Text("VIDEO CONSULT"),
          ),
        ],
      ),
    );
  }

  Widget _chatSection() {
    const neon = Color(0xFFD7FF00);

    return Container(
      height: 360,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                "CONVERSATION",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "TYPING...",
                style: TextStyle(
                  color: Color(0xFFD7FF00),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 260,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Text(
                "Great job on your protein intake yesterday! Let's try to increase the fiber in your pre-workout meal today.",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 250,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xFFD7FF00).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Text(
                "Sounds good! I've shared my lunch log.",
                style: TextStyle(color: Color(0xFFD7FF00)),
              ),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              const Icon(Icons.add_circle_outline, color: Colors.white70),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Send a message...",
                      hintStyle: TextStyle(color: Colors.white54),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send, color: Color(0xFFD7FF00)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _mealLogs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                "Shared Meal Logs",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "VIEW ALL",
                style: TextStyle(
                  color: Color(0xFFD7FF00),
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          mealCard(
            "assets/salmon.jpg",
            "Post-Workout Salmon Bowl",
            "TODAY • 12:45 PM",
          ),
          const SizedBox(height: 20),
          mealCard(
            "assets/egg.jpg",
            "Avocado & Egg Sourdough",
            "YESTERDAY • 08:30 AM",
          ),
        ],
      ),
    );
  }

  Widget mealCard(String image, String title, String time) {
    const neon = Color(0xFFD7FF00);

    return Container(
      height: 240,
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        time,
                        style: const TextStyle(
                          color: neon,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.check_circle_outline,
                  color: neon,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
