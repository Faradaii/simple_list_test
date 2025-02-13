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

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        final currentState = context
            .read<SharedBloc>()
            .state;
        if (currentState is SharedLoaded && currentState.page != null) {
          _loadUsers();
        }
      }
    });
    _loadUsers();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void _loadUsers({bool forceRefresh = false}) {
    try {
      context
          .read<SharedBloc>()
          .add(SharedLoadUsersEvent(forceRefresh: forceRefresh));
    } catch (e) {
      debugPrint("Error loading users: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Third Screen"),
      body: SafeArea(
        child: BlocBuilder<SharedBloc, SharedState>(
          builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  _loadUsers(forceRefresh: true);
                },
                child: (state is SharedLoaded) ?
                ((state.message != "") ?
                    Center(child: Text(state.message))
                    : (!state.isFetchingUser) ?
                      _buildListUser(context, state.users)
                      :
                        Center(child: CircularProgressIndicator())) : Center(child: CircularProgressIndicator())
              );
              return Center(child: CircularProgressIndicator());
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
              child:
              Text("Empty", style: TextStyle(color: Colors.black)));
        }

        final UserEntity user = listUser[index];
        return InkWell(
          onTap: () {
            context.read<SharedBloc>().add(
                SharedSelectedUserChangedEvent(
                    user: "${user.firstName} ${user.lastName}"));
                Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 16),
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
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium),
                      SizedBox(
                        height: 4,
                      ),
                      Text(user.email,
                          style: TextStyle(color: Colors.black)),
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
