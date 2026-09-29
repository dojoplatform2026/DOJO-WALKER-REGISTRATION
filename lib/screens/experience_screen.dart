import 'package:flutter/material.dart';

import 'documents_screen.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  String? _selectedExperience;

  final TextEditingController _detailsController =
      TextEditingController();

  bool _dogHandling = false;
  bool _petCare = false;
  bool _isLoading = false;

  final List<String> _experienceOptions = const [
    'No professional experience',
    'Less than 1 year',
    '1–2 years',
    '2–5 years',
    'More than 5 years',
  ];

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _continue() async {
    if (_selectedExperience == null) {
      _showMessage('Select your experience level.');
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
        builder: (_) => const DocumentsScreen(),
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
          'Experience',
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
                'Tell us about your experience',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF171717),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your experience helps us understand your pet-handling skills and background.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF4B5563),
                ),
              ),
              const SizedBox(height: 30),

              const Text(
                'Experience level',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF171717),
                ),
              ),
              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                initialValue: _selectedExperience,
                decoration: InputDecoration(
                  hintText: 'Select experience level',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE5E7EB),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE5E7EB),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE86100),
                      width: 2,
                    ),
                  ),
                ),
                items: _experienceOptions.map(
                  (experience) {
                    return DropdownMenuItem<String>(
                      value: experience,
                      child: Text(experience),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedExperience = value;
                  });
                },
              ),

              const SizedBox(height: 22),

              const Text(
                'Experience details',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF171717),
                ),
              ),
              const SizedBox(height: 8),

              TextField(
                controller: _detailsController,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText:
                      'Tell us about your experience with dogs or pets',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE5E7EB),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE5E7EB),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE86100),
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                  ),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      value: _dogHandling,
                      activeThumbColor: const Color(0xFFE86100),
                      title: const Text(
                        'Dog handling experience',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF171717),
                        ),
                      ),
                      subtitle: const Text(
                        'I have experience handling dogs.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _dogHandling = value;
                        });
                      },
                    ),
                    const Divider(
                      height: 1,
                      color: Color(0xFFE5E7EB),
                    ),
                    SwitchListTile(
                      value: _petCare,
                      activeThumbColor: const Color(0xFFE86100),
                      title: const Text(
                        'Pet care experience',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF171717),
                        ),
                      ),
                      subtitle: const Text(
                        'I have experience with general pet care.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _petCare = value;
                        });
                      },
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
