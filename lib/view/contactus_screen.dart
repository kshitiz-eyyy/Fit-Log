import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  static const Color bg = Color(0xFF000000);
  static const Color surface = Color(0xFF222730);
  static const Color surfaceAlt = Color(0xFF171C24);
  static const Color accent = Color(0xFFC8F500);
  static const Color textLight = Color(0xFFF3F3F3);
  static const Color muted = Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Contact Us",
          style: TextStyle(
            color: textLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: textLight),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            /// Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: accent,
                    child: Icon(
                      Icons.support_agent,
                      size: 45,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Need Help?",
                    style: TextStyle(
                      color: textLight,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Our support team is always ready to assist you.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: muted,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Contact Information
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceAlt,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: const [
                  ContactTile(
                    icon: Icons.email_outlined,
                    title: "Email",
                    value: "support@fitlog.com",
                  ),
                  Divider(color: Colors.white24),
                  ContactTile(
                    icon: Icons.phone_outlined,
                    title: "Phone",
                    value: "+977 9800000000",
                  ),
                  Divider(color: Colors.white24),
                  ContactTile(
                    icon: Icons.location_on_outlined,
                    title: "Address",
                    value: "Kathmandu, Nepal",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Contact Form
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Send us a Message",
                    style: TextStyle(
                      color: textLight,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _buildTextField(
                    "Full Name",
                    Icons.person_outline,
                  ),

                  const SizedBox(height: 15),

                  _buildTextField(
                    "Email Address",
                    Icons.email_outlined,
                  ),

                  const SizedBox(height: 15),

                  _buildTextField(
                    "Subject",
                    Icons.subject,
                  ),

                  const SizedBox(height: 15),

                  _buildTextField(
                    "Message",
                    Icons.message_outlined,
                    maxLines: 5,
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                            Text("Message sent successfully!"),
                          ),
                        );
                      },
                      child: const Text(
                        "Send Message",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildTextField(
      String hint,
      IconData icon, {
        int maxLines = 1,
      }) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: textLight),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: muted),
        prefixIcon: Icon(
          icon,
          color: accent,
        ),
        filled: true,
        fillColor: const Color(0xFF2B313A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ContactTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: ContactUsScreen.accent,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          color: ContactUsScreen.muted,
        ),
      ),
    );
  }
}