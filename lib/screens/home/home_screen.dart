import 'package:chat/screens/add_room/add_room.dart';
import 'package:chat/screens/base/base_state.dart';
import 'package:chat/screens/home/home_navigator.dart';
import 'package:chat/screens/home/home_view_model.dart';
import 'package:chat/screens/home/room_widget.dart';
import 'package:chat/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/database_utils.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "Home Page";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  HomeViewModel initViewModel() => HomeViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.baseNavigator = this;
    viewModel.getRooms();
  }

  @override
  build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        DataBaseUtils.getRoomsFromFirestore();
        viewModel.rooms;
        viewModel.getRooms();
        setState(() {});
      },
      child: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                'assets/img/signin.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddRoom.routeName);
                },
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: const Text("Home"),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Settings.RouteName);
                      },
                      icon: Icon(Icons.settings))
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(child: Consumer<HomeViewModel>(
                      builder: (context, homevalue, child) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 4 / 3),
                          itemBuilder: (context, index) {
                            return RoomWidget(homevalue.rooms[index]);
                          },
                          itemCount: homevalue.rooms.length,
                        );
                      },
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
