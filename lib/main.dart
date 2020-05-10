import 'dart:async';

import 'package:add_issue/comments_bloc/comments_bloc.dart';
import 'package:add_issue/comments_repository.dart';
import 'package:add_issue/user_bloc/user_bloc.dart';
import 'package:add_issue/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication/authentication_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: CommentsBloc(CommentsRepository()),
        ),
        BlocProvider.value(
          value: UserBloc(
              userRepository: UserRepository(),
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationUnauthenticated) {
              return LoginPage();
            }

            return HomePage();
          },
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<void> _completer;

  @override
  void initState() {
    _completer = Completer();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<CommentsBloc>(context)..add(FetchComments());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test App'),
      ),
      body: BlocConsumer<CommentsBloc, CommentsState>(
        listener: (context, state) {
          if (state is CommentsLoaded) {
            _completer?.complete();
            _completer = Completer();
          }
        },
        builder: (context, state) {
          if (state is CommentsInitial || state is CommentsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CommentsLoaded) {
            return RefreshIndicator(
              onRefresh: () {
                BlocProvider.of<CommentsBloc>(context).add(RefreshComments());

                return _completer.future;
              },
              child: ListView(
                children: <Widget>[
                  ...state.comments.map((comment) {
                    return ListTile(
                      leading: CircleAvatar(),
                      title: Text(comment.body),
                    );
                  }),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            BlocProvider.of<CommentsBloc>(context)
                .add(AddComment('The New Comment I wanna add'));
          }),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController;
  TextEditingController _passwordController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginButtonPressed(context) {
    BlocProvider.of<UserBloc>(context).add(
      UserLoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'username'),
                    controller: _usernameController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'password'),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  RaisedButton(
                    onPressed: () => state is! UserLoginLoading
                        ? _onLoginButtonPressed(context)
                        : null,
                    child: Text('Login'),
                  ),
                  Container(
                    child: state is UserLoginLoading
                        ? CircularProgressIndicator()
                        : null,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
