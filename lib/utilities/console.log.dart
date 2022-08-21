
class Console {
  late final String _title;
  late final dynamic _arg;

  String log(String title, dynamic arg) {
    _title = title;
    _arg = arg;
    print(_title);
    print(_arg);
    print('=================================================================\n');
    return "$_title - $arg";
  }
}