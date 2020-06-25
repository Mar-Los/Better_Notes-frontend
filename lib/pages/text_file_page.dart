import 'package:cloud_note_app/controllers/text_file_controller.dart';
import 'package:cloud_note_app/helper_widgets/connection_sensitive.dart';
import 'package:cloud_note_app/helper_widgets/custom_bottom_app_bar.dart';
import 'package:cloud_note_app/utils/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_note_app/custom_color_scheme.dart';

class TextFilePage extends StatefulWidget {
  final Map textFile;
  TextFilePage({Key key, @required this.textFile}) : super(key: key);

  @override
  _TextFilePageState createState() => _TextFilePageState();
}

class _TextFilePageState extends State<TextFilePage> {
  final TextFileController _textFileController = TextFileController();
  final TextEditingController _textController = TextEditingController();
  bool isEdited = false;
  Map textFile;

  @override
  void didChangeDependencies() {
    textFile = widget.textFile;
    super.didChangeDependencies();
  }

  void _submit() async {
    String text = _textController.text;
    String jwt = Provider.of<UserModel>(context, listen: false).jwt;

    Map response = await _textFileController.updateTextFileContent(
        jwt, widget.textFile['id'], text);
    setState(() {
      textFile['content'] = response['content'];
    });
  }

  @override
  Widget build(BuildContext context) {
    _textController.text = textFile['content'];

    final isKeyboard = MediaQuery.of(context).viewInsets.bottom > 0;

    return ConnectionSensitive(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.description,
                size: 18.0,
              ),
              SizedBox(width: 7.0),
              Text(textFile['name'])
            ],
          ),
          centerTitle: true,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: isEdited
                      ? TextField(
                          autofocus: true,
                          controller: _textController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        )
                      : Text(textFile['content'],
                          style: TextStyle(fontSize: 15.0))),
            ),
            if (isEdited)
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: FloatingActionButton(
                  heroTag: 'cancelBtn',
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.myLightGrey,
                  ),
                  onPressed: () {
                    setState(() {
                      isEdited = false;
                    });
                  },
                ),
              ),
          ],
        ),
        bottomNavigationBar: CustomBottomAppBar(),
        floatingActionButton: FloatingActionButton(
          heroTag: 'doneOrEditBtn',
          child: isEdited ? Icon(Icons.done) : Icon(Icons.edit),
          onPressed: () {
            if (isEdited) _submit();
            setState(() {
              isEdited = !isEdited;
            });
          },
        ),
        floatingActionButtonLocation: isKeyboard
            ? FloatingActionButtonLocation.centerFloat
            : FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
