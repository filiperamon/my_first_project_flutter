import 'package:flutter/material.dart';
import 'package:my_first_project_flutter/commponents/task_widget.dart';
import 'package:my_first_project_flutter/data/task_dao.dart';
import 'package:my_first_project_flutter/data/task_inherited.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key, required this.taskContext}) : super(key: key);

  final BuildContext taskContext;


  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultController = TextEditingController();
  TextEditingController imgController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool difficultyValidator(String? value) {
    if ((value != null && value.isNotEmpty)) {
      if (int.parse(value) > 0 && int.parse(value) < 6) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: const Text("Nova tarefa"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 650,
              width: 375,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 3)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (!valueValidator(value)) {
                          return 'Insira o nome da Tarefa.';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Nome",
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (!difficultyValidator(value)) {
                          return 'Insira uma dificuldade entre 1 e 5.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      controller: difficultController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Dificuldade",
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (!valueValidator(value)) {
                          return 'Insira uma image.';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      controller: imgController,
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Imagem",
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 72,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Colors.blue),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imgController.text,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset(
                            "assets/images/imgflutter.png",
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {

                        TaskDao().save(Task(nameController.text,
                            imgController.text,
                            int.parse(difficultController.text)));

                        /*TaskInherited.of(widget.taskContext).newTask(
                            nameController.text,
                            imgController.text,
                            int.parse(difficultController.text));*/

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Salvando nova tarefa.")),
                        );

                        Navigator.of(context).pop(
                            Task(nameController.text,
                                imgController.text,
                                int.parse(difficultController.text))
                        );
                      }
                    },
                    child: const Text("Adicionar"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
