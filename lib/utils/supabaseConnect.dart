import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static Future<void> initializeSupabase() async {
    await Supabase.initialize(
      url: 'https://ovnwutpikzlwuktypxlj.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im92bnd1dHBpa3psd3VrdHlweGxqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTcyMzI5ODMsImV4cCI6MjAzMjgwODk4M30.4BXmoZ7MIJOMmzqz9o7Q2Dwb-ctM5ly7LeLbaNsAfaA',
    );
  }

  static Stream<List<Map<String, dynamic>>> fetchUserDetails() {
    final userStream = Supabase.instance.client
        .from('user')
        .stream(primaryKey: ['user_id']);
    return userStream;
  }

    static Future<void> addUser(
      String email, String firstName, String password) async {
    final response = await Supabase.instance.client.from('user').insert({
      'email': email,
      'name': firstName,
      'password': password,
    }).select();

    // if (response.error != null) {
    //   throw response.error!;
    // }
  }


}


