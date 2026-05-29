import 'package:flutter/material.dart';

class MembershipTrackingScreen extends StatefulWidget {
  const MembershipTrackingScreen({super.key});

  @override
  State<MembershipTrackingScreen> createState() =>
      _MembershipTrackingScreenState();
}

class _MembershipTrackingScreenState extends State<MembershipTrackingScreen> {
  static const Color neon = Color(0xFFD4FF00);

  // Professional real-world transaction invoices
  final List<Map<String, String>> _billingInvoices = [
    {"date": "May 28, 2026", "id": "INV-2026-9482", "cost": "\$29.99", "type": "Visa"},
    {"date": "Apr 28, 2026", "id": "INV-2026-8103", "cost": "\$29.99", "type": "Visa"},
    {"date": "Mar 28, 2026", "id": "INV-2026-7029", "cost": "\$29.99", "type": "Visa"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TOP BAR (With Back Navigation instead of Bottom Bar)
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 24),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
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
                  IconButton(
                    icon: const Icon(Icons.notifications_none, color: Colors.white, size: 30),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("No new system notifications.")),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 35),

              /// PROFILE CARD
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
                        backgroundColor: Color(0xFF151515),
                        child: Icon(Icons.person, size: 60, color: Colors.white),
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
                        "PRO ACCESS",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
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

              /// MEMBERSHIP STATUS CARD
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(35),
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
                        fontSize: 14,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                              ),
                            ),
                            Text(
                              "DAYS LEFT",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const LinearProgressIndicator(
                        value: 0.78,
                        minHeight: 10,
                        backgroundColor: Colors.white12,
                        valueColor: AlwaysStoppedAnimation(neon),
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
                                  "Renews Jun 28, 2026",
                                  overflow: TextOverflow.ellipsis,
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

              /// PROFESSIONAL UPGRADE: PLAN PERKS AND SHOWCASE TILES
              const Text(
                "INCLUDED WITH PREMIUM",
                style: TextStyle(
                  color: Colors.white70,
                  letterSpacing: 2,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.35,
                children: [
                  _buildPerkCard(Icons.analytics_outlined, "AI Insights", "Advanced Bio-Tracking"),
                  _buildPerkCard(Icons.bolt, "No Limits", "Unlimited Daily Logs"),
                  _buildPerkCard(Icons.video_library_outlined, "HD Content", "4K Video Exercise Library"),
                  _buildPerkCard(Icons.support_agent, "V.I.P Support", "24/7 Concierge Chat"),
                ],
              ),

              const SizedBox(height: 36),

              /// PROFESSIONAL UPGRADE: WALLET MANAGEMENT
              const Text(
                "PAYMENT DETAILS",
                style: TextStyle(
                  color: Colors.white70,
                  letterSpacing: 2,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.credit_card, color: neon, size: 28),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Visa ending in •••• 4242",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Next Billing Date: June 28, 2026",
                            style: TextStyle(color: Colors.white54, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: neon, size: 22),
                      onPressed: () => _openPaymentSheet(context),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 36),

              /// PROFESSIONAL UPGRADE: DIGITAL RECEIPT INVOICES
              const Text(
                "BILLING HISTORY",
                style: TextStyle(
                  color: Colors.white70,
                  letterSpacing: 2,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white10),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _billingInvoices.length,
                  separatorBuilder: (context, index) => divider(),
                  itemBuilder: (context, index) {
                    final invoice = _billingInvoices[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.receipt_long_sharp, color: Colors.white70, size: 22),
                      ),
                      title: Text(invoice["date"]!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      subtitle: Text(invoice["id"]!, style: const TextStyle(color: Colors.white54, fontSize: 13)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(invoice["cost"]!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                          const SizedBox(width: 10),
                          const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 12),
                        ],
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Downloading invoice summary sheet ${invoice['id']}...")),
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 36),

              /// ACCOUNT SETTINGS TILES
              const Text(
                "ACCOUNT SETTINGS",
                style: TextStyle(
                  color: Colors.white70,
                  letterSpacing: 2,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF151515),
                  borderRadius: BorderRadius.circular(28),
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
                      icon: Icons.lock_outline,
                      title: "Security & Privacy",
                    ),
                    divider(),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                      leading: const Icon(Icons.no_accounts_outlined, color: Colors.redAccent, size: 28),
                      title: const Text("Cancel Subscription", style: TextStyle(color: Colors.redAccent, fontSize: 18, fontWeight: FontWeight.w500)),
                      trailing: const Icon(Icons.chevron_right, color: Colors.redAccent),
                      onTap: () => _triggerCancelFlow(context),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),
              const Center(
                child: Text(
                  "VERSION 2.4.0 (PRO)",
                  style: TextStyle(
                    color: Colors.white30,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
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

  Widget _buildPerkCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: neon, size: 26),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 11), overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget settingTile({
    required IconData icon,
    required String title,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      leading: Icon(icon, color: Colors.white70, size: 28),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white30),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Opened $title configuration sheet.")),
        );
      },
    );
  }

  Widget divider() {
    return Divider(
      color: Colors.white.withValues(alpha: 0.08),
      height: 1,
    );
  }

  void _openPaymentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF151515),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Update Billing Info", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Link a new system payment token or credit instrument securely.", style: TextStyle(color: Colors.white54, fontSize: 14)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: neon,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.add_card_outlined),
              label: const Text("Replace Credit Card", style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Secure payment flow initiated.")));
              },
            ),
            const SizedBox(height: 10),
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Dismiss", style: TextStyle(color: Colors.white30))),
          ],
        ),
      ),
    );
  }

  void _triggerCancelFlow(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF151515),
        title: const Text("Modify Premium Tier Status?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text(
          "Are you sure you want to alter your active system tier? Premium library attributes will remain active until the billing expiration cycle concludes.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Retain Premium", style: TextStyle(color: neon))),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Subscription parameters verified successfully.")));
            },
            child: const Text("Cancel Plan", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}