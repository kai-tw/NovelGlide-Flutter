import 'package:flutter/material.dart';

import 'widgets/collection_add_cancel_button.dart';
import 'widgets/collection_add_name_field.dart';
import 'widgets/collection_add_submit_button.dart';
import 'widgets/collection_add_title.dart';

class CollectionAddForm extends StatelessWidget {
  const CollectionAddForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Form(
      canPop: false,
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CollectionAddTitle(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: CollectionAddNameField(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CollectionAddCancelButton(),
                CollectionAddSubmitButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
