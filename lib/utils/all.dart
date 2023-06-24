import 'dart:developer' as devtools show log;

extension Log on Object {
  void log([String tag = '']) {
    devtools.log(this.toString(), name: tag);
  }
// void log([String tag = '']) {
//   devtools.log(toString());
// }
}
