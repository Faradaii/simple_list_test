import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_list_test/domain/entities/user_entity.dart';
import 'package:simple_list_test/presentation/bloc/shared_bloc.dart';
import 'package:simple_list_test/presentation/widget/my_app_bar.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final ScrollController scrollController = ScrollController();
  int? page;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        _loadUsers();
      }
    });
    page = 1;
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void _loadUsers({bool forceRefresh = false}) {
    if (page != 0) {
      context
          .read<SharedBloc>()
          .add(SharedLoadUsersEvent(forceRefresh: forceRefresh));
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Third Screen",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: BlocConsumer<SharedBloc, SharedState>(
          listener: (context, state){
            if (state is SharedLoaded) {
              setState(() {
                page = state.page;
              });
            }
          },
          builder: (context, state) {
            return RefreshIndicator(
                onRefresh: () async {
                  _loadUsers(forceRefresh: true);
                },
                child: (state is SharedLoaded)
                    ? ((state.message != "")
                        ? Center(child: Text(state.message, style: TextStyle(color: Colors.black)))
                        : (!state.isLoading)
                            ? _buildListUser(context, state.users)
                            : Center(child: CircularProgressIndicator(color: Colors.black,)))
                    : Center(child: CircularProgressIndicator(color: Colors.black)));
          },
        ),
      ),
    );
  }

  Widget _buildListUser(context, List<UserEntity> listUser) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      controller: scrollController,
      itemCount: listUser.length,
      itemBuilder: (context, index) {
        if (listUser.isEmpty) {
          return Center(
              child: Text("Empty", style: TextStyle(color: Colors.black)));
        }

        final UserEntity user = listUser[index];
        return InkWell(
          onTap: () {
            context.read<SharedBloc>().add(SharedSelectedUserChangedEvent(
                user: "${user.firstName} ${user.lastName}"));
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                Row(children: [
                  ClipOval(
                      child: Image.network(
                    user.avatar,
                    width: 60,
                    height: 60,
                  )),
                  SizedBox(
                    width: 16,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.firstName + user.lastName,
                          style: Theme.of(context).textTheme.headlineMedium),
                      SizedBox(
                        height: 4,
                      ),
                      Text(user.email, style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ]),
              ],
            ),
          ),
        );
      },
    );
  }
}
