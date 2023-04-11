/// Type definition for custom bs form validator
typedef BsSelectValidatorValue<T> = String? Function(T? value);

class BsSelectValidator {
  const BsSelectValidator({
    required this.validator,
  });

  /// validator function to check value is valid or not
  final BsSelectValidatorValue validator;
}

class BsSelectValidators {
  /// define required validation
  static BsSelectValidator get required => BsSelectValidator(
    validator: (value) {
      String valueValidate = value.toString().trim();
      if (valueValidate.isEmpty || value == null) return "Select field is required";

      return null;
    },
  );
}