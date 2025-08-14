import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sxe/providers/session_provider.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/theme/sxe_typography.dart';

class SessionWarningDialog extends StatefulWidget {
  const SessionWarningDialog({super.key});

  @override
  State<SessionWarningDialog> createState() => _SessionWarningDialogState();
}

class _SessionWarningDialogState extends State<SessionWarningDialog> {
  Timer? _countdownTimer;
  int _remainingSeconds = 300; // 5 minutes

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        if (mounted) {
          Navigator.of(context).pop();
          Provider.of<SessionProvider>(context, listen: false).forceLogout();
        }
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: SXEColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: SXEColors.coral,
            size: 28,
          ),
          const SizedBox(width: 12),
          Text(
            'Session Expiring',
            style: SXETypography.functionalHeadline.copyWith(
              color: SXEColors.coral,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your session will expire in:',
            style: SXETypography.bodyMedium,
          ),
          const SizedBox(height: 16),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: SXEColors.coral.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: SXEColors.coral.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                _formatTime(_remainingSeconds),
                style: SXETypography.largeHeadline.copyWith(
                  color: SXEColors.coral,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Would you like to extend your session?',
            style: SXETypography.bodyMedium.copyWith(
              color: SXEColors.textSecondary,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Provider.of<SessionProvider>(context, listen: false).forceLogout();
          },
          style: TextButton.styleFrom(
            foregroundColor: SXEColors.textSecondary,
          ),
          child: const Text('Logout'),
        ),
        ElevatedButton(
          onPressed: () async {
            final sessionProvider = Provider.of<SessionProvider>(context, listen: false);
            final success = await sessionProvider.extendSession();
            
            if (mounted) {
              Navigator.of(context).pop();
              
              if (!success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to extend session. Please login again.'),
                    backgroundColor: SXEColors.error,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Session extended successfully!'),
                    backgroundColor: SXEColors.kelp,
                  ),
                );
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: SXEColors.primary,
          ),
          child: const Text('Extend Session'),
        ),
      ],
    );
  }
}
