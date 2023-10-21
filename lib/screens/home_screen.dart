import 'package:flutter/material.dart';
import 'package:my_first_project_flutter/data/task_dao.dart';
import 'package:my_first_project_flutter/screens/form_screen.dart';

import '../commponents/task_widget.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh))
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Hello world!",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
            future: TaskDao().findAll(),
            builder: (context, snapshot) {
              List<Task>? items = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text("Carregando")
                      ],
                    ),
                  );
                case ConnectionState.waiting:
                  return const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text("Carregando")
                      ],
                    ),
                  );
                case ConnectionState.active:
                  return const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text("Carregando")
                      ],
                    ),
                  );
                case ConnectionState.done:
                  if (snapshot.hasData && items != null) {
                    if (items.isNotEmpty) {
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            final task = items[index];
                            return Task(task.nome, task.photo, task.harded);
                          });
                    } else {
                      return const Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 100,
                            ),
                            Text(
                              "Nenhuma tarefa encontrada.",
                              style: TextStyle(fontSize: 32),
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                    return const Text("Erro ao carregar tarefa.");
                  }
              }
            }),
      ),
      /*ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        children: TaskInherited.of(context).taskList,
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute<Task>(
                  builder: (contextNew) => FormScreen(
                    taskContext: context,
                  ),
                ),
              )
              .then((value) => setState(() {
                    print('Recarregando a tela inicial $value');
                  }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
