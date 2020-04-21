import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maid/auth/auth.dart';

class HomePage extends StatelessWidget {
  final AuthService userRepository;

   HomePage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => new Scaffold(
    appBar: new AppBar(
      title: new Text('Maid Cafe'),
    ),
    drawer: Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.red,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              userRepository.logout().then(
                  (_) => {
                    BlocProvider.of<AuthBloc>(context).add(LoggedOut())
                  }
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/new_order');
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.red,
    ),
    body: new Container(
      alignment: Alignment.center,
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(100, (index) {
          return new GestureDetector(
            onTap: (){
              print("Container clicked");
            },
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: Color(0xFFFFCCBC)),
                  left: BorderSide(width: 1.0, color: Color(0xFFFFCCBC)),
                  right: BorderSide(width: 1.0, color: Color(0xFFFFCCBC)),
                  bottom: BorderSide(width: 1.0, color: Color(0xFFFFCCBC)),
                ),
                color: Color(0xFFFBE9E7),
              ),
              child: Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image(image: AssetImage('images/table-icon.png'), width: 75, height: 75),
                    Text(
                      'Mesa $index',
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ]
                ),
              ),
            )
          );
        }),
      ),
    ),
  );
}