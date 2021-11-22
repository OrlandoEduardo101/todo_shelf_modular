import 'package:postgres/postgres.dart';

abstract class IDatabaseError extends PostgreSQLException {
  IDatabaseError(String? message) : super(message);
}

class ErrorToQuery implements IDatabaseError {
  @override
  String? code;

  @override
  String? columnName;

  @override
  String? constraintName;

  @override
  String? dataTypeName;

  @override
  String? detail;

  @override
  String? fileName;

  @override
  String? hint;

  @override
  int? internalPosition;

  @override
  String? internalQuery;

  @override
  int? lineNumber;

  @override
  String? message;

  @override
  int? position;

  @override
  String? routineName;

  @override
  String? schemaName;

  @override
  PostgreSQLSeverity? severity;

  @override
  StackTrace? stackTrace;

  @override
  String? tableName;

  @override
  String? trace;
  
  ErrorToQuery({
    this.code,
    this.columnName,
    this.constraintName,
    this.dataTypeName,
    this.detail,
    this.fileName,
    this.hint,
    this.internalPosition,
    this.internalQuery,
    this.lineNumber,
    this.message,
    this.position,
    this.routineName,
    this.schemaName,
    this.severity,
    this.stackTrace,
    this.tableName,
    this.trace,
  });
  
}
