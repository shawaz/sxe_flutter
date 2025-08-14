import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/theme/sxe_typography.dart';

enum BlockType {
  text,
  heading,
  bulletList,
  numberedList,
  table,
  task,
  aiNote,
  file,
  divider,
}

class NotionBlock {
  String id;
  BlockType type;
  String content;
  Map<String, dynamic> data;
  bool isEditing;

  NotionBlock({
    required this.id,
    required this.type,
    this.content = '',
    this.data = const {},
    this.isEditing = false,
  });
}

class NotionVisionDetailScreen extends StatefulWidget {
  final String title;
  final String category;
  final IconData icon;
  final double progress;
  final Color color;

  const NotionVisionDetailScreen({
    super.key,
    required this.title,
    required this.category,
    required this.icon,
    required this.progress,
    required this.color,
  });

  @override
  State<NotionVisionDetailScreen> createState() =>
      _NotionVisionDetailScreenState();
}

class _NotionVisionDetailScreenState extends State<NotionVisionDetailScreen> {
  late double _currentProgress;
  final List<NotionBlock> _blocks = [];
  final ScrollController _scrollController = ScrollController();
  bool _showAIAssistant = false;
  final List<String> _aiSuggestions = [];

  @override
  void initState() {
    super.initState();
    _currentProgress = widget.progress;
    _generateInitialBlocks();
    _generateAISuggestions();
  }

  void _generateInitialBlocks() {
    _blocks.addAll([
      NotionBlock(
        id: '1',
        type: BlockType.heading,
        content: '🎯 ${widget.title} Journey',
      ),
      NotionBlock(
        id: '2',
        type: BlockType.aiNote,
        content:
            'AI Assistant suggests: Start with small, consistent actions to build momentum towards your ${widget.title.toLowerCase()} goals.',
        data: {'aiGenerated': true, 'timestamp': DateTime.now().toString()},
      ),
      NotionBlock(
        id: '3',
        type: BlockType.text,
        content:
            'Welcome to your personalized ${widget.title} workspace. Use this space to track progress, take notes, and organize your journey.',
      ),
      NotionBlock(
        id: '4',
        type: BlockType.heading,
        content: '📋 Current Tasks',
      ),
      NotionBlock(
        id: '5',
        type: BlockType.task,
        content: 'Set up daily routine',
        data: {'completed': false, 'priority': 'high'},
      ),
      NotionBlock(
        id: '6',
        type: BlockType.task,
        content: 'Track weekly progress',
        data: {'completed': false, 'priority': 'medium'},
      ),
      NotionBlock(
        id: '7',
        type: BlockType.divider,
        content: '',
      ),
      NotionBlock(
        id: '8',
        type: BlockType.heading,
        content: '📊 Progress Table',
      ),
      NotionBlock(
        id: '9',
        type: BlockType.table,
        content: '',
        data: {
          'headers': ['Date', 'Activity', 'Status', 'Notes'],
          'rows': [
            ['2024-01-01', 'Initial setup', 'Completed', 'Started journey'],
            [
              '2024-01-02',
              'First milestone',
              'In Progress',
              'Making good progress'
            ],
          ],
        },
      ),
    ]);
  }

