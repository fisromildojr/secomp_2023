// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import '../modules/tarefa/models/tarefa_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 3600498835485635569),
      name: 'Tarefa',
      lastPropertyId: const IdUid(4, 2867243089980359630),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7978350033288843724),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5638868018692067002),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7529593927931960650),
            name: 'descricao',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2867243089980359630),
            name: 'executada',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 3600498835485635569),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Tarefa: EntityDefinition<Tarefa>(
        model: _entities[0],
        toOneRelations: (Tarefa object) => [],
        toManyRelations: (Tarefa object) => {},
        getId: (Tarefa object) => object.id,
        setId: (Tarefa object, int id) {
          object.id = id;
        },
        objectToFB: (Tarefa object, fb.Builder fbb) {
          final titleOffset = fbb.writeString(object.title);
          final descricaoOffset = object.descricao == null
              ? null
              : fbb.writeString(object.descricao!);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, titleOffset);
          fbb.addOffset(2, descricaoOffset);
          fbb.addBool(3, object.executada);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final descricaoParam = const fb.StringReader(asciiOptimization: true)
              .vTableGetNullable(buffer, rootOffset, 8);
          final executadaParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 10, false);
          final object = Tarefa(
              title: titleParam,
              descricao: descricaoParam,
              executada: executadaParam)
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Tarefa] entity fields to define ObjectBox queries.
class Tarefa_ {
  /// see [Tarefa.id]
  static final id = QueryIntegerProperty<Tarefa>(_entities[0].properties[0]);

  /// see [Tarefa.title]
  static final title = QueryStringProperty<Tarefa>(_entities[0].properties[1]);

  /// see [Tarefa.descricao]
  static final descricao =
      QueryStringProperty<Tarefa>(_entities[0].properties[2]);

  /// see [Tarefa.executada]
  static final executada =
      QueryBooleanProperty<Tarefa>(_entities[0].properties[3]);
}
