import 'package:flutter/foundation.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log([String tag = '']) {
    devtools.log(this.toString(), name: tag);
  }
}

void p(v) {
  if (kDebugMode) {
    print(v);
  }
}
