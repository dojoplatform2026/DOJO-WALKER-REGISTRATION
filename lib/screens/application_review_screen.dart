import 'package:flutter/material.dart';

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
    setState(() {
      _isSubmitting = true;
    });

    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isSubmitting = false;
    });

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const ApplicationSubmittedScreen(),
      ),
      (route) => false,
    );
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
              value,
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

  Widget _verifiedItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            size: 20,
            color: Color(0xFF15803D),
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

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment:
                CrossAxisAlignment.start,
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
                    value: 'Your name',
                  ),
                  _row(
                    label: 'Date of birth',
                    value: 'Your date of birth',
                  ),
                  _row(
                    label: 'Gender',
                    value: 'Selected gender',
                  ),
                  _row(
                    label: 'Mobile',
                    value: '+91 XXXXXXXXXX',
                  ),
                ],
              ),

              _section(
                title: 'Address',
                children: [
                  _row(
                    label: 'Address',
                    value: 'Your registered address',
                  ),
                  _row(
                    label: 'Area',
                    value: 'Your locality',
                  ),
                  _row(
                    label: 'City',
                    value: 'Your city',
                  ),
                  _row(
                    label: 'State',
                    value: 'Your state',
                  ),
                  _row(
                    label: 'PIN code',
                    value: 'XXXXXX',
                  ),
                ],
              ),

              _section(
                title: 'Experience',
                children: [
                  _row(
                    label: 'Experience',
                    value:
                        'Selected experience level',
                  ),
                  _row(
                    label: 'Dog handling',
                    value: 'Yes / No',
                  ),
                  _row(
                    label: 'Pet care',
                    value: 'Yes / No',
                  ),
                ],
              ),

              _section(
                title: 'Availability',
                children: [
                  _row(
                    label: 'Work type',
                    value:
                        'Part-time / Full-time',
                  ),
                  _row(
                    label: 'Shift',
                    value:
                        'Morning / Evening / Both',
                  ),
                  _row(
                    label: 'Days',
                    value:
                        'Selected available days',
                  ),
                  _row(
                    label: 'Walk types',
                    value:
                        'Monthly Walk — Permanent, Temporary Walk, Insta Walk',
                  ),
                ],
              ),

              _section(
                title: 'Documents',
                children: [
                  _verifiedItem(
                    'Aadhaar Front added',
                  ),
                  _verifiedItem(
                    'Aadhaar Back added',
                  ),
                  _verifiedItem(
                    'PAN document added',
                  ),
                  _verifiedItem(
                    'Profile photo added',
                  ),
                ],
              ),

              _section(
                title: 'Emergency Contact',
                children: [
                  _row(
                    label: 'Name',
                    value:
                        'Emergency contact name',
                  ),
                  _row(
                    label: 'Mobile',
                    value:
                        '+91 XXXXXXXXXX',
                  ),
                  _row(
                    label: 'Relationship',
                    value:
                        'Relationship',
                  ),
                ],
              ),

              const SizedBox(height: 4),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1E8),
                  borderRadius:
                      BorderRadius.circular(16),
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
                  onPressed: _isSubmitting
                      ? null
                      : _submitApplication,
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFE86100),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        const Color(0xFFFFC7A3),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Submit Application',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w700,
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
