import 'package:flutter/material.dart';
import 'package:notes/features/home/view/home_view.dart';
import 'package:notes/features/missed_notes/view/missed_notes_view.dart';
import 'package:notes/features/settings/view/settings_view.dart';

class NavBarPages {
  static const List<Widget> pages = [
    HomeScreen(),
    MissedNotesScreen(),
    SettingScreen(),
  ];
}