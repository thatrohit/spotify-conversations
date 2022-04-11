import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:spotify_conversations/app_theme.dart';
import 'package:spotify_conversations/home/home_view.dart';

void main() {
  runApp(FluentApp(
    title: 'Spotify Conversations',
    theme: AppTheme.appTheme,
    home: const HomePage(),
  ));
}
