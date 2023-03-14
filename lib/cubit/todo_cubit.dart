import 'package:bloc/bloc.dart';

part 'todo_state.dart';

class TODOCubit extends Cubit<TODOCountState>{
  TODOCubit() : super(TODOCountState(taskCount: 0));

  void addTaskCount() => emit(TODOCountState(taskCount: state.taskCount + 1));
  void subTaskCount() => emit(TODOCountState(taskCount: state.taskCount - 1));



}