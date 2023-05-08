import 'dart:io';
import 'dart:typed_data';

import 'package:etaxi_mobile/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<XFile> _images = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        XFile? image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image != null)
                          setState(() {
                            _images.add(image);
                            //proba
                          });
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
                    ..._images.map(
                      (e) => FutureBuilder<Uint8List>(
                          future: e.readAsBytes(),
                          builder: (context, snapshot) {
                            if (snapshot.data != null)
                              return Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.memory(snapshot.data!)
                                            .image)),
                              );

                            return SizedBox();
                          }),
                    )
                  ],
                ),
                sh(20),
                MaterialButton(
                  height: 40,
                  minWidth: double.infinity,
                  color: Colors.black,
                  onPressed: () {},
                  child: Text(
                    'Sacuvaj'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
