import 'package:mvvm_architecture/app/extensions.dart';

import '../../domain/model/model.dart';
import '../responses/responses.dart';

const EMPTY = "";
const ZERO = 0;
extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id?.orEmpty() ?? EMPTY,
        this?.name?.orEmpty() ?? EMPTY,
        this?.numOfNotifications?.orZero() ?? ZERO);
  }
}
extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(this?.email?.orEmpty() ?? EMPTY,
        this?.phone?.orEmpty() ?? EMPTY, this?.link?.orEmpty() ?? EMPTY);
  }
}
extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.customer!.toDomain(), this?.contacts?.toDomain());
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? EMPTY;
  }
}