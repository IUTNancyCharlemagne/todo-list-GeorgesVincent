import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'todo_list_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async{
  await dotenv.load(fileName: "../../asset/.env");
  await Supabase.initialize(url : dotenv.env['SUPABASE_URL'] ?? '',
    anonKey : dotenv.env['SUPABASE_API_KEY'] ?? '');
  runApp(const ToDoListApp());
}
