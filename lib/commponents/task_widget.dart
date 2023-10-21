import 'package:flutter/material.dart';
import 'package:my_first_project_flutter/data/task_dao.dart';

import 'difficulty_widged.dart';

class Task extends StatefulWidget {
  final String nome;
  final String photo;
  final int harded;

  Task(this.nome, this.photo, this.harded, {super.key});

  int experience = 0;
  int level = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {

  bool assetOrNetwork() {
    if (widget.photo.contains("http")) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blue,
            ),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black26,
                      ),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: assetOrNetwork()
                            ? Image.asset(
                                widget.photo,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                widget.photo,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(widget.nome,
                              style: const TextStyle(
                                  fontSize: 24,
                                  overflow: TextOverflow.ellipsis)),
                        ),
                        Difficulty(difficultyLevel: widget.harded)
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      height: 70,
                      child: ElevatedButton(
                        onLongPress: () {
                          TaskDao().delete(widget.nome);
                        },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            setState(() {
                              widget.experience++;
                              if (widget.harded * 10 == widget.experience) {
                                widget.level++;
                                widget.experience = 0;
                              }
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.arrow_drop_up),
                              Text("${widget.level}"),
                              const Text("UP"),
                            ],
                          )),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 300,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.white38,
                          color: Colors.white,
                          value: (widget.harded > 0
                                  ? (widget.experience / widget.harded)
                                  : 1) /
                              10,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "XP ${widget.experience}",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
