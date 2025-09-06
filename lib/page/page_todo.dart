// ignore_for_file: prefer_const_Constructors, prefer_final_fields, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:my_vlog/page/page_todoTitle.dart';
import 'package:my_vlog/until/page_dialog.dart';
import 'package:my_vlog/until/database_helper.dart';

class PageTodo extends StatefulWidget {
  const PageTodo({super.key});

  @override
  State<PageTodo> createState() => _PageTodoState();
}

class _PageTodoState extends State<PageTodo> {

  // 接收輸入框返回的值
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _contentController = TextEditingController(); // 新增內容控制器
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> todoList = [];
  List<Map<String, dynamic>> filteredList = [];

  // 初始化(State創建時會自動調用)，overrode重寫屬性標識（父類）
  @override
  void initState() {
    // 調用父類的initState方法，確保父類的初始化邏輯也被執行
    super.initState();
    
    loadTodos();
    _searchController.addListener(_onSearchChanged);
  }

  // 加載數據庫中的待辦事項
  void loadTodos() async {
    todoList = await DatabaseHelper().getTodos();
    filteredList = todoList;
    setState(() {});
  }

  // 搜索框內容變化時過濾待辦事項
  void _onSearchChanged() {
    String query = _searchController.text.trim();
    if (query.isEmpty) {
      filteredList = todoList;
    } else {
      filteredList = todoList.where((item) => item['title'].toString().contains(query)).toList();
    }
    setState(() {});
  }

  // 複選框點擊事件（可擴展為更新數據庫）
    void CheckChange(index) async {
      int id = todoList[index]['id'];
      bool currentDone = todoList[index]['done'] == 1;
      await DatabaseHelper().updateTodoDone(id, !currentDone);
      loadTodos();
  }

  // 添加待辦事項（插入數據庫）
  void AddTask() async {
    await DatabaseHelper().insertTodo({
      'title': _controller.text,
      'content': _contentController.text, // 使用內容控制器
    });
    _controller.clear();
    _contentController.clear(); // 清空內容輸入框
    Navigator.of(context).pop();
    loadTodos();
    _onSearchChanged();
  }

  // 創建待辦事項彈框
  void createNewTask()
  {
    showDialog(
      context: context, 
      builder: (t){
        return DialogBox(
          controllerText: _controller,
          controllerContent: _contentController, // 傳遞內容控制器
          ok: AddTask,
          quit: () => Navigator.of(context).pop(),
        );
      });
  }

  // 刪除待辦（刪除數據庫記錄）
  void deleteTask(int id) async {
    await DatabaseHelper().deleteTodo(id);
    loadTodos();
    _onSearchChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Center(
          child: Text("To Do"),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => _onSearchChanged(),
              decoration: InputDecoration(
                hintText: '搜索待辦事項...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                Widget todoWidget = Todotitle(
                  taskName: filteredList[index]['title'],
                  taskCheck: filteredList[index]['done'] == 1,
                  onchanged: (value) => CheckChange(index),
                  deleteFunction: (context) => deleteTask(filteredList[index]['id']),
                );
                if (index == filteredList.length - 1) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: todoWidget,
                  );
                }
                return todoWidget;
              },
            ),
          ),
        ],
      ),
    );
  }
}
