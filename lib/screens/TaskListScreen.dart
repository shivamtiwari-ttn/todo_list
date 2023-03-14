import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/cubit/todo_cubit.dart';



class TaskListScreen extends StatefulWidget {
  // const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {

  List<Widget> taskList = [];

  TextEditingController _controller = TextEditingController();

  void addTaskToList(String text){
    setState(() {
      taskList.add(TaskListTile(text));
    });
  }

  @override
  Widget build(BuildContext context) {

    String newTask = "";

    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          SizedBox(
            height: 100,
            width: 400,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextField(
                controller: _controller,
                onChanged: (text){
                  newTask = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a task',
                ),
              ),
            ),
          ),
          TextButton(
              child: Text(
                  "Add Task".toUpperCase(),
                  style: TextStyle(fontSize: 14)
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.red)
                      )
                  )
              ),
              onPressed: () {
                print(newTask);
                if (newTask != ''){
                  setState(() {
                    addTaskToList(newTask);
                    _controller.clear();
                  });
                  BlocProvider.of<TODOCubit>(context).addTaskCount();
                }
              },
          ),
          SizedBox(height: 20),

          BlocBuilder<TODOCubit, TODOCountState>(
            builder: (context, state){
              return Text(
                  'Total Pending Task(s): ${state.taskCount}',
                style: TextStyle(fontWeight: FontWeight.bold),
              );
            },
          ),
          SizedBox(height: 20),
          Expanded(
              child: Container(
                height: 500,
                margin: EdgeInsets.only(top: 40),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))
                ),
                child: ListView(
                  children: taskList,
                ),
              ),
          ),



        ],
      ),
    );
  }
}

class TaskListTile extends StatefulWidget {
  // const TaskListTile({Key? key}) : super(key: key);

  final String taskTitle;

  TaskListTile(this.taskTitle);

  @override
  State<TaskListTile> createState() => _TaskListTileState();

}

class _TaskListTileState extends State<TaskListTile> {

  bool isChecked = false;



  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.taskTitle,
        style: TextStyle(decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: ListCheckBox(isChecked, (newValue){

        if (isChecked){
          BlocProvider.of<TODOCubit>(context).addTaskCount();
        }else{
          BlocProvider.of<TODOCubit>(context).subTaskCount();
        }

        setState(() {
          isChecked = newValue ?? false;
        });
      }),
    );
  }
}

class ListCheckBox extends StatelessWidget {
  final bool checkBoxChecked;
  // final Function handleCheckboxClick<bool?>?;
  final ValueChanged<bool?>? onChanged;


  ListCheckBox(this.checkBoxChecked, this.onChanged);

  @override
  Widget build(BuildContext context) {
      return Checkbox(
        value: checkBoxChecked,
        activeColor: Colors.teal,
        onChanged: onChanged,
    );
  }
}


