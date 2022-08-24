import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/const/global.const.dart';
import '../../toast.dart';
import '../modal_sheet.dart';
import '../text_field.dart';

class CarSheet extends StatefulWidget {
  const CarSheet({Key? key}) : super(key: key);

  @override
  State<CarSheet> createState() => _CarSheetState();
}

class _CarSheetState extends State<CarSheet> {
  bool _loading = false;
  late TextEditingController _modelController,
      _colorController,
      _numberController,
      _nameController;
  @override
  void initState() {
    _colorController = TextEditingController();
    _modelController = TextEditingController();
    _numberController = TextEditingController();
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _colorController.dispose();
    _modelController.dispose();
    _numberController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalSheetBody(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          const Text('Car details'),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _nameController,
            hint: 'Model',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _numberController,
            hint: 'Number',
            inputFormatters: <TextInputFormatter>[
              // avoid whitespcaes
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
            ],
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _modelController,
            hint: 'Brand',
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _colorController,
            hint: 'Color',
          ),
          const SizedBox(height: 20),
          _loading
              ? const CircularProgressIndicator.adaptive()
              : TextButton(
                  onPressed: () async {
                    try {
                      setState(() => _loading = true);
                      await db.putCarData(
                        model: _modelController.text,
                        color: _colorController.text,
                        number: _numberController.text,
                        name: _nameController.text,
                      );
                    } on Exception catch (e) {
                      showToast(e.toString(), context, isError: true);
                    }
                    setState(() => _loading = false);
                    Navigator.pop(context);
                    showToast('Added successfully', context);
                  },
                  child: const Text('Save'),
                ),
        ],
      ),
    );
  }
}
