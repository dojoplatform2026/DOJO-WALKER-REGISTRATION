import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/registration_service.dart';
import '../state/registration_state.dart';
import 'application_submitted_screen.dart';

class ApplicationReviewScreen extends StatefulWidget {
  const ApplicationReviewScreen({super.key});

  @override
  State<ApplicationReviewScreen> createState() =>
      _ApplicationReviewScreenState();
}

class _ApplicationReviewScreenState
    extends State<ApplicationReviewScreen> {
  bool _isSubmitting = false;

  Future<void> _submitApplication() async {
    if (_isSubmitting) {
      return;
    }

    final data = context.read<RegistrationState>().data;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final applicationId =
          await RegistrationService.submitApplication(data);

      if (!mounted) {
        return;
      }

      setState(() {
        _isSubmitting = false;
      });

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => ApplicationSubmittedScreen(
            applicationId: applicationId,
          ),
        ),
        (route) => false,
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isSubmitting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Application submission failed. Please try again.',
          ),
          backgroundColor: const Color(0xFFB91C1C),
        ),
      );
    }
  }

  Widget _section({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF171717),
            ),
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  Widget _row({
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? 'Not provided' : value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF171717),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _verifiedItem({
    required String text,
    required bool completed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(
            completed
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            size: 20,
            color: completed
                ? const Color(0xFF15803D)
                : const Color(0xFF9CA3AF),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF171717),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _workTypeLabel(String value) {
    switch (value) {
      case 'partTime':
        return 'Part-time';
      case 'fullTime':
        return 'Full-time';
      default:
        return value;
    }
  }

  String _shiftLabel(List<String> shifts) {
    if (shifts.isEmpty) {
      return 'Not selected';
    }

    if (shifts.contains('morning') &&
        shifts.contains('evening')) {
      return 'Morning + Evening';
    }

    if (shifts.contains('morning')) {
      return 'Morning';
    }

    if (shifts.contains('evening')) {
      return 'Evening';
    }

    return shifts.join(', ');
  }

  String _formatSlot(String slot) {
    final parts = slot.split(' - ');

    if (parts.length != 2) {
      return slot;
    }

    String formatTime(String time) {
      final timeParts = time.split(':');

      if (timeParts.length != 2) {
        return time;
      }

      final hour = int.tryParse(timeParts[0]);

      if (hour == null) {
        return time;
      }

      final minute = timeParts[1];
      final isPm = hour >= 12;

      final displayHour =
          hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);

      final period = isPm ? 'PM' : 'AM';

      return '$displayHour:$minute $period';
    }

    return '${formatTime(parts[0])} – ${formatTime(parts[1])}';
  }

  String _slotsText(List<String> slots) {
    if (slots.isEmpty) {
      return 'None selected';
    }

    return slots.map(_formatSlot).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<RegistrationState>().data;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF171717),
        elevation: 0,
        title: const Text(
          'Review Application',
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
                'Review your application',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF171717),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Check your information carefully before submitting your Dojo Walker registration.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF4B5563),
                ),
              ),
              const SizedBox(height: 28),

              _section(
                title: 'Basic Profile',
                children: [
                  _row(
                    label: 'Name',
                    value: data.fullName,
                  ),
                  _row(
                    label: 'Date of birth',
                    value: data.dateOfBirth,
                  ),
                  _row(
                    label: 'Gender',
                    value: data.gender,
                  ),
                  _row(
                    label: 'Mobile',
                    value: data.phoneNumber.isEmpty
                        ? ''
                        : '+91 ${data.phoneNumber}',
                  ),
                ],
              ),

              _section(
                title: 'Address',
                children: [
                  _row(
                    label: 'Address',
                    value: data.address,
                  ),
                  _row(
                    label: 'Area',
                    value: data.area,
                  ),
                  _row(
                    label: 'City',
                    value: data.city,
                  ),
                  _row(
                    label: 'State',
                    value: data.state,
                  ),
                  _row(
                    label: 'PIN code',
                    value: data.pinCode,
                  ),
                ],
              ),

              _section(
                title: 'Experience',
                children: [
                  _row(
                    label: 'Experience',
                    value: data.experienceLevel,
                  ),
                  _row(
                    label: 'Details',
                    value: data.experienceDetails,
                  ),
                  _row(
                    label: 'Dog handling',
                    value: data.dogHandling ? 'Yes' : 'No',
                  ),
                  _row(
                    label: 'Pet care',
                    value: data.petCare ? 'Yes' : 'No',
                  ),
                ],
              ),

              _section(
                title: 'Availability',
                children: [
                  _row(
                    label: 'Work type',
                    value: _workTypeLabel(data.workType),
                  ),
                  _row(
                    label: 'Shift',
                    value: _shiftLabel(data.shifts),
                  ),
                  _row(
                    label: 'Morning slots',
                    value: _slotsText(data.morningSlots),
                  ),
                  _row(
                    label: 'Evening slots',
                    value: _slotsText(data.eveningSlots),
                  ),
                ],
              ),

              _section(
                title: 'Documents',
                children: [
                  _verifiedItem(
                    text: 'Aadhaar Front added',
                    completed: data.aadhaarFrontAdded,
                  ),
                  _verifiedItem(
                    text: 'Aadhaar Back added',
                    completed: data.aadhaarBackAdded,
                  ),
                  _verifiedItem(
                    text: 'PAN document added',
                    completed: data.panAdded,
                  ),
                  _verifiedItem(
                    text: 'Profile photo added',
                    completed: data.profilePhotoAdded,
                  ),
                ],
              ),

              _section(
                title: 'Emergency Contact',
                children: [
                  _row(
                    label: 'Name',
                    value: data.emergencyContactName,
                  ),
                  _row(
                    label: 'Mobile',
                    value: data.emergencyContactPhone.isEmpty
                        ? ''
                        : '+91 ${data.emergencyContactPhone}',
                  ),
                  _row(
                    label: 'Relationship',
                    value: data.emergencyContactRelationship,
                  ),
                ],
              ),

              const SizedBox(height: 4),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1E8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Color(0xFFE86100),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'After submission, your application will enter the Dojo verification process. Approval is required before you can start accepting walks.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: Color(0xFF4B5563),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed:
                      _isSubmitting ? null : _submitApplication,
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFE86100),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        const Color(0xFFFFC7A3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Submit Application',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 16),

              const Center(
                child: Text(
                  'You can submit only after checking all information.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
