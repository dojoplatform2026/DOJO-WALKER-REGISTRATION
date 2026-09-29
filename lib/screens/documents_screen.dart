import 'package:flutter/material.dart';

import 'availability_screen.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  bool _aadhaarFrontAdded = false;
  bool _aadhaarBackAdded = false;
  bool _panAdded = false;
  bool _profilePhotoAdded = false;

  bool _isLoading = false;
  String? _loadingDocument;

  Future<void> _addDocument(String document) async {
    setState(() {
      _loadingDocument = document;
    });

    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      switch (document) {
        case 'Aadhaar Front':
          _aadhaarFrontAdded = true;
          break;
        case 'Aadhaar Back':
          _aadhaarBackAdded = true;
          break;
        case 'PAN':
          _panAdded = true;
          break;
        case 'Profile Photo':
          _profilePhotoAdded = true;
          break;
      }

      _loadingDocument = null;
    });
  }

  Future<void> _continue() async {
    if (!_aadhaarFrontAdded) {
      _showMessage('Add the front side of your Aadhaar.');
      return;
    }

    if (!_aadhaarBackAdded) {
      _showMessage('Add the back side of your Aadhaar.');
      return;
    }

    if (!_panAdded) {
      _showMessage('Add your PAN document.');
      return;
    }

    if (!_profilePhotoAdded) {
      _showMessage('Add your profile photo.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AvailabilityScreen(),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Widget _documentCard({
    required String title,
    required String description,
    required String documentKey,
    required bool added,
    required IconData icon,
  }) {
    final isLoading = _loadingDocument == documentKey;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: added
              ? const Color(0xFF86EFAC)
              : const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: added
                  ? const Color(0xFFF0FDF4)
                  : const Color(0xFFFFF1E8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              added ? Icons.check : icon,
              color: added
                  ? const Color(0xFF15803D)
                  : const Color(0xFFE86100),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF171717),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  added ? 'Document added' : description,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: added
                        ? const Color(0xFF15803D)
                        : const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (isLoading)
            const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Color(0xFFE86100),
              ),
            )
          else
            TextButton(
              onPressed: added
                  ? null
                  : () {
                      _addDocument(documentKey);
                    },
              child: Text(
                added ? 'Added' : 'Add',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: added
                      ? const Color(0xFF15803D)
                      : const Color(0xFFE86100),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF171717),
        elevation: 0,
        title: const Text(
          'Documents',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upload your documents',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF171717),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'These documents will be required for Dojo Walker verification.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF4B5563),
                ),
              ),
              const SizedBox(height: 30),

              const Text(
                'Aadhaar Card',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF171717),
                ),
              ),
              const SizedBox(height: 12),

              _documentCard(
                title: 'Aadhaar Front',
                description:
                    'Upload the front side of your Aadhaar card.',
                documentKey: 'Aadhaar Front',
                added: _aadhaarFrontAdded,
                icon: Icons.badge_outlined,
              ),

              _documentCard(
                title: 'Aadhaar Back',
                description:
                    'Upload the back side of your Aadhaar card.',
                documentKey: 'Aadhaar Back',
                added: _aadhaarBackAdded,
                icon: Icons.badge_outlined,
              ),

              const SizedBox(height: 8),

              _documentCard(
                title: 'PAN Card',
                description:
                    'Upload a clear copy of your PAN card.',
                documentKey: 'PAN',
                added: _panAdded,
                icon: Icons.credit_card_outlined,
              ),

              _documentCard(
                title: 'Profile Photo',
                description:
                    'Upload a clear recent profile photo.',
                documentKey: 'Profile Photo',
                added: _profilePhotoAdded,
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1E8),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 20,
                      color: Color(0xFFE86100),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Your Aadhaar, PAN and other sensitive documents must be stored securely. Secure backend storage will be connected when verification is implemented.',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.5,
                          color: Color(0xFF4B5563),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: _isLoading ? null : _continue,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFE86100),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        const Color(0xFFFFC7A3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
