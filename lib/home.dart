import 'package:sxe/data/models/log.dart';
import 'package:sxe/data/models/status.dart';
import 'package:sxe/data/repository/appwrite_repository.dart';
import 'package:sxe/ui/components/checkered_background.dart';
import 'package:sxe/ui/components/collapsible_bottomsheet.dart';
import 'package:sxe/ui/components/connection_status_view.dart';
import 'package:sxe/ui/components/getting_started_cards.dart';
import 'package:sxe/ui/components/top_platform_view.dart';
import 'package:sxe/utils/extensions/build_context.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final List<Log> _logs = [];
  Status _status = Status.idle;
  final AppwriteRepository _repository = AppwriteRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CheckeredBackground(
        child: SafeArea(
          minimum: EdgeInsets.only(
              top: context.isExtraWideScreen
                  ? 156
                  : context.isLargeScreen
                      ? 24
                      : 32),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  spacing: 16,
                  children: [
                    TopPlatformView(status: _status),
                    ConnectionStatusView(
                      status: _status,
                      onButtonClick: () async {
                        setState(() => _status = Status.loading);
                        final log = await _repository.ping();
                        _logs.add(log);

                        await Future.delayed(
                          const Duration(milliseconds: 1250),
                        );

                        setState(
                          () => _status =
                              (200 <= log.status && log.status <= 399)
                                  ? Status.success
                                  : Status.error,
                        );
                      },
                    ),
                    GettingStartedCards()
                  ],
                ),
              ),

              // bottomsheet
              Align(
                alignment: Alignment.bottomCenter,
                child: CollapsibleBottomSheet(
                  logs: _logs,
                  projectInfo: _repository.getProjectInfo(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