  void _generateAISuggestions() {
    _aiSuggestions.addAll([
      'Create a daily routine for ${widget.title.toLowerCase()}',
      'Set weekly milestones to track progress',
      'Add a reflection section for insights',
      'Create a resource list for helpful materials',
      'Set up accountability measures',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SXEColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title,
          style: SXETypography.functionalHeadline,
        ),
        actions: [
          IconButton(
            icon: Icon(_showAIAssistant ? LucideIcons.x : LucideIcons.bot),
            onPressed: () {
              setState(() {
                _showAIAssistant = !_showAIAssistant;
              });
            },
          ),
          IconButton(
            icon: const Icon(LucideIcons.plus),
            onPressed: _showAddBlockMenu,
          ),
        ],
      ),
      body: Row(
        children: [
          // Main content area
          Expanded(
            flex: _showAIAssistant ? 2 : 1,
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          widget.color.withValues(alpha: 0.1),
                          widget.color.withValues(alpha: 0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: widget.color.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: widget.color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            widget.icon,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style:
                                    SXETypography.functionalHeadline.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '${(_currentProgress * 100).toInt()}% complete',
                                style: SXETypography.bodySmall.copyWith(
                                  color: widget.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${(_currentProgress * 100).toInt()}%',
                          style: SXETypography.functionalHeadline.copyWith(
                            color: widget.color,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Notion-like blocks
                  ..._blocks.map((block) => _buildBlock(block)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlock(NotionBlock block) {
    switch (block.type) {
      case BlockType.heading:
        return _buildHeadingBlock(block);
      case BlockType.text:
        return _buildTextBlock(block);
      case BlockType.task:
        return _buildTaskBlock(block);
      case BlockType.aiNote:
        return _buildAINote(block);
      case BlockType.table:
        return _buildTableBlock(block);
      case BlockType.divider:
        return _buildDividerBlock(block);
      default:
        return _buildTextBlock(block);
    }
  }

  Widget _buildHeadingBlock(NotionBlock block) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Text(
        block.content,
        style: SXETypography.functionalHeadline.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextBlock(NotionBlock block) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Text(
        block.content,
        style: SXETypography.bodyMedium,
      ),
    );
  }

  Widget _buildTaskBlock(NotionBlock block) {
    final isCompleted = block.data['completed'] ?? false;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: SXEColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCompleted
              ? Colors.green.withValues(alpha: 0.3)
              : SXEColors.borderLight,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                block.data['completed'] = !isCompleted;
              });
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isCompleted ? Colors.green : Colors.transparent,
                border: Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isCompleted
                  ? const Icon(
                      LucideIcons.check,
                      color: Colors.white,
                      size: 12,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              block.content,
              style: SXETypography.bodyMedium.copyWith(
                decoration: isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAINote(NotionBlock block) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              LucideIcons.bot,
              color: Colors.white,
              size: 12,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              block.content,
              style: SXETypography.bodyMedium.copyWith(
                color: Colors.blue.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableBlock(NotionBlock block) {
    final headers = List<String>.from(block.data['headers'] ?? []);
    final rows = List<List<String>>.from(
      (block.data['rows'] ?? []).map((row) => List<String>.from(row)),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: SXEColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: SXEColors.borderLight),
      ),
      child: Column(
        children: [
          // Headers
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: SXEColors.primary.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: headers
                  .map((header) => Expanded(
                        child: Text(
                          header,
                          style: SXETypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          // Rows
          ...rows.map((row) => Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: SXEColors.borderLight),
                  ),
                ),
                child: Row(
                  children: row
                      .map((cell) => Expanded(
                            child: Text(
                              cell,
                              style: SXETypography.bodyMedium,
                            ),
                          ))
                      .toList(),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildDividerBlock(NotionBlock block) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 1,
      color: SXEColors.borderLight,
    );
  }

  Widget _buildAIAssistant() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: SXEColors.primary.withValues(alpha: 0.1),
            border: Border(
              bottom: BorderSide(color: SXEColors.borderLight),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: SXEColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  LucideIcons.bot,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'AI Assistant',
                style: SXETypography.functionalHeadline.copyWith(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Suggestions for ${widget.title}',
                style: SXETypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ..._aiSuggestions.map((suggestion) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: SXEColors.background,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: SXEColors.borderLight),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          LucideIcons.lightbulb,
                          size: 16,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            suggestion,
                            style: SXETypography.bodySmall,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(LucideIcons.plus, size: 16),
                          onPressed: () => _addAISuggestionAsBlock(suggestion),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  void _showAddBlockMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: SXEColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Block',
                style: SXETypography.functionalHeadline,
              ),
              const SizedBox(height: 16),
              _buildBlockOption('Text', LucideIcons.type, BlockType.text),
              _buildBlockOption(
                  'Heading', LucideIcons.heading, BlockType.heading),
              _buildBlockOption(
                  'Task', LucideIcons.checkSquare, BlockType.task),
              _buildBlockOption('Table', LucideIcons.table, BlockType.table),
              _buildBlockOption(
                  'Divider', LucideIcons.minus, BlockType.divider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBlockOption(String title, IconData icon, BlockType type) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        _addBlock(type);
      },
    );
  }

  void _addBlock(BlockType type) {
    final newBlock = NotionBlock(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
      content: type == BlockType.heading
          ? 'New Heading'
          : type == BlockType.task
              ? 'New Task'
              : type == BlockType.text
                  ? 'Start typing...'
                  : '',
      data: type == BlockType.task ? {'completed': false} : {},
    );

    setState(() {
      _blocks.add(newBlock);
    });
  }

  void _addAISuggestionAsBlock(String suggestion) {
    final newBlock = NotionBlock(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: BlockType.task,
      content: suggestion,
      data: {'completed': false, 'aiGenerated': true},
    );

    setState(() {
      _blocks.add(newBlock);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
