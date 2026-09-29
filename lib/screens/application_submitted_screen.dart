import 'package:flutter/material.dart';

class ApplicationSubmittedScreen extends StatelessWidget {
  const ApplicationSubmittedScreen({super.key});

  Widget _statusStep({
    required String title,
    required String description,
    required bool completed,
    required bool current,
  }) {
    final Color iconColor = completed || current
        ? const Color(0xFFE86100)
        : const Color(0xFF9CA3AF);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: completed || current
                    ? const Color(0xFFFFF1E8)
                    : const Color(0xFFF3F4F6),
              ),
              child: Icon(
                completed
                    ? Icons.check
                    : current
                        ? Icons.access_time
                        : Icons.circle_outlined,
                size: 20,
                color: iconColor,
              ),
            ),
            if (title != 'Admin Review')
              Container(
                width: 2,
                height: 42,
                color: completed
                    ? const Color(0xFFE86100)
                    : const Color(0xFFE5E7EB),
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: completed || current
                        ? const Color(0xFF171717)
                        : const Color(0xFF6B7280),
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
                if (current) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1E8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'In Progress',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE86100),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
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
        automaticallyImplyLeading: false,
        title: const Text(
          'Application Status',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Container(
                width: 78,
                height: 78,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFF1E8),
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  size: 48,
                  color: Color(0xFFE86100),
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                'Application Submitted',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF171717),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Your Dojo Walker registration has been submitted successfully.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF4B5563),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                  ),
                ),
                child: const Column(
                  children: [
                    Text(
                      'Application Status',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'PENDING VERIFICATION',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFE86100),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Verification Progress',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF171717),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              _statusStep(
                title: 'Application Submitted',
                description:
                    'Your registration information has been received.',
                completed: true,
                current: false,
              ),

              _statusStep(
                title: 'Document Verification',
                description:
                    'Our team will verify your submitted documents.',
                completed: false,
                current: true,
              ),

              _statusStep(
                title: 'Interview',
                description:
                    'An interview may be scheduled if required.',
                completed: false,
                current: false,
              ),

              _statusStep(
                title: 'Practical Test',
                description:
                    'Walker skills and pet-handling ability may be assessed.',
                completed: false,
                current: false,
              ),

              _statusStep(
                title: 'Background Verification',
                description:
                    'Required verification checks will be completed.',
                completed: false,
                current: false,
              ),

              _statusStep(
                title: 'Admin Review',
                description:
                    'Final application review and approval.',
                completed: false,
                current: false,
              ),

              const SizedBox(height: 8),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1E8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Color(0xFFE86100),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'You will be notified when your verification status changes. You cannot accept walks until your application is approved.',
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
                height: 52,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFE86100),
                    side: const BorderSide(
                      color: Color(0xFFE86100),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'View Application',
                    style: TextStyle(
                      fontSize: 15,
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
