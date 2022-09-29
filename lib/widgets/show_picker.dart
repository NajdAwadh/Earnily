import 'package:flutter/material.dart';

@override
  void showPicker(context,
  {required VoidCallback onGalleryTap,
  required VoidCallback onCameraTap
  }
  ) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: Text('Gallery'),
                      onTap: onGalleryTap),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: onCameraTap
                  ),
                ],
              ),
            ),
          );
        });
  }