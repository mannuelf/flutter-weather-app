class Console {
  // using static method so i do not have to instantiate a Console object.
  static String log(String title, dynamic arg) {
    print(title);
    print(arg);
    print('=================================================================\n');
    return "$title - $arg";
  }
}