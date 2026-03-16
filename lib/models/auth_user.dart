class AppUser {
  final String id;
  final String email;

  AppUser({
    required this.id,
    required this.email,
  });

  factory AppUser.fromSupabaseUser(dynamic supabaseUser) {
    return AppUser(
      id: supabaseUser.id,
      email: supabaseUser.email ?? '',
    );
  }
}
