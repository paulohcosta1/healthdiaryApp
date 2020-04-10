import 'package:flutter/material.dart';
import 'package:healthdiary/widgets/image_source_sheet.dart';

class ImagesWidget extends FormField<List> {
  ImagesWidget({
    BuildContext context,
    FormFieldSetter<List> onSaved,
    FormFieldValidator<List> validator,
    List initialValue,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (state) {
              return Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 400,
                      padding: EdgeInsets.only(
                        top: 32,
                      ),
                      child: state.value.length > 0
                          ? Container(
                              height: 350,
                              width: 350,
                              margin: EdgeInsets.only(
                                right: 8,
                              ),
                              child: GestureDetector(
                                child: Image.file(
                                  state.value[0],
                                  fit: BoxFit.cover,
                                ),
                                onLongPress: () {
                                  state.didChange(
                                    state.value..remove(state.value[0]),
                                  );
                                },
                              ),
                            )
                          : GestureDetector(
                              child: Container(
                                height: 350,
                                width: 350,
                                child: Icon(
                                  Icons.camera_enhance,
                                  color: Colors.white,
                                ),
                                color: Colors.black.withAlpha(50),
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => ImageSourceSheet(
                                    onImageSelected: (image) {
                                      state.didChange(
                                        state.value..add(image),
                                      );
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                  state.hasError
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              state.errorText,
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                        )
                      : Container()
                ],
              );
            });
}
