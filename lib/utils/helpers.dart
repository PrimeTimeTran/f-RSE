import 'package:flutter/foundation.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log([String tag = '']) {
    devtools.log(this.toString(), name: tag);
  }
}

// Toggle print statements everywhere more easily.
// Sometimes we do need to see print statements in prod.
void p(v) {
  if (kDebugMode) {
    print(v);
  }
}
