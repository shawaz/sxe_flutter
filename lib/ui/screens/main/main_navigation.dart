import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sxe/providers/session_provider.dart';
import 'package:sxe/ui/screens/main/activity_tracker_screen.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/screens/main/vision_board_screen.dart';
import 'package:sxe/ui/screens/main/ai_assistant_screen.dart';
import 'package:sxe/ui/screens/main/wallet_screen.dart';
import 'package:sxe/ui/screens/main/profile_screen.dart';
import 'package:sxe/ui/components/session_warning_dialog.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const VisionBoardScreen(),
    const ActivityTrackerScreen(),
    const AIAssistantScreen(),
    const WalletScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Start session monitoring when main navigation is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SessionProvider>(context, listen: false)
          .startSessionMonitoring();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionProvider>(
      builder: (context, sessionProvider, child) {
        // Show session warning dialog if needed
        if (sessionProvider.showSessionWarning) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const SessionWarningDialog(),
            );
          });
        }

        return GestureDetector(
          onTap: () => sessionProvider.updateActivity(),
          onPanUpdate: (_) => sessionProvider.updateActivity(),
          child: Scaffold(
            backgroundColor: SXEColors.background,
            appBar: AppBar(
              title: Text('SXE', style: TextStyle(color: Colors.white)),
              centerTitle: true,
              backgroundColor: Colors.black,
              elevation: 0,
            ),
            body: _screens[_selectedIndex],
            bottomNavigationBar: SafeArea(
              child: GNav(
                gap: 4,
                activeColor: SXEColors.primary,
                iconSize: 22,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                duration: const Duration(milliseconds: 400),
                color: SXEColors.textTertiary,
                tabs: [
                  GButton(
                    icon: LucideIcons.target,
                  ),
                  GButton(
                    icon: LucideIcons.checkCircle2,
                  ),
                  GButton(
                    icon: LucideIcons.bot,
                  ),
                  GButton(
                    icon: LucideIcons.circleDot,
                  ),
                  GButton(
                    icon: LucideIcons.userCircle,
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
