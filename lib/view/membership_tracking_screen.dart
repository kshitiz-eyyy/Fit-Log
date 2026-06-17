import 'package:flutter/material.dart';

class MembershipTrackingScreen extends StatefulWidget {
  const MembershipTrackingScreen({super.key});

  @override
  State<MembershipTrackingScreen> createState() =>
      _MembershipTrackingScreenState();
}

class _MembershipTrackingScreenState
    extends State<MembershipTrackingScreen> {
  static const Color neon = Color(0xFFD4FF00);

  int currentIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      /// BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF111111),
        selectedItemColor: neon,
        unselectedItemColor: Colors.white54,
        elevation: 0,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "HOME",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_video_sharp),
            label: "Features",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Activity",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "PROFILE",
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TOP BAR
              Row(
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: neon,
                        width: 2,
                      ),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  const Expanded(
                    child: Text(
                      "PERFORMANCE",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),

              const SizedBox(height: 35),

              /// PROFILE
              Center(
                child: Column(
                  children: [

                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: neon,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: neon.withValues(alpha: 0.4),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 65,
                        backgroundImage:
                        AssetImage("assets/images/gym.png"),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: neon,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        "PRO",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "Rijan Gunda",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Pro Member • Joined Jan 2026",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              /// MEMBERSHIP CARD
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(38),
                  border: Border.all(
                    color: neon,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: neon.withValues(alpha: 0.18),
                      blurRadius: 25,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "MEMBERSHIP STATUS",
                      style: TextStyle(
                        color: neon,
                        fontSize: 16,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        const Expanded(
                          child: Text(
                            "Premium Access",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Column(
                          children: const [

                            Text(
                              "24",
                              style: TextStyle(
                                color: neon,
                                fontSize: 52,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              "DAYS LEFT",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: 0.78,
                        minHeight: 12,
                        backgroundColor: Colors.white12,
                        valueColor:
                        const AlwaysStoppedAnimation(neon),
                      ),
                    ),

                    const SizedBox(height: 22),

                    Row(
                      children: [

                        Expanded(
                          child: Row(
                            children: const [

                              Icon(
                                Icons.calendar_month,
                                color: Colors.white70,
                                size: 20,
                              ),

                              SizedBox(width: 8),

                              Expanded(
                                child: Text(
                                  "Renews Jan 28, 2027",
                                  overflow:
                                  TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        const Text(
                          "\$29.99/mo",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 36),

              /// BUTTONS
              Row(
                children: [

                  Expanded(
                    child: actionCard(
                      icon: Icons.chat_bubble_outline,
                      label: "Contact Dietitian",
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: actionCard(
                      icon: Icons.star_border,
                      label: "Rate Us",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 42),

              /// SETTINGS TITLE
              const Text(
                "ACCOUNT SETTINGS",
                style: TextStyle(
                  color: Colors.white70,
                  letterSpacing: 2,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 22),

              /// SETTINGS CARD
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  children: [

                    settingTile(
                      icon: Icons.workspace_premium_outlined,
                      title: "Membership Details",
                    ),

                    divider(),

                    settingTile(
                      icon: Icons.settings,
                      title: "Preferences",
                    ),

                    divider(),

                    settingTile(
                      icon: Icons.lock_outline,
                      title: "Security & Privacy",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              const Center(
                child: Text(
                  "VERSION 2.4.0",
                  style: TextStyle(
                    color: Colors.white30,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget actionCard({
    required IconData icon,
    required String label,
  }) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            height: 68,
            width: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: neon.withValues(alpha: 0.12),
            ),
            child: Icon(
              icon,
              color: neon,
              size: 32,
            ),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget settingTile({
    required IconData icon,
    required String title,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 10,
      ),
      leading: Icon(
        icon,
        color: Colors.white70,
        size: 30,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.white70,
      ),
      onTap: () {},
    );
  }

  Widget divider() {
    return Divider(
      color: Colors.white.withValues(alpha: 0.08),
      height: 1,
    );
  }
}