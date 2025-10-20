import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SpiritualScreen extends StatelessWidget {
  const SpiritualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("SPIRITUAL", style: TextStyle(color: Colors.white),),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(LucideIcons.arrowLeft, color: Colors.white),
          ),
          bottom: TabBar(
            labelColor: Colors.deepOrangeAccent,
            unselectedLabelColor: Colors.black,

            indicatorColor: Colors.deepOrangeAccent,
            tabs: [
              Tab(text: "SPIRITUAL"),
              Tab(text: "SPIRITUAL"),
              Tab(text: "SPIRITUAL"),
            ],
          ),  
        ),
      ),
    );
  }
}