import 'package:fire_chat/Models/users.dart';
import 'package:fire_chat/auth.dart';
import 'package:fire_chat/block/user_chat_block.dart';
import 'package:fire_chat/constants.dart';
import 'package:fire_chat/sqlite/crud.dart';
import 'package:fire_chat/widgets/check_box_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    print('build register');
    bool isCheckedFrm = true;
    TextEditingController loginController = TextEditingController();
    loginController.text =
        context.read<DataCubitChat>().getUserEmail; // 'vasia@mail.ru';
    TextEditingController passController = TextEditingController();
    passController.text =
        context.read<DataCubitChat>().getPassword; //'7777pass999';

    TextEditingController displayNameController = TextEditingController();
    displayNameController.text = '';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Fire Chat',
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<DataCubitChat, KeeperChat>(builder: (context, state) {
        return

            // Center(
            //     child: Text(
            //   'Register',
            //   style: txt30,
            // )

            Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: loginController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid mail id as abc@gmail.com'),
                onChanged: (value) {
                  context.read<DataCubitChat>().setUserEmail(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: passController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your secure password'),
                onChanged: (value) {
                  context.read<DataCubitChat>().setPassword(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: displayNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'DisplayName',
                    hintText: 'Enter your display name'),
                onChanged: (value) {
                  context.read<DataCubitChat>().setDiasplayName(value);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 16,
                    height: 50,
                    child: ElevatedButton(
                      child: Text(
                        'Sign In',
                        style: txt20,
                      ),
                      onPressed: () async {
                        print(
                            'Login: ${loginController.text}, Password: ${passController.text}');
                        try {
                          Auth.registerEmailAndPassword(
                                  loginController.text,
                                  passController.text,
                                  displayNameController.text)
                              .then((value) {
                            if (value.email != loginController.text) {
                              print('Register Error');

                              // showDialog<bool>(
                              //   context: context,
                              //   builder: (BuildContext context) => AlertDialog(
                              //     title: const Text('Warning!'),
                              //     content: const Text(
                              //         'Login And Pass not correctly!'),
                              //     actions: <Widget>[
                              //       TextButton(
                              //         onPressed: () {
                              //           Navigator.pop(context, true);
                              //         },
                              //         child: const Text('OK'),
                              //       ),
                              //     ],
                              //   ),
                              // );
                            } else {
                              print(value);

                              // Users user = Users(value.email!,
                              //     passController.text, value.displayName!);

                              // context
                              //     .read<DataCubitChat>()
                              //     .setCurrentUser(user);
                              // Navigator.pushNamed(context, '/ChatForms');

                              // String loginValue = loginController.text;
                              // String passwordValue = passController.text;
                              // String rememberValue = isCheckedFrm ? 'T' : 'F';

                              // Crud.updParam('NameUser', loginValue);
                              // Crud.updParam('Password', passwordValue);
                              // Crud.updParam('Remember', rememberValue);
                            }
                          });
                        } catch (e) {
                          print(e);
                          showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Warning!'),
                              content: Text(e.toString()),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            CheckboxWidget(callback: (value) => isCheckedFrm = value),
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Text(
                'Sign In',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ),
          ],
          //    ),
        );
      }),
    );
  }
}
