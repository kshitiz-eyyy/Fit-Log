import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/tainer_view_model.dart';


class ContactTrainerScreen extends StatelessWidget {
  const ContactTrainerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Injecting the view model locally right here so main.dart doesn't have to change!
    return ChangeNotifierProvider(
      create: (_) => TrainerViewModel(),
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          backgroundColor: const Color(0xFF121212),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFCCFF00), size: 18),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "IRON & ONYX",
            style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text("Contact Trainer?", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text("Want a personal guidance?", style: TextStyle(color: Colors.grey, fontSize: 18, fontStyle: FontStyle.italic)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                decoration: BoxDecoration(color: const Color(0xFFCCFF00), borderRadius: BorderRadius.circular(24)),
                child: const Text("WE GOT YOU", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 12)),
              ),
              const SizedBox(height: 24),

              // Direct Builder layer to safely grab our local provider context
              Expanded(
                child: Consumer<TrainerViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.isLoading) {
                      return const Center(child: CircularProgressIndicator(color: Color(0xFFCCFF00)));
                    }
                    if (viewModel.trainers.isEmpty) {
                      return const Center(child: Text("No trainers found in database.", style: TextStyle(color: Colors.grey)));
                    }
                    return ListView.builder(
                      itemCount: viewModel.trainers.length,
                      itemBuilder: (context, index) {
                        final trainer = viewModel.trainers[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16), // Fixed EdgeInsects syntax crash
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${index + 1}. ${trainer.name}", style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900)),
                              const SizedBox(height: 10),
                              const Divider(color: Colors.black12, thickness: 1),
                              const SizedBox(height: 6),
                              _buildDataRow("CONTACT NO:", trainer.contact),
                              _buildDataRow("EXPERIENCE:", trainer.experience),
                              _buildDataRow("SPECIALIZATION:", trainer.specialization),
                              _buildDataRow("LOCATION:", trainer.location),
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