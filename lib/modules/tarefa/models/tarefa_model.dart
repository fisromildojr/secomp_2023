import 'package:objectbox/objectbox.dart';

@Entity()
class Tarefa {
  @Id()
  int id = 0;
  String title;
  String? descricao;
  bool executada;

  Tarefa({
    required this.title,
    this.descricao,
    required this.executada,
  });

  Tarefa copyWith({
    String? title,
    String? descricao,
    bool? executada,
  }) {
    return Tarefa(
      title: title ?? this.title,
      descricao: descricao ?? this.descricao,
      executada: executada ?? this.executada,
    );
  }

  @override
  String toString() {
    return 'Tarefa(id: $id, title: $title, descricao: $descricao, executada: $executada)';
  }

  @override
  bool operator ==(covariant Tarefa other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.descricao == descricao &&
        other.executada == executada;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        descricao.hashCode ^
        executada.hashCode;
  }
}
