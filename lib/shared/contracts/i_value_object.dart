abstract class IValueObject {
  const IValueObject();

  bool get isValid;

  String? hasError();
}
