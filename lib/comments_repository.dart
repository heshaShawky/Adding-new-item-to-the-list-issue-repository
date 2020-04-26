import 'package:add_issue/models/comment_model.dart';
import 'dart:async';

class CommentsRepository {

  Future<List<Comment>> getAllComments() async {
    List body = [{"id":2,"createdAt":"2020-04-22T20:38:55.665Z","content":"خلافاَ للإعتقاد السائد فإن لوريم إيبسوم ليس نصاَ عشوائياً، بل إن له جذور في الأدب اللاتيني الكلاسيكي منذ العام 45 قبل الميلاد، مما يجعله أكثر من 2000 عام في القدم. قام البروفيسور \"ريتشارد ماك لينتوك\" (Richard McClintock) وهو بروفيسور اللغة اللاتينية في جامعة هامبدن-سيدني في فيرجينيا بالبحث عن أصول كلمة لاتينية غامضة في نص لوريم إيبسوم وهي \"consectetur\"، وخلال تتبعه لهذه الكلمة في الأدب اللاتيني اكتشف المصدر الغير قابل للشك. فلقد اتضح أن كلمات نص لوريم إيبسوم تأتي من الأقسام 1.10.32 و 1.10.33 من كتاب \"حول أقاصي الخير والشر\" (de Finibus Bonorum et Malorum) للمفكر شيشيرون (Cicero) والذي كتبه في عام 45 قبل الميلاد. هذا الكتاب هو بمثابة مقالة علمية مطولة في نظرية الأخلاق، وكان له شعبية كبيرة في عصر النهضة. السطر الأول من لوريم إيبسوم \"Lorem ipsum dolor sit amet..\" يأتي من سطر في القسم 1.20.32 من هذا الكتاب.","user":{"id":1,"email":null,"registedAt":"2020-04-18T20:27:40.983Z","username":"hesham","role":"admin","image":null,}},{"id":1,"createdAt":"2020-04-22T20:31:13.561Z","content":"This comment has been updated to this.","user":{"id":1,"email":null,"registedAt":"2020-04-18T20:27:40.983Z","username":"hesham","role":"admin","image":null}}];

    final List<Comment> comments = body.map( (comment) => Comment.fromJson(comment) ).toList();

    return Future.delayed(Duration(seconds: 2), () => comments);
  }
}