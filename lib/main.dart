import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'todo_list_app.dart';

Future<void> main() async{
  await Supabase.initialize(url : 'https://zudsjoiapadijzsqayna.supabase.co',
    anonKey : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1ZHNqb2lhcGFkaWp6c3FheW5hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY5NjgxODYsImV4cCI6MjAzMjU0NDE4Nn0.l_4WP5gF2aY3LJOxXhC2-Rtt0xtdoQ92Ia0SHc0F6X8');
  runApp(const ToDoListApp());
}
