import 'package:collection/collection.dart';

abstract class IEntity {
  const IEntity();

  static const DeepCollectionEquality _equality = DeepCollectionEquality();

  @override
  int get hashCode => runtimeType.hashCode ^ mapPropsToHashCode(props);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IEntity &&
          runtimeType == other.runtimeType &&
          _equals(props, other.props);

  List<Object?> get props;

  bool _equals(List? list1, List? list2) {
    if (identical(list1, list2)) return true;
    if (list1 == null || list2 == null) return false;
    final length = list1.length;
    if (length != list2.length) return false;

    for (var i = 0; i < length; i++) {
      final dynamic unit1 = list1[i];
      final dynamic unit2 = list2[i];

      if (_isEquatable(unit1) && _isEquatable(unit2)) {
        if (unit1 != unit2) return false;
      } else if (unit1 is Iterable || unit1 is Map) {
        if (!_equality.equals(unit1, unit2)) return false;
      } else if (unit1?.runtimeType != unit2?.runtimeType) {
        return false;
      } else if (unit1 != unit2) {
        return false;
      }
    }
    return true;
  }

  bool _isEquatable(dynamic object) {
    return object is IEntity;
  }

  int mapPropsToHashCode(Iterable? props) =>
      _finish(props == null ? 0 : props.fold(0, _combine));

  int _finish(int hash) {
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }

  int _combine(int hash, dynamic object) {
    if (object is Map) {
      object.keys
          .sorted((dynamic a, dynamic b) => a.hashCode - b.hashCode)
          .forEach((dynamic key) {
        hash = hash ^ _combine(hash, <dynamic>[key, object[key]]);
      });
      return hash;
    }
    if (object is Iterable) {
      for (final value in object) {
        hash = hash ^ _combine(hash, value);
      }
      return hash ^ object.length;
    }

    hash = 0x1fffffff & (hash + object.hashCode);
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }
}
