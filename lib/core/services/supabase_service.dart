import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://vrblpdmuuaujdonpdkuu.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZyYmxwZG11dWF1amRvbnBka3V1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA2MjE3OTIsImV4cCI6MjA3NjE5Nzc5Mn0.FTWrfgp4UwUuvIgr2oS2l2o9kBRmKqtiOmu38QyEE-s',
    );
  }

  SupabaseClient get client => Supabase.instance.client;
  GoTrueClient get auth => client.auth;
}
