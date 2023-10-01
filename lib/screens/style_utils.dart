import 'package:flutter/material.dart';

const InputDecoration dropdownStyle = InputDecoration(
  border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      gapPadding: 4.0),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.amberAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      gapPadding: 4.0),
  labelStyle: TextStyle(color: Colors.black),
  contentPadding: EdgeInsets.only(right: 8.0, left: 16.0),
  suffixIconColor: Colors.black,
);
