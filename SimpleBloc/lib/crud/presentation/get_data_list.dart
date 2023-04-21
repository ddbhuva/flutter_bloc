import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/crud_api_bloc.dart';
import '../model/get_data_model.dart';

class GetDataList extends StatefulWidget {
  GetDataList({Key? key}) : super(key: key);
  static const id = 'get_data_list_screen';


  @override
  State<GetDataList> createState() => _GetDataListState();
}

class _GetDataListState extends State<GetDataList> {

  @override
  void initState() {
    getApi();
    super.initState();
  }

  getApi(){
    BlocProvider.of<CrudApiBloc>(context).apiUrl = "/users/";
    BlocProvider.of<CrudApiBloc>(context).add(GetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Get Data List'),),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: BlocConsumer<CrudApiBloc, CrudApiState>(
          listener: (context, state) {
            if (state is CrudSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Api get successfully')));
            }

            if (state is CrudErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(
                    state.error, style: TextStyle(color: Colors.white),)));
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

                if (state is CrudGetListState) {
                  return Container(
                    child: ListView.separated(itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: [
                            _dataList('Email:', state.getDataList[index].email),
                            // _dataList('Email:', getDataList[index].email),
                            _dataList(
                                'First name:', state.getDataList[index].firstName),
                            _dataList('Last name:', state.getDataList[index].lastName),
                          ],
                        ),
                      );
                    }, separatorBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: const Divider(color: Colors.grey,
                            height: 2,
                            thickness: 2,));
                    }, itemCount: state.getDataList.length),
                  );
                }

                return Container();
              },
            );
          },
        ),
      ),
    );
  }

  Widget _dataList(String title, String val) {
    return Container(
      child: Row(
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(width: 10,),
          Text(val)
        ],
      ),
    );
  }
}
