import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:tech_control/domain/models/type_model.dart';

import 'my_dao.dart';


@Database(version: 3, entities: [
  TypeData,
])
abstract class AppDatabase extends FloorDatabase {
  MyDao get myDao;
}
