import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fitlog/viewmodel/user_view_model.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  // Theme Colors
  static const Color bg = Color(0xFF000000);
  static const Color surface = Color(0xFF222730);
  static const Color surfaceAlt = Color(0xFF171C24);



  static const Color accent = Color(0xFFC8F500);
  static const Color textLight = Color(0xFFF3F3F3);
  static const Color muted = Color(0xFF9CA3AF);

  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserViewModel>().fetchAdminProfile();
    });
  }

  // ── NEW: Single Field Edit Dialog (For Name) ───────────────────
  void _showEditNameDialog(UserViewModel vm) {
    final nameController = TextEditingController(text: vm.adminName);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Update Name",
              style: TextStyle(color: textLight, fontWeight: FontWeight.bold)),
          content: TextField(
            controller: nameController,
            style: const TextStyle(color: textLight),
            decoration: InputDecoration(
              labelText: "Full Name",
              labelStyle: const TextStyle(color: muted),
              prefixIcon: const Icon(Icons.person, color: accent),
              filled: true,
              fillColor: bg,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: surface)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: accent)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel", style: TextStyle(color: muted)),
            ),
            Consumer<UserViewModel>(
              builder: (_, vm2, __) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: vm2.isSaving
                      ? null
                      : () async {
                    final newName = nameController.text.trim();
                    if (newName.isEmpty) {
                      _showSnack("Name cannot be empty", isError: true);
                      return;
                    }

                    final success = await vm2.updateAdminProfile(
                      name: newName,
                      email: vm.adminEmail,
                      phone: vm.adminPhone,
                      location: vm.adminLocation,
                    );

                    if (!mounted) return;
                    Navigator.pop(ctx);
                    _showSnack(
                        success ? "Name updated!" : "Failed to update",
                        isError: !success);
                  },
                  child: vm2.isSaving
                      ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.black))
                      : const Text("Save"),
                );
              },
            ),
          ],
        );
      },
    );
  }

  // ── Avatar picker ──────────────────────────────────────────────
  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked == null) return;
    setState(() => _pickedImage = File(picked.path));

    if (!mounted) return;
    final success = await context.read<UserViewModel>().uploadAvatar(_pickedImage!);
    _showSnack(
      success ? "Avatar updated" : "Avatar upload failed",
      isError: !success,
    );
  }

  // ── Full Edit Profile Dialog ───────────────────────────────────
  void _showEditProfileDialog(UserViewModel vm) {
    final nameCtrl = TextEditingController(text: vm.adminName);
    final emailCtrl = TextEditingController(text: vm.adminEmail);
    final phoneCtrl = TextEditingController(text: vm.adminPhone);
    final locationCtrl = TextEditingController(text: vm.adminLocation);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Edit Profile Details",
            style: TextStyle(color: textLight, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _field(nameCtrl, "Full Name", Icons.person),
              const SizedBox(height: 12),
              _field(emailCtrl, "Email Address", Icons.email),
              const SizedBox(height: 12),
              _field(phoneCtrl, "Phone Number", Icons.phone),
              const SizedBox(height: 12),
              _field(locationCtrl, "Location", Icons.location_on),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel", style: TextStyle(color: muted)),
          ),
          Consumer<UserViewModel>(
            builder: (_, vm2, __) => ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: vm2.isSaving
                  ? null
                  : () async {
                if (nameCtrl.text.trim().isEmpty) {
                  _showSnack("Name is required", isError: true);
                  return;
                }
                final success = await vm2.updateAdminProfile(
                  name: nameCtrl.text.trim(),
                  email: emailCtrl.text.trim(),
                  phone: phoneCtrl.text.trim(),
                  location: locationCtrl.text.trim(),
                );

                if (!mounted) return;
                Navigator.pop(ctx);
                _showSnack(
                    success ? "Profile updated!" : "Update failed",
                    isError: !success);
              },
              child: vm2.isSaving
                  ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.black))
                  : const Text("Save Changes"),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: isError ? Colors.redAccent : accent,
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, vm, _) {
        if (vm.isLoading) {
          return const Scaffold(
            backgroundColor: bg,
            body: Center(child: CircularProgressIndicator(color: accent)),
          );
        }

        return Scaffold(
          backgroundColor: bg,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Header Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        color: surface,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        )),
                    child: Column(
                      children: [
                        _buildAvatarSection(vm),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => _showEditNameDialog(vm),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                vm.adminName.isEmpty
                                    ? "Admin Name"
                                    : vm.adminName,
                                style: const TextStyle(
                                    color: textLight,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.edit, color: accent, size: 18),
                            ],
                          ),
                        ),
                        const Text("System Administrator",
                            style: TextStyle(color: muted)),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: () => _showEditProfileDialog(vm),
                          icon: const Icon(Icons.edit, size: 16),
                          label: const Text("Edit Profile"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: accent,
                            side: const BorderSide(color: accent),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _sectionCard(
                    title: "Personal Information",
                    onTap: () => _showEditProfileDialog(vm),
                    trailing: const Icon(Icons.chevron_right, color: muted),
                    children: [
                      _infoTile(Icons.email, "Email", vm.adminEmail),
                      _infoTile(Icons.phone, "Phone", vm.adminPhone),
                      _infoTile(
                          Icons.location_on, "Location", vm.adminLocation),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _sectionCard(
                    title: "Admin Statistics",
                    children: [
                      _infoTile(
                          Icons.group, "Total Members", "${vm.totalMembers}"),
                      _infoTile(Icons.fitness_center, "Active Trainers",
                          "${vm.activeTrainers}"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _sectionCard(
                    title: "Account",
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.logout_rounded,
                          color: Colors.redAccent,
                        ),
                        title: const Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () async {
                          final success =
                              await context.read<UserViewModel>().logout();

                          if (!mounted) return;

                          if (success) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/login',
                              (route) => false,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvatarSection(UserViewModel vm) {
    return GestureDetector(
      onTap: _pickAvatar,
      child: Stack(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: accent,
                width: 2,
              ),
              color: surfaceAlt,
              image: DecorationImage(
                image: _pickedImage != null
                    ? FileImage(_pickedImage!)
                    : (vm.avatarUrl.isNotEmpty
                        ? NetworkImage(vm.avatarUrl)
                        : const AssetImage(
                            "assets/images/admin.png",
                          )) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
            child: (_pickedImage == null && vm.avatarUrl.isEmpty)
                ? const Icon(Icons.person, size: 50, color: accent)
                : null,
          ),
          if (vm.isUploadingAvatar)
            const Positioned.fill(
                child: CircularProgressIndicator(color: accent, strokeWidth: 2)),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration:
              const BoxDecoration(color: accent, shape: BoxShape.circle),
              child: const Icon(Icons.camera_alt, size: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required List<Widget> children,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return Material(
      color: surfaceAlt,
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: accent.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: textLight,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  if (trailing != null) trailing,
                ],
              ),
              const SizedBox(height: 10),
              ...children,
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: accent, size: 20),
      title: Text(label, style: const TextStyle(color: muted, fontSize: 12)),
      subtitle: Text(value.isEmpty ? "Not set" : value,
          style: const TextStyle(
              color: textLight, fontSize: 15, fontWeight: FontWeight.w500)),
    );
  }

  Widget _field(TextEditingController c, String label, IconData icon) {
    return TextField(
      controller: c,
      style: const TextStyle(color: textLight),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: muted),
        prefixIcon: Icon(icon, color: accent),
        filled: true,
        fillColor: bg,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: surface)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: accent)),
      ),
    );
  }
}
