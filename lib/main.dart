import 'package:chat_supabase_riverpood/view/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_supabase_riverpood/models/chat_model.dart';
import 'package:chat_supabase_riverpood/provider/chat_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://iyidecmdyhivdqjjdczx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml5aWRlY21keWhpdmRxampkY3p4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAxNjIyMDIsImV4cCI6MjAxNTczODIwMn0.-SSo8FqwiGpWdaQ0TdCikiQY374vE0BT1EzYk90pYRg',
  );
  runApp( MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChatPage(),
      ),
    );
  }
}