import 'package:selectos/selectos.dart';
import 'package:selectos/src/config/methods.dart';





class SelectosValidator {

  static String? required(SelectosOption? value) {
    if (isNull(value)) return SelectosValidatorsErrors.required;
    return null;
  }


  static String? requiredMultiple(List<SelectosOption> value) {
    if (value.isEmpty) return SelectosValidatorsErrors.requiredMultiple;
    return null;
  }


}



class SelectosValidatorsErrors {

  static String required = "Select field is required";

  static String requiredMultiple = "Select required at least one option";

}