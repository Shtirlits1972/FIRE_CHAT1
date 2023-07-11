class Users {
  String email = '';
  String password = '';
  String displayName = '';

  Users(this.email, this.password, this.displayName);

  Users.empty() {
    email = '';
    password = '';
    displayName = '';
  }

  @override
  String toString() {
    return 'email = $email, password = $password, displayName = $displayName ';
  }
}
