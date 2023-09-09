import 'package:flutter/material.dart';
import 'package:selectos/selectos.dart';


typedef ChangeValue = ValueChanged<SelectosOption>;

typedef ChangeMultipleValue = ValueChanged<List<SelectosOption>>;

typedef RemoteRecord = Future<SelectosRemoteResponse> Function({ String query });

typedef RemoteRecordMultiple = Future<List<SelectosRemoteResponse>> Function({ String query });


