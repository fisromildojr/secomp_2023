import 'package:flutter/material.dart';
import 'package:secomp2023/database/objectbox.g.dart';
import 'package:secomp2023/database/objectbox_database.dart';
import 'package:secomp2023/modules/tarefa/models/tarefa_model.dart';

class TarefaListPage extends StatefulWidget {
  const TarefaListPage({super.key});

  @override
  State<TarefaListPage> createState() => _TarefaListPageState();
}

class _TarefaListPageState extends State<TarefaListPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descricaoController = TextEditingController();

  Future<Box> getBox() async {
    final store = await ObjectBoxDatabase.getStore();
    return store.box<Tarefa>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Tarefa>>(
          future: getAll(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final tarefas = snapshot.data as List<Tarefa>;
                return tarefas.isEmpty
                    ? const Center(
                        child: Text('Nenhuma tarefa encontrada...'),
                      )
                    : ListView.builder(
                        itemCount: tarefas.length,
                        itemBuilder: (ctx, index) => Card(
                          child: ListTile(
                            onLongPress: () => _delete(tarefas[index]),
                            onTap: () => _toggle(tarefas[index]),
                            title: Text(
                              tarefas[index].title,
                            ),
                            subtitle: Text(
                              tarefas[index].descricao ?? '',
                              textAlign: TextAlign.justify,
                            ),
                            trailing: tarefas[index].executada
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.radio_button_unchecked,
                                    color: Colors.red,
                                  ),
                          ),
                        ),
                      );
              } else {
                const Center(
                  child: Text('Erro ao buscar tarefas...'),
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _create,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _create() {
    // Limpar campos para garantir que não estará preenchido ao clicar para criar
    _titleController.clear();
    _descricaoController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nova Tarefa',
            ),
          ],
        ),
        content: Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                      controller: _titleController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        label: Text('Título'),
                        hintText: 'Digite o título da tarefa...',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      }),
                  TextFormField(
                    controller: _descricaoController,
                    decoration: const InputDecoration(
                      label: Text('Descrição'),
                      hintText: 'Digite uma descrição...',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('CANCELAR'),
          ),
          ElevatedButton(
            onPressed: _save,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('SALVAR'),
          ),
        ],
      ),
    );
  }

  Future<List<Tarefa>> getAll() async {
    final box = await getBox();
    return box.getAll() as List<Tarefa>;
  }

  void _toggle(Tarefa tarefa) async {
    tarefa.executada = !tarefa.executada;

    final box = await getBox();
    setState(() {
      box.put(tarefa);
    });
  }

  void _save() async {
    if (_formKey.currentState?.validate() ?? false) {
      final tarefa = Tarefa(
        title: _titleController.text,
        descricao: _descricaoController.text,
        executada: false,
      );
      final box = await getBox();

      setState(() {
        box.put(tarefa);
        // tarefas.add(tarefa);
      });

      Navigator.of(context).pop();
    }
  }

  void _delete(Tarefa tarefa) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmação'),
        content: const Text('Confirma a exclusão da tarefa?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('NÃO'),
          ),
          ElevatedButton(
            onPressed: () async {
              final box = await getBox();

              setState(() {
                box.remove(tarefa.id);
              });

              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('SIM'),
          ),
        ],
      ),
    );
  }
}
