import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/registration_state.dart';
import 'address_screen.dart';

class BasicProfileScreen extends StatefulWidget {
  final String phoneNumber;

  const BasicProfileScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<BasicProfileScreen> createState() =>
      _BasicProfileScreenState();
}

class _BasicProfileScreenState extends State<BasicProfileScreen> {
  final TextEditingController _nameController =
      TextEditingController();
  final TextEditingController _dobController =
      TextEditingController();

  String? _selectedGender;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    final data = context.read<RegistrationState>().data;

    _nameController.text = data.fullName;
    _dobController.text = data.dateOfBirth;

    if (data.gender.isNotEmpty) {
      _selectedGender = data.gender;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDateOfBirth() async {
    final now = DateTime.now();

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(
        now.year - 25,
        now.month,
        now.day,
      ),
      firstDate: DateTime(1950),
      lastDate: DateTime(
        now.year - 18,
        now.month,
        now.day,
      ),
    );

    if (selectedDate == null || !mounted) {
      return;
    }

    final day = selectedDate.day.toString().padLeft(2, '0');
    final month =
        selectedDate.month.toString().padLeft(2, '0');
    final year = selectedDate.year.toString();

    setState(() {
      _dobController.text = '$day/$month/$year';
    });
  }

  Future<void> _continue() async {
    final name = _nameController.text.trim();
    final dob = _dobController.text.trim();
    final gender = _selectedGender;

    if (name.isEmpty) {
      _showMessage('Enter your full name.');
      return;
    }

    if (dob.isEmpty) {
      _showMessage('Select your date of birth.');
      return;
    }

    if (gender == null) {
      _showMessage('Select your gender.');
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

    context.read<RegistrationState>().update(
          phoneNumber: widget.phoneNumber,
          fullName: name,
          dateOfBirth: dob,
          gender: gender,
        );

    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AddressScreen(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF171717),
        elevation: 0,
        title: const Text(
          'Basic Profile',
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
                'Tell us about yourself',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF171717),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'This information will be used to create your Dojo Walker registration profile.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF4B5563),
                ),
              ),
              const SizedBox(height: 32),
              _label('Full name'),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: _inputDecoration(
                  hintText: 'Enter your full name',
                ),
              ),
              const SizedBox(height: 22),
              _label('Date of birth'),
              const SizedBox(height: 8),
              TextField(
                controller: _dobController,
                readOnly: true,
                onTap: _selectDateOfBirth,
                decoration: _inputDecoration(
                  hintText: 'Select date of birth',
                ).copyWith(
                  suffixIcon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              _label('Gender'),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _selectedGender,
                decoration: _inputDecoration(
                  hintText: 'Select gender',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Male',
                    child: Text('Male'),
                  ),
                  DropdownMenuItem(
                    value: 'Female',
                    child: Text('Female'),
                  ),
                  DropdownMenuItem(
                    value: 'Other',
                    child: Text('Other'),
                  ),
                  DropdownMenuItem(
                    value: 'Prefer not to say',
                    child: Text('Prefer not to say'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
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
              const SizedBox(height: 18),
              Center(
                child: Text(
                  'Mobile: +91 ${widget.phoneNumber}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
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
