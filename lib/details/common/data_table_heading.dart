import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class DataTableHeading extends DataColumn2 {
  DataTableHeading({required String heading, required ColumnSize size})
      : super(
          label: Text(
            heading,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          size: size,
        );
}
