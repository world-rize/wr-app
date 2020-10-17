// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:wr_app/i10n/i10n.dart';

extension PlatformExceptionEx on PlatformException {
  String toLocalizedMessage(BuildContext context) {
    switch (code) {
      case 'ERROR_INVALID_EMAIL':
        return I.of(context).errorInvalidEmail;
      case 'ERROR_WRONG_PASSWORD':
        return I.of(context).errorWrongPassword;
      case 'ERROR_USER_NOT_FOUND':
        return I.of(context).errorUserNotFound;
      case 'ERROR_USER_DISABLED':
        return I.of(context).errorUserDisabled;
      case 'ERROR_TOO_MANY_REQUESTS':
        return I.of(context).errorTooManyRequests;
      case 'ERROR_OPERATION_NOT_ALLOWED':
        return I.of(context).errorOperationNotAllowed;
      default:
        return I.of(context).errorUndefinedError;
    }
  }
}
