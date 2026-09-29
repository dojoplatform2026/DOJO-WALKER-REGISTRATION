import 'package:flutter/material.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  bool _aadhaarUploaded = false;
  bool _panUploaded = false;
  bool _photoUploaded = false;
  bool _isLoading = false;

  Future<void> _uploadDocument(String documentName) async {
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

      if (documentName == 'Aadhaar') {
        _aadhaarUploaded = true;
      } else if (documentName == 'PAN') {
        _panUploaded = true;
      } else if (documentName == 'Photo') {
        _photoUploaded = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$documentName added for verification.'),
      ),
    );
  }

  Future<void> _continue() async {
    if (!_aadhaarUploaded) {
      _showMessage('Add your Aadhaar document.');
      return;
    }

    if (!_panUploaded) {
      _showMessage('Add your PAN document.');
      return;
    }

    if (!_photoUploaded) {
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

    _showMessage(
      'Next registration step will be connected here.',
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
    required bool uploaded,
    required VoidCallback onUpload,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: uploaded
              ? const Color(0xFFE86100)
              : const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1E8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFE86100),
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
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF171717),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  uploaded ? 'Added' : 'Required',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: uploaded
                        ? const Color(0xFF15803D)
                        : const Color(0xFFDC2626),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: _isLoading ? null : onUpload,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFE86100),
              side: const BorderSide(
                color: Color(0xFFE86100),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              uploaded ? 'Added' : 'Add',
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
                'Identity verification',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF171717),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Add the documents required for your Dojo Walker verification.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF4B5563),
                ),
              ),

              const SizedBox(height: 18),

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
                        'Your documents will be used only for verification. Secure document storage will be connected when the backend is configured.',
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

              const SizedBox(height: 24),

              _documentCard(
                title: 'Aadhaar Card',
                description:
                    'Upload a clear identity document for verification.',
                uploaded: _aadhaarUploaded,
                icon: Icons.badge_outlined,
                onUpload: () {
                  _uploadDocument('Aadhaar');
                },
              ),

              const SizedBox(height: 14),

              _documentCard(
                title: 'PAN Card',
                description:
                    'Upload your PAN document for identity verification.',
                uploaded: _panUploaded,
                icon: Icons.credit_card_outlined,
                onUpload: () {
                  _uploadDocument('PAN');
                },
              ),

              const SizedBox(height: 14),

              _documentCard(
                title: 'Profile Photo',
                description:
                    'Add a recent clear photo for your walker profile.',
                uploaded: _photoUploaded,
                icon: Icons.person_outline,
                onUpload: () {
                  _uploadDocument('Photo');
                },
              ),

              const SizedBox(height: 32),

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
