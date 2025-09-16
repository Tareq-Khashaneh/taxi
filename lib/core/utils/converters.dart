enum UserRole { admin, user, guest }

class Converters {
  static String userRoleToString(UserRole role) {
    return role.toString().split('.').last;
  }

  static UserRole stringToUserRole(String roleStr) {
    return UserRole.values.firstWhere(
          (e) => e.toString().split('.').last == roleStr,
      orElse: () => UserRole.guest,
    );
  }
}
