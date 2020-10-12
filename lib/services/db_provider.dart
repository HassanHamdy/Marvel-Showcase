import 'dart:io';

import 'package:movies_showcase/models/api_data_response.dart';
import 'package:movies_showcase/models/api_response.dart';
import 'package:movies_showcase/models/character_model.dart';
import 'package:movies_showcase/models/related_data_model.dart';
import 'package:movies_showcase/models/related_data_types.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbProvider {
  DbProvider._();

  static final DbProvider db = DbProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await init();
    return _database;
  }

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Marvel.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (dbInstance, version) {
        dbInstance.execute('''
          CREATE TABLE characters(
            id INTEGER PRIMARY KEY,
            name TEXT,
            description TEXT,
            thumbnail TEXT
          )        
          ''');

        dbInstance.execute('''
          CREATE TABLE comics(
            id INTEGER PRIMARY KEY,
            characterId INTEGER,
            title TEXT,
            thumbnail TEXT,
            FOREIGN KEY (characterId) REFERENCES characters (id) ON DELETE NO ACTION ON UPDATE NO ACTION
        )    
          ''');

        dbInstance.execute('''
          CREATE TABLE events(
        id INTEGER PRIMARY KEY,
        characterId INTEGER,
        title TEXT,
        thumbnail TEXT,
        FOREIGN KEY (characterId) REFERENCES characters (id) ON DELETE NO ACTION ON UPDATE NO ACTION
        )   
          ''');

        dbInstance.execute('''
          CREATE TABLE series(
        id INTEGER PRIMARY KEY,
        characterId INTEGER,
        title TEXT,
        thumbnail TEXT,
        FOREIGN KEY (characterId) REFERENCES characters (id) ON DELETE NO ACTION ON UPDATE NO ACTION
        ) 
          ''');

        dbInstance.execute('''
          CREATE TABLE stories(
        id INTEGER PRIMARY KEY,
        characterId INTEGER,
        title TEXT,
        thumbnail TEXT,
        FOREIGN KEY (characterId) REFERENCES characters (id) ON DELETE NO ACTION ON UPDATE NO ACTION
        )    
          ''');
      },
    );
  }

  Future<ApiResponse<CharacterModel>> fetchCharacters() async {
    final _db = await database;
    final charactersModel = await _db.query("characters", columns: null);
    if (charactersModel.length > 0) {
      final characters = new List<CharacterModel>();
      charactersModel.forEach((v) {
        characters.add(CharacterModel.fromDB(v));
      });
      ApiResponse response = ApiResponse<CharacterModel>(
          code: 200,
          data: ApiDataResponse<CharacterModel>(results: characters));
      return response;
    }

    return null;
  }

  Future<ApiResponse<RelatedDataModel>> fetchRelatedData(
      int characterId, RelatedDataTypes type) async {
    final _db = await database;
    final dbModel = await _db.query(RelatedDataTypesHelper.getValue(type),
        columns: ['id', 'title', 'thumbnail'],
        where: "characterId = ?",
        whereArgs: [characterId]);
    if (dbModel.length > 0) {
      final relatedDataList = new List<RelatedDataModel>();
      dbModel.forEach((v) {
        relatedDataList.add(RelatedDataModel.fromDB(v));
      });
      ApiResponse response = ApiResponse<RelatedDataModel>(
          code: 200,
          data: ApiDataResponse<RelatedDataModel>(results: relatedDataList));
      return response;
    }

    return null;
  }

  Future<List<dynamic>> addCharacters(List<CharacterModel> characters) async {
    final _db = await database;
    Batch batch = _db.batch();
    characters.forEach((element) {
      batch.insert('characters', element.toJson());
    });
    return batch.commit(noResult: true);
  }

  Future<List<dynamic>> addRelatedData(List<RelatedDataModel> relatedDataList,
      int characterId, RelatedDataTypes type) async {
    final _db = await database;
    Batch batch = _db.batch();
    relatedDataList.forEach((element) {
      batch.insert(
          RelatedDataTypesHelper.getValue(type), element.toJson(characterId));
    });
    return batch.commit(noResult: true);
  }
}
