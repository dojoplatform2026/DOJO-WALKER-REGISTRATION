import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/registration_state.dart';
import 'emergency_contact_screen.dart';

class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({super.key});

  @override
  State<AvailabilityScreen> createState() =>
      _AvailabilityScreenState();
}

class _AvailabilityScreenState
    extends State<AvailabilityScreen> {
  final List<String> _morningSlots = const [
    '05:00 - 09:00',
    '06:00 - 10:00',
    '07:00 - 11:00',
  ];

  final List<String> _eveningSlots = const [
    '16:00 - 20:00',
    '17:00 - 21:00',
    '18:00 - 22:00',
  ];

  String _workType = '';
  String _selectedShift = '';

  final List<String> _selectedMorningSlots = [];
  final List<String> _selectedEveningSlots = [];

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    final data = context.read<RegistrationState>().data;

    _workType = data.workType;

    _selectedMorningSlots.addAll(data.morningSlots);
    _selectedEveningSlots.addAll(data.eveningSlots);

    if (_workType == 'partTime') {
      if (_selectedMorningSlots.isNotEmpty) {
        _selectedShift = 'morning';
      } else if (_selectedEveningSlots.isNotEmpty) {
        _selectedShift = 'evening';
      }
    } else if (_workType == 'fullTime') {
      _selectedShift = 'both';
    }
  }

  bool get _isPartTime => _workType == 'partTime';

  bool get _isFullTime => _workType == 'fullTime';

  void _selectWorkType(String type) {
    setState(() {
      _workType = type;

      _selectedMorningSlots.clear();
      _selectedEveningSlots.clear();

      if (type == 'partTime') {
        _selectedShift = '';
      } else {
        _selectedShift = 'both';
      }
    });
  }

  void _selectPartTimeShift(String shift) {
    setState(() {
      _selectedShift = shift;

      if (shift == 'morning') {
        _selectedEveningSlots.clear();
      } else {
        _selectedMorningSlots.clear();
      }
    });
  }

  void _toggleMorningSlot(String slot) {
    setState(() {
      if (_selectedMorningSlots.contains(slot)) {
        _selectedMorningSlots.remove(slot);
      } else {
        _selectedMorningSlots.add(slot);
      }
    });
  }

  void _toggleEveningSlot(String slot) {
    setState(() {
      if (_selectedEveningSlots.contains(slot)) {
        _selectedEveningSlots.remove(slot);
      } else {
        _selectedEveningSlots.add(slot);
      }
    });
  }

  bool _validate() {
    if (_workType.isEmpty) {
      _showMessage(
        'Please select Part-time or Full-time.',
      );
      return false;
    }

    if (_isPartTime) {
      if (_selectedShift.isEmpty) {
        _showMessage(
          'Please select Morning or Evening.',
        );
        return false;
      }

      if (_selectedShift == 'morning' &&
          _selectedMorningSlots.isEmpty) {
        _showMessage(
          'Please select at least one morning slot.',
        );
        return false;
      }

      if (_selectedShift == 'evening' &&
          _selectedEveningSlots.isEmpty) {
        _showMessage(
          'Please select at least one evening slot.',
        );
        return false;
      }
    }

    if (_isFullTime) {
      if (_selectedMorningSlots.isEmpty) {
        _showMessage(
          'Please select at least one morning slot.',
        );
        return false;
      }

      if (_selectedEveningSlots.isEmpty) {
        _showMessage(
          'Please select at least one evening slot.',
        );
        return false;
      }
    }

    return true;
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _continue() async {
    if (!_validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) {
      return;
    }

    final shifts = <String>[];

    if (_selectedMorningSlots.isNotEmpty) {
      shifts.add('morning');
    }

    if (_selectedEveningSlots.isNotEmpty) {
      shifts.add('evening');
    }

    String morningStart = '';
    String morningEnd = '';

    String eveningStart = '';
    String eveningEnd = '';

    if (_selectedMorningSlots.isNotEmpty) {
      final firstSlot = _selectedMorningSlots.first;
      final parts = firstSlot.split(' - ');

      if (parts.length == 2) {
        morningStart = parts[0];
        morningEnd = parts[1];
      }
    }

    if (_selectedEveningSlots.isNotEmpty) {
      final firstSlot = _selectedEveningSlots.first;
      final parts = firstSlot.split(' - ');

      if (parts.length == 2) {
        eveningStart = parts[0];
        eveningEnd = parts[1];
      }
    }

    context.read<RegistrationState>().update(
          workType: _workType,
          shifts: shifts,
          availableDays: const [],
          morningSlots:
              List<String>.from(_selectedMorningSlots),
          eveningSlots:
              List<String>.from(_selectedEveningSlots),
          morningStartTime: morningStart,
          morningEndTime: morningEnd,
          eveningStartTime: eveningStart,
          eveningEndTime: eveningEnd,
        );

    setState(() {
      _isSaving = false;
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const EmergencyContactScreen(),
      ),
    );
  }

  Widget _workTypeCard({
    required String value,
    required String title,
    required String subtitle,
  }) {
    final selected = _workType == value;

    return InkWell(
      onTap: () {
        _selectWorkType(value);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFFF1E8)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? const Color(0xFFE86100)
                : const Color(0xFFE5E7EB),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: selected
                  ? const Color(0xFFE86100)
                  : const Color(0xFF9CA3AF),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF171717),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shiftCard({
    required String value,
    required String title,
    required String subtitle,
  }) {
    final selected = _selectedShift == value;

    return InkWell(
      onTap: () {
        _selectPartTimeShift(value);
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFFF1E8)
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? const Color(0xFFE86100)
                : const Color(0xFFE5E7EB),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              color: selected
                  ? const Color(0xFFE86100)
                  : const Color(0xFF9CA3AF),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _slotCard({
    required String slot,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFFF1E8)
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? const Color(0xFFE86100)
                : const Color(0xFFE5E7EB),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: selected
                  ? const Color(0xFFE86100)
                  : const Color(0xFF9CA3AF),
            ),
            const SizedBox(width: 12),
            Text(
              slot,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF171717),
              ),
            ),
            const Spacer(),
            const Text(
              '4 hours',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Color(0xFF171717),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            height: 1.4,
            color: Color(0xFF6B7280),
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
        title: const Text(
          'Availability',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Availability',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF171717),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose the work schedule you can commit to. '
                'Every selected slot is fixed for 4 hours.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Color(0xFF6B7280),
                ),
              ),

              const SizedBox(height: 28),

              _sectionTitle(
                'Work Type',
                'Choose whether you want to work part-time or full-time.',
              ),

              const SizedBox(height: 12),

              _workTypeCard(
                value: 'partTime',
                title: 'Part-time',
                subtitle:
                    'Choose Morning or Evening.',
              ),

              const SizedBox(height: 10),

              _workTypeCard(
                value: 'fullTime',
                title: 'Full-time',
                subtitle:
                    'Morning and Evening are both required.',
              ),

              if (_isPartTime) ...[
                const SizedBox(height: 28),

                _sectionTitle(
                  'Choose Shift',
                  'Select one shift for part-time work.',
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _shiftCard(
                        value: 'morning',
                        title: 'Morning',
                        subtitle: '5 AM – 11 AM',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _shiftCard(
                        value: 'evening',
                        title: 'Evening',
                        subtitle: '4 PM – 10 PM',
                      ),
                    ),
                  ],
                ),
              ],

              if (_isPartTime &&
                  _selectedShift == 'morning') ...[
                const SizedBox(height: 28),

                _sectionTitle(
                  'Morning Slots',
                  'Choose the 4-hour slots you can work.',
                ),

                const SizedBox(height: 12),

                ..._morningSlots.map(
                  (slot) => _slotCard(
                    slot: slot,
                    selected:
                        _selectedMorningSlots.contains(
                      slot,
                    ),
                    onTap: () {
                      _toggleMorningSlot(slot);
                    },
                  ),
                ),
              ],

              if (_isPartTime &&
                  _selectedShift == 'evening') ...[
                const SizedBox(height: 28),

                _sectionTitle(
                  'Evening Slots',
                  'Choose the 4-hour slots you can work.',
                ),

                const SizedBox(height: 12),

                ..._eveningSlots.map(
                  (slot) => _slotCard(
                    slot: slot,
                    selected:
                        _selectedEveningSlots.contains(
                      slot,
                    ),
                    onTap: () {
                      _toggleEveningSlot(slot);
                    },
                  ),
                ),
              ],

              if (_isFullTime) ...[
                const SizedBox(height: 28),

                _sectionTitle(
                  'Morning Slots',
                  'Select the morning slots you can work.',
                ),

                const SizedBox(height: 12),

                ..._morningSlots.map(
                  (slot) => _slotCard(
                    slot: slot,
                    selected:
                        _selectedMorningSlots.contains(
                      slot,
                    ),
                    onTap: () {
                      _toggleMorningSlot(slot);
                    },
                  ),
                ),

                const SizedBox(height: 18),

                _sectionTitle(
                  'Evening Slots',
                  'Select the evening slots you can work.',
                ),

                const SizedBox(height: 12),

                ..._eveningSlots.map(
                  (slot) => _slotCard(
                    slot: slot,
                    selected:
                        _selectedEveningSlots.contains(
                      slot,
                    ),
                    onTap: () {
                      _toggleEveningSlot(slot);
                    },
                  ),
                ),
              ],

              const SizedBox(height: 22),

              const Text(
                'The system will match available work to your selected time slots. '
                'You do not need to choose a walk type in advance.',
                style: TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: Color(0xFF6B7280),
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed:
                      _isSaving ? null : _continue,
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFE86100),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        const Color(0xFFFFC7A3),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor:
                                AlwaysStoppedAnimation<
                                    Color>(
                              Colors.white,
                            ),
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

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
