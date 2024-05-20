import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:src/helper/globalVariables.dart';
import 'package:src/pages/profile/profile_widget.dart';

import 'button_widget.dart';
import 'edit_field_widget.dart';



class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileState();
}


class _EditProfileState extends State<EditProfileScreen> {

  final currentUser = FirebaseAuth.instance.currentUser!;


  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      final userDataSnapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(currentUser.uid)
          .get();

      if (userDataSnapshot.exists) {
        final userData = userDataSnapshot.data() as Map<String, dynamic>;
        setState(() {
          nameController.text = userData['Name'] ?? '';
          emailController.text = userData['Email'] ?? '';
        });
      } else {
        // Caso o documento do usuário não exista no Firestore
        // Você pode tratar isso aqui, por exemplo, redirecionando o usuário para a tela de login
      }
    } catch (e) {
      // Lidar com erros, como falta de conexão com a internet
      print('Error getting user data: $e');
    }
  }

  Future<void> updatePassword(String oldPassword, String newPassword, String confirmPassword) async {
    try {
      // Verificar se a nova senha é igual à confirmação da senha
      if (newPassword != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('A nova senha e a confirmação da senha não coincidem.'),
          duration: Duration(seconds: 2),
        ));
        return;
      }

      // Autenticar o usuário com a senha antiga
      final credential = EmailAuthProvider.credential(email: currentUser.email!, password: oldPassword);
      try {
        await currentUser.reauthenticateWithCredential(credential);
      } catch (e) {
        // Se a reautenticação falhar, isso significa que a senha antiga fornecida está incorreta
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('A senha antiga está incorreta.'),
          duration: Duration(seconds: 2),
        ));
        return;
      }

      // Atualizar a senha do usuário
      await currentUser.updatePassword(newPassword);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Senha atualizada com sucesso!'),
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('A senha deve ter no minimo 6 caracteres.'),
        duration: Duration(seconds: 2),
      ));
    }
  }


  Future<void> updateUserInformation(String newValue) async {
    try {
        //await currentUser.updateDisplayName(newValue);
        await FirebaseFirestore.instance
            .collection('User')
            .doc(currentUser.uid)
            .update({'Name': newValue});
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Name updated successfully!'),
          duration: Duration(seconds: 2),
        ));

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to update. Please try again later.'),
        duration: Duration(seconds: 2),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: const BackButton(),
        title: Text("Editar Perfil", style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('User').doc(currentUser.uid).snapshots(),
    builder: (context, snapshot) {
          if (snapshot.hasData){
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        ProfileWidget(
                          imagePath: userData['ImagePath'],
                          onClicked: () async {},
                          showIcon: true,
                        ),
                        const SizedBox(height: 20),
                        Form(
                            child: Column(
                              children: [
                                const SizedBox(height: 15),
                                EditableNameField(
                                  labelText: 'Nome',
                                  initialValue: userData['Name'], // Valor inicial do campo
                                  onEditPressed: () {
                                    String newName = nameController.text.trim();
                                    if (newName.isNotEmpty ) {
                                      updateUserInformation(newName);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        content: Text('Por favor inserir um email valido.'),
                                        duration: Duration(seconds: 2),
                                      ));
                                    }
                                  },
                                  prefIcon: FontAwesomeIcons.user,
                                  bottonText: 'Editar Nome',
                                  controller: nameController,
                                ),

                                const SizedBox(height: 30),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey), // Adiciona uma borda cinza
                                    borderRadius: BorderRadius.circular(15), // Borda arredondada
                                  ),
                                  child: Row(
                                    children: [
                                      // Ícone do email à esquerda
                                      const Icon(
                                        FontAwesomeIcons.envelope,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 15), // Espaçamento entre o ícone e o texto
                                      // Texto do email do usuário
                                      Text(
                                        userData['Email'], // Email do usuário
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],

                                  ),
                                ),

                                const Divider(height: 80, thickness: 5, color: primaryColor,),

                                EditableNameField(
                                  labelText: 'Antiga palavra-passe...',
                                  onEditPressed: () {},
                                  prefIcon: FontAwesomeIcons.fingerprint,
                                  showSuffixButton: false,
                                  sufixIcon: FontAwesomeIcons.eye,
                                  watch: true,
                                  controller: oldPasswordController,
                                ),

                                const SizedBox(height: 30),

                                EditableNameField(
                                  labelText: 'Nova palavra_passe...',
                                  onEditPressed: () {},
                                  prefIcon: FontAwesomeIcons.fingerprint,
                                  showSuffixButton: false,
                                  sufixIcon: FontAwesomeIcons.eye,
                                  watch: true,
                                  controller: newPasswordController,
                                ),

                                const SizedBox(height: 30),

                                EditableNameField(
                                  labelText: 'Confirmar nova palavra-passe...',
                                  onEditPressed: () {},
                                  prefIcon: FontAwesomeIcons.fingerprint,
                                  showSuffixButton: false,
                                  sufixIcon: FontAwesomeIcons.eye,
                                  watch: true,
                                  controller: confirmPasswordController,
                                ),

                                const SizedBox(height: 10),
                                ButtonWidget(
                                  text: 'Alterar',
                                  onClicked: () {
                                    String oldPassword = oldPasswordController.text.trim();
                                    String newPassword = newPasswordController.text.trim();
                                    String confirmPassword = confirmPasswordController.text.trim();

                                    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        content: Text('Por favor, preencha todos os campos.'),
                                        duration: Duration(seconds: 2),
                                      ));
                                      return;
                                    }

                                    updatePassword(oldPassword, newPassword, confirmPassword);
                                  },
                                  padH: 60,
                                ),
                              ],
                            ),
                        )
                      ],
                    ),
                  ),

              );
          }
          else if(snapshot.hasError){
              return Center(child: Text('Error${snapshot.error}'),);
          }
          else{
            return const Center(child: CircularProgressIndicator(),);
          }

    },

      ),
    );
  }
}
