import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<String, bool> _completedTasks = {};
  Map<String, dynamic> _journalData = {};
  Map<String, bool> _selectedPrayers = {};
  String? _selectedMood;
  List<Map<String, dynamic>> _schedules = [];

  final List<String> _tasks = [
    'Wakeup',
    'Exercise', 
    'Diet',
    'Learn',
    'Work',
    'Finances',
    'Steps',
    'Prayers',
    'Sleep'
  ];

  @override
  void initState() {
    super.initState();
    // Initialize all tasks as not completed
    for (String task in _tasks) {
      _completedTasks[task] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Calendar Header
            GestureDetector(
              onTap: _showCalendarModal,
              child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text(
                      "${_selectedDay.day} ${_getMonthName(_selectedDay.month)} ${_selectedDay.year}",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          "WAKE UP | 05:00",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  // Tasks Section
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("TASKS", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("${_completedTasks.values.where((completed) => completed).length}/${_tasks.length}", 
                             style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: SXEColors.textSecondary)),
                      ],
                    ),
                  ),
                  
                  // Task List
                  ..._tasks.map((task) => _buildTaskItem(task)),
                  
                  // Journal Section
                   Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("JOURNAL", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Icon(LucideIcons.chevronDown, size: 24, color: SXEColors.textPrimary),
                      ],
                    ),
                  ),
                  
                  // Journal Items
                  _buildJournalItem("Prayers", LucideIcons.heart, () => _showPrayerModal()),
                  _buildJournalItem("Steps", LucideIcons.footprints, () => _showStepsModal()),
                  _buildJournalItem("Water", LucideIcons.droplets, () => _showWaterModal()),
                  _buildJournalItem("Worked", LucideIcons.briefcase, () => _showWorkedModal()),
                  _buildJournalItem("Phone", LucideIcons.smartphone, () => _showPhoneModal()),
                  _buildJournalItem("Sleep", LucideIcons.moon, () => _showSleepModal()),
                  _buildJournalItem("Finances", LucideIcons.dollarSign, () => _showFinancesModal()),
                  _buildJournalItem("Mood", LucideIcons.heart, () => _showMoodModal()),
                  _buildJournalItem("Note", LucideIcons.stickyNote, () => _showNoteModal()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(String task) {
    bool isCompleted = _completedTasks[task] ?? false;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _completedTasks[task] = !isCompleted;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(task, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? Colors.green : Colors.transparent,
                border: Border.all(
                  color: isCompleted ? Colors.green : Colors.grey,
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJournalItem(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: SXEColors.textPrimary),
            SizedBox(width: 12),
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Spacer(),
            _buildJournalValue(title),
            SizedBox(width: 8),
            Icon(LucideIcons.chevronRight, size: 20, color: SXEColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _buildJournalValue(String key) {
    if (key == "Note") {
      final noteValue = _journalData['note']?.toString() ?? '';
      if (noteValue.isNotEmpty) {
        return Expanded(
          child: TextField(
            readOnly: true,
            controller: TextEditingController(text: noteValue),
            style: TextStyle(fontSize: 14, color: SXEColors.textSecondary),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
            maxLines: 2,
            minLines: 1,
          ),
        );
      }
      return Text("Tap to add", style: TextStyle(fontSize: 14, color: SXEColors.textSecondary));
    }
    
    final value = _journalData[key.toLowerCase()];
    if (value == null || value.toString().isEmpty) {
      return Text("Tap to add", style: TextStyle(fontSize: 14, color: SXEColors.textSecondary));
    }
    
    String displayText = _formatJournalValue(key.toLowerCase(), value);
    return Text(displayText, style: TextStyle(fontSize: 14, color: SXEColors.textSecondary));
  }

  String _getMonthName(int month) {
    const months = [
      'JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE',
      'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'
    ];
    return months[month - 1];
  }

  void _showCalendarModal() {
    showDialog(
      context: context,
      builder: (context) => Dialog.fullscreen(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Calendar"),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(LucideIcons.x),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: TableCalendar<String>(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    Navigator.pop(context);
                  },
                  calendarFormat: CalendarFormat.month,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Schedule", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        TextButton.icon(
                          onPressed: () => _showAddScheduleModal(),
                          icon: Icon(LucideIcons.plus, size: 16),
                          label: Text("Add Schedule"),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    _buildScheduleList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPrayerModal() {
    final List<Map<String, dynamic>> prayers = [
      {'name': 'Fajr', 'arabic': 'الفجر', 'time': 'Before sunrise', 'rakat': '2 Sunnah + 2 Fard', 'significance': 'A fresh start to the day with remembrance of Allah.'},
      {'name': 'Dhuhr', 'arabic': 'الظهر', 'time': 'After midday until afternoon', 'rakat': '4 Sunnah + 4 Fard + 2 Sunnah + 2 Nafl', 'significance': 'A moment of pause and connection with Allah during the day.'},
      {'name': 'Asr', 'arabic': 'العصر', 'time': 'Late afternoon until sunset', 'rakat': '4 Sunnah + 4 Fard', 'significance': 'A reminder to stay mindful of Allah in the busy hours.'},
      {'name': 'Maghrib', 'arabic': 'المغرب', 'time': 'After sunset until dusk', 'rakat': '3 Fard + 2 Sunnah + 2 Nafl', 'significance': 'A time of gratitude as the day ends.'},
      {'name': 'Isha', 'arabic': 'العشاء', 'time': 'After dusk until midnight', 'rakat': '4 Sunnah + 4 Fard + 2 Sunnah + 2 Nafl + Witr', 'significance': 'The final prayer of the day, bringing peace and reflection.'},
      {'name': 'Witr', 'arabic': 'وتر', 'time': 'After Isha', 'rakat': '3 (or odd numbers)', 'significance': 'Highly recommended prayer after Isha.'},
      {'name': 'Tahajjud', 'arabic': 'تَهَجد', 'time': 'Late night voluntary prayer', 'rakat': '2 or more (even numbers)', 'significance': 'A voluntary prayer with great rewards.'},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Prayers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            this.setState(() {
                              _journalData['prayers'] = _selectedPrayers;
                            });
                            Navigator.pop(context);
                          },
                          child: Text("Save"),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(LucideIcons.x),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: prayers.length,
                  itemBuilder: (context, index) {
                    final prayer = prayers[index];
                    final isSelected = _selectedPrayers[prayer['name']] ?? false;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPrayers[prayer['name']] = !isSelected;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.black12)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? Colors.green : Colors.transparent,
                                border: Border.all(
                                  color: isSelected ? Colors.green : Colors.grey,
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? Icon(Icons.check, color: Colors.white, size: 16)
                                  : null,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(prayer['name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  Text(prayer['arabic'], style: TextStyle(fontSize: 14, color: SXEColors.textSecondary)),
                                  SizedBox(height: 4),
                                  Text(prayer['time'], style: TextStyle(fontSize: 12, color: SXEColors.textSecondary)),
                                  Text(prayer['rakat'], style: TextStyle(fontSize: 12, color: SXEColors.textSecondary)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showStepsModal() {
    TextEditingController controller = TextEditingController();
    
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Steps", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Number of steps",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _journalData['steps'] = controller.text;
                      });
                      Navigator.pop(context);
                    },
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ],
          ),
      ),
    );
  }

  void _showWaterModal() {
    int selectedLiters = 1;
    
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Water Intake", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Text("How many liters did you drink?", style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(8, (index) {
                  int liters = index + 1;
                  return GestureDetector(
                    onTap: () => setState(() => selectedLiters = liters),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: selectedLiters == liters ? Colors.blue : Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text("$liters", style: TextStyle(
                          color: selectedLiters == liters ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancel"),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        this.setState(() {
                          _journalData['water'] = selectedLiters;
                        });
                        Navigator.pop(context);
                      },
                      child: Text("Save"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWorkedModal() {
    TextEditingController controller = TextEditingController();
    
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Hours Worked", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Number of hours",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _journalData['worked'] = controller.text;
                      });
                      Navigator.pop(context);
                    },
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPhoneModal() {
    TextEditingController controller = TextEditingController();
    
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Phone Screen Time", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Hours of screen time",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _journalData['phone'] = controller.text;
                      });
                      Navigator.pop(context);
                    },
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSleepModal() {
    TextEditingController controller = TextEditingController();
    
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Sleep Hours", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Hours of sleep",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _journalData['sleep'] = controller.text;
                      });
                      Navigator.pop(context);
                    },
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFinancesModal() {
    TextEditingController controller = TextEditingController();
    String selectedType = 'earned';
    
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Finances", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text("Earned"),
                      value: 'earned',
                      groupValue: selectedType,
                      onChanged: (value) => setState(() => selectedType = value!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text("Spent"),
                      value: 'spent',
                      groupValue: selectedType,
                      onChanged: (value) => setState(() => selectedType = value!),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Amount",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancel"),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        this.setState(() {
                          _journalData['finances'] = {
                            'type': selectedType,
                            'amount': controller.text,
                          };
                        });
                        Navigator.pop(context);
                      },
                      child: Text("Save"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMoodModal() {
    List<Map<String, String>> allMoods = [
      ..._getPositiveMoods().map((mood) => {...mood, 'category': 'Positive'}),
      ..._getNegativeMoods().map((mood) => {...mood, 'category': 'Negative'}),
      ..._getComplexMoods().map((mood) => {...mood, 'category': 'Complex'}),
      ..._getNeutralMoods().map((mood) => {...mood, 'category': 'Neutral'}),
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select Mood", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            this.setState(() {
                              _journalData['mood'] = _selectedMood;
                            });
                            Navigator.pop(context);
                          },
                          child: Text("Save"),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(LucideIcons.x),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: allMoods.length,
                  itemBuilder: (context, index) {
                    final mood = allMoods[index];
                    final isSelected = _selectedMood == mood['name'];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedMood = mood['name'];
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.black12)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? Colors.blue : Colors.transparent,
                                border: Border.all(
                                  color: isSelected ? Colors.blue : Colors.grey,
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? Icon(Icons.check, color: Colors.white, size: 16)
                                  : null,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(mood['name']!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      SizedBox(width: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          mood['category']!,
                                          style: TextStyle(fontSize: 12, color: SXEColors.textSecondary),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(mood['description']!, style: TextStyle(fontSize: 14, color: SXEColors.textSecondary)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, String>> _getPositiveMoods() {
    return [
      {'name': 'Happy', 'description': 'Feeling joy, satisfaction, or pleasure.'},
      {'name': 'Excited', 'description': 'High energy, anticipation, or enthusiasm.'},
      {'name': 'Content', 'description': 'Peaceful, satisfied, and at ease.'},
      {'name': 'Grateful', 'description': 'Appreciation and thankfulness.'},
      {'name': 'Loving', 'description': 'Affectionate, compassionate, or caring.'},
      {'name': 'Optimistic', 'description': 'Hopeful and positive about the future.'},
      {'name': 'Proud', 'description': 'A sense of achievement or self-worth.'},
    ];
  }

  List<Map<String, String>> _getNegativeMoods() {
    return [
      {'name': 'Sad', 'description': 'Feeling down, low, or disappointed.'},
      {'name': 'Angry', 'description': 'Irritated, frustrated, or resentful.'},
      {'name': 'Anxious', 'description': 'Nervousness, worry, or fear.'},
      {'name': 'Lonely', 'description': 'Feeling isolated or disconnected.'},
      {'name': 'Guilty', 'description': 'Regretful or remorseful about something.'},
      {'name': 'Jealous', 'description': 'Envious of someone\'s success or possessions.'},
      {'name': 'Frustrated', 'description': 'Feeling stuck or annoyed due to obstacles.'},
    ];
  }

  List<Map<String, String>> _getComplexMoods() {
    return [
      {'name': 'Nostalgic', 'description': 'A mix of happiness and longing for the past.'},
      {'name': 'Bittersweet', 'description': 'A blend of joy and sadness.'},
      {'name': 'Conflicted', 'description': 'Torn between two or more emotions.'},
      {'name': 'Melancholic', 'description': 'A deep, reflective sadness.'},
      {'name': 'Euphoric', 'description': 'Extreme happiness or bliss.'},
      {'name': 'Mood Swings', 'description': 'Rapid shifts between different emotions.'},
    ];
  }

  List<Map<String, String>> _getNeutralMoods() {
    return [
      {'name': 'Calm', 'description': 'Relaxed and composed.'},
      {'name': 'Tired', 'description': 'Fatigued or lacking energy.'},
      {'name': 'Indifferent', 'description': 'Uninterested or emotionally detached.'},
      {'name': 'Bored', 'description': 'Lacking stimulation or excitement.'},
      {'name': 'Curious', 'description': 'Open to learning or discovering new things.'},
    ];
  }


  void _showNoteModal() {
    TextEditingController controller = TextEditingController();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Text("Note", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: controller,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: "Write your thoughts...",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _journalData['note'] = controller.text;
                      });
                      Navigator.pop(context);
                    },
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  String _formatJournalValue(String key, dynamic value) {
    switch (key) {
      case 'prayers':
        if (value is Map<String, bool>) {
          int selectedCount = value.entries.where((entry) => entry.value).length;
          return selectedCount == 0 ? '0 prayers' : '$selectedCount prayers';
        }
        return value.toString();
      case 'steps':
        return '$value steps';
      case 'water':
        return '$value liters';
      case 'worked':
        return '$value hours';
      case 'phone':
        return '$value hours';
      case 'sleep':
        return '$value hours';
      case 'finances':
        if (value is Map<String, dynamic>) {
          return '${value['type']}: \$${value['amount']}';
        }
        return value.toString();
      case 'mood':
        return value.toString();
      case 'note':
        return value.toString();
      default:
        return value.toString();
    }
  }

  Widget _buildScheduleList() {
    final daySchedules = _schedules.where((schedule) {
      final scheduleDate = schedule['date'] as DateTime;
      return scheduleDate.year == _selectedDay.year &&
             scheduleDate.month == _selectedDay.month &&
             scheduleDate.day == _selectedDay.day;
    }).toList();

    if (daySchedules.isEmpty) {
      return Text("No events scheduled for this day", 
           style: TextStyle(fontSize: 14, color: SXEColors.textSecondary));
    }

    return Column(
      children: daySchedules.map((schedule) => Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(LucideIcons.clock, size: 16, color: Colors.blue),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(schedule['title'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Text(schedule['time'], style: TextStyle(fontSize: 12, color: SXEColors.textSecondary)),
                ],
              ),
            ),
            IconButton(
              onPressed: () => _deleteSchedule(schedule),
              icon: Icon(LucideIcons.trash2, size: 16, color: Colors.red),
            ),
          ],
        ),
      )).toList(),
    );
  }

  void _showAddScheduleModal() {
    final titleController = TextEditingController();
    final timeController = TextEditingController();
    DateTime selectedTime = DateTime.now();

    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Add Schedule", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Event Title",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(selectedTime),
                  );
                  if (time != null) {
                    setState(() {
                      selectedTime = DateTime(
                        selectedTime.year,
                        selectedTime.month,
                        selectedTime.day,
                        time.hour,
                        time.minute,
                      );
                      timeController.text = time.format(context);
                    });
                  }
                },
                child: TextField(
                  controller: timeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Time",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(LucideIcons.clock),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancel"),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (titleController.text.isNotEmpty && timeController.text.isNotEmpty) {
                          this.setState(() {
                            _schedules.add({
                              'title': titleController.text,
                              'time': timeController.text,
                              'date': _selectedDay,
                            });
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Add"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteSchedule(Map<String, dynamic> schedule) {
    setState(() {
      _schedules.remove(schedule);
    });
  }
}

