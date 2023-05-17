import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:etaxi_mobile/models/user_model.dart';
import 'package:etaxi_mobile/providers/auth_provider.dart';
import 'package:etaxi_mobile/services/user_services.dart';
import 'package:etaxi_mobile/utils/sizeConfig.dart';
import 'package:etaxi_mobile/utils/utilFunctions.dart';
import 'package:etaxi_mobile/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> _imagePaths = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    getUserProfile();

    super.initState();
  }

  void getUserProfile() async {
    var userDecoded =
        await UserServices.getUser(AuthProvider.instance.user!.id!);
    var user = Userinfo.fromJson(userDecoded);
    //AuthProvider.instance.setUser(Userinfo.fromJson(userDecoded));
    var userFiles = user.files;
    if (userFiles != null && userFiles.isNotEmpty) {
      var newImagePaths = <String>[];
      userFiles.forEach((file) {
        newImagePaths.add(formatFileUrl(file.url));
      });
      setState(() {
        _imagePaths = newImagePaths;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    inspect(_imagePaths);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 22,
              horizontal: 20,
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
            ),
          ),
        ),
        title: Text(
          "Profil",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sh(20),
                Text('Ime i prezime'),
                sh(10),
                TextField(
                  controller: _nameController,
                ),
                sh(20),
                Text('Adresa'),
                sh(10),
                TextField(
                  controller: _addressController,
                ),
                sh(20),
                Text('Email'),
                sh(10),
                TextField(
                  controller: _emailController,
                ),
                sh(20),
                Text('Broj telefona'),
                sh(10),
                TextField(
                  controller: _phoneController,
                ),
                sh(20),
                Text('Dokumenti'),
                sh(10),
                Wrap(
                  runSpacing: 8,
                  spacing: 8,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        final imageSource = await showDialog<ImageSource>(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Odaberi izvor slike"),
                                  actions: <Widget>[
                                    CustomButton(
                                      label: "Kamera",
                                      onPressed: () => Navigator.pop(
                                          context, ImageSource.camera),
                                    ),
                                    sh(10),
                                    CustomButton(
                                      label: "Galerija",
                                      onPressed: () => Navigator.pop(
                                          context, ImageSource.gallery),
                                    )
                                  ],
                                ));
                        if (imageSource != null) {
                          XFile? file = await ImagePicker()
                              .pickImage(source: imageSource);
                          if (file != null) {
                            setState(() => {
                                  _imagePaths.add(file.path),
                                });
                          }
                        }
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey.shade400)),
                        child: Center(
                          child: Icon(Icons.add_a_photo),
                        ),
                      ),
                    ),
                    ..._imagePaths.map((e) => Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: e.contains("http")
                                      ? Image.network(e).image
                                      : Image.file(File(e)).image)),
                        ))
                  ],
                ),
                sh(20),
                CustomButton(
                  label: 'Sacuvaj',
                  onPressed: () {
                    if (_imagePaths.isNotEmpty) {
                      UserServices.uploadUserFiles(_imagePaths);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
