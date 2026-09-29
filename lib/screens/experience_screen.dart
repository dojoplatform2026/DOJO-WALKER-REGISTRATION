import 'package:flutter/material.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  final TextEditingController _experienceController =
      TextEditingController();

  String? _selectedExperience;
  bool _hasDogExperience = false;
  bool _hasPetCareExperience = false;
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
    _experienceController.dispose();
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

    final details = _experienceController.text.trim();

    if (details.isEmpty) {
      _showMessage('Tell us a little about your experience.');
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

  InputDecoration _inputDecoration({
    required String hintText,
  }) {
    return InputDecoration(
      hintText: hintText,
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
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Color(0xFF171717),
      ),
    );
  }

  Widget _experienceSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        children: [
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
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: const Color(0xFFE86100),
            onChanged: onChanged,
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
                'Your experience helps us understand your background and suitability for walker work.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF4B5563),
                ),
              ),

              const SizedBox(height: 32),

              _label('Experience level'),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                initialValue: _selectedExperience,
                decoration: _inputDecoration(
                  hintText: 'Select experience level',
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

              const SizedBox(height: 24),

              _label('Experience details'),

              const SizedBox(height: 8),

              TextField(
                controller: _experienceController,
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
                decoration: _inputDecoration(
                  hintText:
                      'Tell us about your previous work, pet care, dog walking, or related experience.',
                ),
              ),

              const SizedBox(height: 24),

              _experienceSwitch(
                title: 'Dog handling experience',
                subtitle:
                    'Have you handled or cared for dogs before?',
                value: _hasDogExperience,
                onChanged: (value) {
                  setState(() {
                    _hasDogExperience = value;
                  });
                },
              ),

              const SizedBox(height: 12),

              _experienceSwitch(
                title: 'Pet care experience',
                subtitle:
                    'Do you have experience caring for pets?',
                value: _hasPetCareExperience,
                onChanged: (value) {
                  setState(() {
                    _hasPetCareExperience = value;
                  });
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
                    disabledBackgroundColor: const Color(0xFFFFC7A3),
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
