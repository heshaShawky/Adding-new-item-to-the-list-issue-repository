import 'dart:convert';

import 'package:add_issue/models/comment_model.dart';
import 'dart:async';
import 'package:http/http.dart' as client;

class CommentsRepository {

  Future<List<Comment>> getAllComments() async {

    client.Response response = await client.get('https://jsonplaceholder.typicode.com/comments');

    List body = jsonDecode(response.body);

    final List<Comment> comments = body.map( (comment) => Comment.fromJson(comment) ).toList();

    return comments;
  }
}