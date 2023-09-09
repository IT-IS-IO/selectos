

bool isNull(dynamic value) => value == null;

bool isNotNull(dynamic value) => value != null;

String? emptyToNull(String value) => value.isEmpty ? null : value;