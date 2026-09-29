import 'package:flutter/material.dart';

class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({super.key});

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  String? _workType;

  bool _morningSelected = false;
  bool _eveningSelected = false;

  final Set<String> _selectedDays = {};

  bool _monthlyWalk = true;
  bool _temporaryWalk = true;
  bool _instaWalk = false;

  TimeOfDay _morningStart = const TimeOfDay(
    hour: 6,
    minute: 0,
  );

  TimeOfDay _morningEnd = const TimeOfDay(
    hour: 10,
    minute: 0,
  );

  TimeOfDay _eveningStart = const TimeOfDay(
    hour: 17,
    minute: 0,
  );

  TimeOfDay _eveningEnd = const TimeOfDay(
    hour: 21,
    minute: 0,
  );

  bool _isLoading = false;

  final List<String> _days = const [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  void _selectWorkType(String type) {
    setState(() {
      _workType = type;

      if (type == 'Part-time') {
        _morningSelected = false;
        _eveningSelected = false;
      } else {
        _morningSelected = true;
        _eveningSelected = true;
      }
    });
  }

  void _selectPartTimeShift(String shift) {
    setState(() {
      if (shift == 'Morning') {
        _morningSelected = true;
        _eveningSelected = false;
      } else {
        _morningSelected = false;
        _eveningSelected = true;
      }
    });
  }

  Future<void> _selectTime({
    required bool morning,
    required bool start,
  }) async {
    final currentTime = morning
        ? (start ? _morningStart : _morningEnd)
        : (start ? _eveningStart : _eveningEnd);

    final selected = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    if (selected == null || !mounted) {
      return;
    }

    setState(() {
      if (morning) {
        if (start) {
          _morningStart = selected;
        } else {
          _morningEnd = selected;
        }
      } else {
        if (start) {
          _eveningStart = selected;
        } else {
          _eveningEnd = selected;
        }
      }
    });
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  bool _isTimeBefore(
    TimeOfDay first,
    TimeOfDay second,
  ) {
    final firstMinutes = first.hour * 60 + first.minute;
    final secondMinutes = second.hour * 60 + second.minute;

    return firstMinutes < secondMinutes;
  }

  Future<void> _continue() async {
    if (_workType == null) {
      _showMessage('Select Part-time or Full-time.');
      return;
    }

    if (!_morningSelected && !_eveningSelected) {
      _showMessage('Select at least one shift.');
      return;
    }

    if (_selectedDays.isEmpty) {
      _showMessage('Select at least one available day.');
      return;
    }

    if (_morningSelected &&
        !_isTimeBefore(_morningStart, _morningEnd)) {
      _showMessage('Check your morning availability time.');
      return;
    }

    if (_eveningSelected &&
        !_isTimeBefore(_eveningStart, _eveningEnd)) {
      _showMessage('Check your evening availability time.');
      return;
    }

    if (!_monthlyWalk && !_temporaryWalk && !_instaWalk) {
      _showMessage('Select at least one walk type.');
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

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w800,
        color: Color(0xFF171717),
      ),
    );
  }

  Widget _workTypeCard({
    required String title,
    required String subtitle,
  }) {
    final selected = _workType == title;

    return Expanded(
      child: InkWell(
        onTap: () {
          _selectWorkType(title);
        },
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFFFF1E8)
                : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? const Color(0xFFE86100)
                  : const Color(0xFFE5E7EB),
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                title == 'Part-time'
                    ? Icons.schedule_outlined
                    : Icons.work_history_outlined,
                color: const Color(0xFFE86100),
              ),
              const SizedBox(height: 10),
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
      ),
    );
  }

  Widget _shiftCard({
    required String title,
    required String subtitle,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
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
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                title == 'Morning'
                    ? Icons.wb_sunny_outlined
                    : Icons.nights_stay_outlined,
                color: const Color(0xFFE86100),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF171717),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                selected
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: selected
                    ? const Color(0xFFE86100)
                    : const Color(0xFF9CA3AF),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _timeSelector({
    required String title,
    required TimeOfDay start,
    required TimeOfDay end,
    required bool morning,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
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
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFF171717),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _selectTime(
                      morning: morning,
                      start: true,
                    );
                  },
                  child: Text(_formatTime(start)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'to',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _selectTime(
                      morning: morning,
                      start: false,
                    );
                  },
                  child: Text(_formatTime(end)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _walkTypeTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: (newValue) {
          onChanged(newValue ?? false);
        },
        activeColor: const Color(0xFFE86100),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Color(0xFF171717),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11,
            height: 1.4,
            color: Color(0xFF6B7280),
          ),
        ),
        controlAffinity: ListTileControlAffinity.leading,
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
          'Availability',
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
                'Set your work availability',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF171717),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Tell us when you are available so we can match you with suitable walks.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF4B5563),
                ),
              ),

              const SizedBox(height: 30),

              _sectionTitle('1. Work type'),

              const SizedBox(height: 12),

              Row(
                children: [
                  _workTypeCard(
                    title: 'Part-time',
                    subtitle:
                        'Choose one shift: morning or evening.',
                  ),
                  const SizedBox(width: 12),
                  _workTypeCard(
                    title: 'Full-time',
                    subtitle:
                        'Available for both morning and evening.',
                  ),
                ],
              ),

              const SizedBox(height: 30),

              _sectionTitle('2. Shift'),

              const SizedBox(height: 12),

              Row(
                children: [
                  _shiftCard(
                    title: 'Morning',
                    subtitle: '06:00 AM – 10:00 AM',
                    selected: _morningSelected,
                    onTap: () {
                      if (_workType == 'Part-time') {
                        _selectPartTimeShift('Morning');
                      }
                    },
                  ),
                  const SizedBox(width: 12),
                  _shiftCard(
                    title: 'Evening',
                    subtitle: '05:00 PM – 09:00 PM',
                    selected: _eveningSelected,
                    onTap: () {
                      if (_workType == 'Part-time') {
                        _selectPartTimeShift('Evening');
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),

              _sectionTitle('3. Available days'),

              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _days.map(
                  (day) {
                    final selected = _selectedDays.contains(day);

                    return FilterChip(
                      label: Text(day),
                      selected: selected,
                      selectedColor: const Color(0xFFFFF1E8),
                      checkmarkColor: const Color(0xFFE86100),
                      side: BorderSide(
                        color: selected
                            ? const Color(0xFFE86100)
                            : const Color(0xFFE5E7EB),
                      ),
                      onSelected: (value) {
                        setState(() {
                          if (value) {
                            _selectedDays.add(day);
                          } else {
                            _selectedDays.remove(day);
                          }
                        });
                      },
                    );
                  },
                ).toList(),
              ),

              const SizedBox(height: 30),

              _sectionTitle('4. Working hours'),

              const SizedBox(height: 12),

              if (_morningSelected)
                _timeSelector(
                  title: 'Morning availability',
                  start: _morningStart,
                  end: _morningEnd,
                  morning: true,
                ),

              if (_morningSelected && _eveningSelected)
                const SizedBox(height: 12),

              if (_eveningSelected)
                _timeSelector(
                  title: 'Evening availability',
                  start: _eveningStart,
                  end: _eveningEnd,
                  morning: false,
                ),

              const SizedBox(height: 30),

              _sectionTitle('5. Walk types'),

              const SizedBox(height: 12),

              _walkTypeTile(
                title: 'Monthly Walk — Permanent',
                subtitle:
                    'For recurring monthly owner bookings and long-term assignments.',
                value: _monthlyWalk,
                onChanged: (value) {
                  setState(() {
                    _monthlyWalk = value;
                  });
                },
              ),

              _walkTypeTile(
                title: 'Temporary Walk',
                subtitle:
                    'For short-term or limited-period walk assignments.',
                value: _temporaryWalk,
                onChanged: (value) {
                  setState(() {
                    _temporaryWalk = value;
                  });
                },
              ),

              _walkTypeTile(
                title: 'Insta Walk',
                subtitle:
                    'For on-demand or scheduled instant walk requests.',
                value: _instaWalk,
                onChanged: (value) {
                  setState(() {
                    _instaWalk = value;
                  });
                },
              ),

              const SizedBox(height: 22),

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
                      Icons.info_outline,
                      size: 20,
                      color: Color(0xFFE86100),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Your availability does not guarantee a walk assignment. Assignments will depend on zone, owner requirements, schedule, and verification status.',
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
