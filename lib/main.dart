import 'package:add_issue/comments_bloc/comments_bloc.dart';
import 'package:add_issue/comments_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: CommentsBloc(CommentsRepository()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


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
      body: BlocBuilder<CommentsBloc, CommentsState>(
        builder: (context, state) {
          if ( state is CommentsInitial || state is CommentsLoading ) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if ( state is CommentsLoaded ) {
            return ListView(
              children: <Widget>[
                ...state.comments.map((comment) { 
                  return ListTile(
                    leading: CircleAvatar(),
                    title: Text(comment.content),
                  );
                }),
                RaisedButton(
                  child: Text('Add Comment'),
                  onPressed: () {
                    BlocProvider.of<CommentsBloc>(context).add(AddComment('The New Comment I wanna add'));
                  }
                )
              ],
            );
          }
        },
      ),
    );
  }
}

