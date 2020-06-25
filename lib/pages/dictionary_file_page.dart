import 'package:cloud_note_app/controllers/dictionary_file_controller.dart';
import 'package:cloud_note_app/helper_widgets/connection_sensitive.dart';
import 'package:cloud_note_app/helper_widgets/custom_bottom_app_bar.dart';
import 'package:cloud_note_app/helper_widgets/dictionary_row/dictionary_row.dart';
import 'package:cloud_note_app/helper_widgets/dictionary_row/new_row.dart';
import 'package:cloud_note_app/utils/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_note_app/custom_color_scheme.dart';

class DictionaryFilePage extends StatefulWidget {
  final Map dictFile;
  DictionaryFilePage({Key key, @required this.dictFile}) : super(key: key);

  @override
  _DictionaryFilePageState createState() => _DictionaryFilePageState();
}

class _DictionaryFilePageState extends State<DictionaryFilePage> {
  DictionaryFileController _dictFileController;
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  Map dictFile;
  bool isCreatingRow = false;
  FocusNode newRowFocusNode;

  @override
  void didChangeDependencies() {
    dictFile = widget.dictFile;
    String jwt = Provider.of<UserModel>(context, listen: false).jwt;
    _dictFileController = DictionaryFileController(jwt);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    newRowFocusNode = FocusNode();
  }

  @override
  void dispose() {
    newRowFocusNode.dispose();
    super.dispose();
  }

  void _addRow() async {
    String key = _keyController.text;
    String value = _valueController.text;

    _keyController.text = '';
    _valueController.text = '';

    Map newRow =
        await _dictFileController.createRow(dictFile['id'], key, value);
    setState(() {
      dictFile['content'].add(newRow);
      isCreatingRow = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom > 0;

    return ConnectionSensitive(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.vpn_key,
                size: 18.0,
              ),
              SizedBox(width: 7.0),
              Text(dictFile['name'])
            ],
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dictFile['content'].length,
                  itemBuilder: (BuildContext context, int index) {
                    Map row = dictFile['content'][index];

                    return Column(
                      children: <Widget>[
                        DictionaryRow(
                          keyColumn: row['key'],
                          valueColumn: row['value'],
                          onUpdate: (keyColumn, valueColumn) async {
                            Map newRowFromDB = await _dictFileController
                                .updateRow(dictFile['id'], row['id'],
                                    key: keyColumn, value: valueColumn);
                            setState(() =>
                                dictFile['content'][index] = newRowFromDB);
                          },
                          onDelete: () async {
                            await _dictFileController.deleteRow(
                                dictFile['id'], row['id']);
                            setState(() => dictFile['content'].removeAt(index));
                          },
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.myLightGrey,
                          thickness: 0.6,
                        ),
                      ],
                    );
                  },
                ),
                NewRow(
                  keyController: _keyController,
                  valueController: _valueController,
                  keyFieldFocusNode: newRowFocusNode,
                  onChanged: () {
                    (_keyController.text == '' || _valueController.text == '')
                        ? setState(() => isCreatingRow = false)
                        : setState(() => isCreatingRow = true);
                  },
                ),
                Divider(
                  color: Theme.of(context).colorScheme.myLightGrey,
                  thickness: 0.6,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: isCreatingRow ? Icon(Icons.done) : Icon(Icons.add),
          onPressed: () {
            isCreatingRow ? _addRow() : newRowFocusNode.requestFocus();
          },
        ),
        floatingActionButtonLocation: isKeyboard
            ? FloatingActionButtonLocation.centerFloat
            : FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustomBottomAppBar(),
      ),
    );
  }
}
