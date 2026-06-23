import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/dietitian_view_model.dart';

class ContactDietitianScreen extends StatelessWidget {
  const ContactDietitianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DietitianViewModel(),
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFCCFF00), size: 18),
            onPressed: () => Navigator.pop(context),
          ),

          centerTitle: true,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/diet.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.85),
                BlendMode.darken,
              ),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text("Contact Dietitian?", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text("Want a customized diet plan?", style: TextStyle(color: Colors.grey, fontSize: 18, fontStyle: FontStyle.italic)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                    decoration: BoxDecoration(color: const Color(0xFFCCFF00), borderRadius: BorderRadius.circular(24)),
                    child: const Text("WE GOT YOU", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 12)),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Consumer<DietitianViewModel>(
                      builder: (context, viewModel, child) {
                        if (viewModel.isLoading) {
                          return const Center(child: CircularProgressIndicator(color: Color(0xFFCCFF00)));
                        }
                        if (viewModel.dietitian.isEmpty) {
                          return const Center(child: Text("No dietitians found in database.", style: TextStyle(color: Colors.grey)));
                        }
                        return ListView.builder(
                          itemCount: viewModel.dietitian.length,
                          itemBuilder: (context, index) {
                            final dietitian = viewModel.dietitian[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.95),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${index + 1}. ${dietitian.name}", style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900)),
                                  const SizedBox(height: 10),
                                  const Divider(color: Colors.black12, thickness: 1),
                                  const SizedBox(height: 6),
                                  _buildDataRow("CONTACT NO:", dietitian.contact),
                                  _buildDataRow("EXPERIENCE:", dietitian.experience),
                                  _buildDataRow("SPECIALIZATION:", dietitian.specialization),
                                  _buildDataRow("LOCATION:", dietitian.location),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold))),
          Expanded(child: Text(val, style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}