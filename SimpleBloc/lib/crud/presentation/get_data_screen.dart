import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/general_path.dart';
import '../blocs/crud_api_bloc.dart';
import 'get_data_list.dart';

class GetDataScreen extends StatelessWidget {
   GetDataScreen({Key? key}) : super(key: key);
   // static const id = 'crud_screen';

  final TextEditingController _nameEditingController = TextEditingController();

  final TextEditingController _jobEditingController = TextEditingController();

  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

   _showSimpleDialog(BuildContext context, bool isPost) async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Form(
            key: formKey,
            child: SimpleDialog( // <-- SEE HERE
              title: const Text('Add data'),
              contentPadding: EdgeInsets.all(10),
              children: <Widget>[
                TextFormField(
                  controller: _nameEditingController,
                  autofocus: true,
                  decoration: const InputDecoration(
                      label: Text('Name'),
                      border: OutlineInputBorder()
                  ),
                  validator: (value){
                    if(value?.isEmpty == true){
                      return "Please enter name";
                    }
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _jobEditingController,
                  autofocus: true,
                  decoration: const InputDecoration(
                      label: Text('Job'),
                      border: OutlineInputBorder()
                  ),
                  validator: (value){
                    if(value?.isEmpty == true){
                      return "Please enter job";
                    }
                  },
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                    ElevatedButton(onPressed: (){
                      final params = {
                        "name": _nameEditingController.text,
                        "job": _jobEditingController.text,
                      };
                      debugPrint('Params: $params');
                      if(formKey.currentState?.validate() == true) {
                        formKey.currentState?.save();
                        BlocProvider
                            .of<CrudApiBloc>(context)
                            .reqParams = "$params";
                        if (isPost == true) {
                          BlocProvider
                              .of<CrudApiBloc>(context)
                              .apiUrl = "/users";
                          BlocProvider.of<CrudApiBloc>(context).add(PostEvent(
                              object: params));
                        } else {
                          BlocProvider
                              .of<CrudApiBloc>(context)
                              .apiUrl = "/users/1";
                          BlocProvider.of<CrudApiBloc>(context).add(UpdateEvent(
                              object: params));
                        }
                        Navigator.pop(context);
                      }
                    }, child: Text(isPost ? 'Add' : "Update")),
                  ],
                ),
                SizedBox(height: 50,)
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crud using Api'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: BlocConsumer<CrudApiBloc, CrudApiState>(
          listener: (context, state) {
            if (state is CrudSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Api posted successfully')));
            }

            if(state is CrudErrorState){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error, style: TextStyle(color: Colors.white),)));
            }

          },
          builder: (context, state) {
            return BlocBuilder<CrudApiBloc, CrudApiState>(
              builder: (context, state) {
                if (state is CrudApiLoading) {
                  return Center(child: const CircularProgressIndicator());
                }

                if (state is CrudErrorState) {
                  return Center(child:  Text('Problem While Loading'));
                }

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GetDataList(
                              )),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue),
                        child: const Center(
                            child: Text(
                          'Get Api Call',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showSimpleDialog(context, true);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue),
                        child: const Center(
                            child: Text(
                          'Post Request Api Call',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showSimpleDialog(context, false);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue),
                        child: Center(
                            child: Text(
                          'Update Api Call',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<CrudApiBloc>(context).apiUrl =
                            "/users/2";
                        BlocProvider.of<CrudApiBloc>(context)
                            .add(DeleteEvent());
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue),
                        child: const Center(
                            child: Text(
                          'Delete Api Call',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
