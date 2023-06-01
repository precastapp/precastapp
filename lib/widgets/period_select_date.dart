import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../util/util.dart';

class PeriodSelectDate extends StatelessWidget {
  String labelFrom;
  DateTime? initialDateFrom;
  ValueChanged<DateTime> onChangeFrom;
  String labelTo;
  DateTime? initialDateTo;
  ValueChanged<DateTime> onChangeTo;
  var dateFormat = DateFormat.yMd(localeSelected.value.toLanguageTag());

  PeriodSelectDate({
    required this.labelFrom,
    required this.initialDateFrom,
    required this.onChangeFrom,
    required this.labelTo,
    required this.initialDateTo,
    required this.onChangeTo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: buildDate('From'.tr, initialDateFrom, onChangeFrom)),
        SizedBox(width: kPaddingInternal),
        Expanded(child: buildDate('To'.tr, initialDateTo, onChangeTo)),
      ],
    );
  }

  Widget buildDate(
      String label, DateTime? initialDate, ValueChanged<DateTime> onChange) {
    return DateTimeFormField(
      mode: DateMode.date,
      decoration:
          InputDecoration(hintText: label, suffixIcon: Icon(Icons.calendar)),
      initialDate: initialDate,
      dateFormatter: dateFormat.pattern,
      onChange: onChange,
      title: "Select".tr,
      textCancel: "Cancel".tr,
      textConfirm: "Confirm".tr,
      validator: defaultValidator,
    );
  }
}
