import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

TextStyle txt30 = const TextStyle(fontSize: 30, color: Colors.black);
TextStyle txt20 = const TextStyle(fontSize: 20, color: Colors.black);
TextStyle txt15 = const TextStyle(fontSize: 15, color: Colors.black);
TextStyle txt10 = const TextStyle(fontSize: 10, color: Colors.black);

const kPrimaryColor = Color(0xFF00BF6D);
const kSecondaryColor = Color(0xFFFE9901);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

const double highMessage = 200.0;

const kDefaultPadding = 10.0;

final DateFormat dateFormatter = DateFormat('HH:mm');

final DateFormat longDateFormatter = DateFormat('dd.MM.yy HH:mm');

//Size in physical pixels
var physicalScreenSize = window.physicalSize;
var physicalWidth = physicalScreenSize.width;
var physicalHeight = physicalScreenSize.height;

const String dbName = 'chatDB.db';
