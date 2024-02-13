import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:green_today/domain/time.dart';

class SettingDialog extends StatefulWidget {
  const SettingDialog({Key? key}) : super(key: key);

  @override
  State<SettingDialog> createState() => _SettingDialogState();
}

class _SettingDialogState extends State<SettingDialog> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final googleSinIn = GoogleSignIn(
      clientId: '436085979280-t9n5r1u2vdg2nf3adnmbecuk5kp98tv'
    );
    final GoogleSignInAccount? googleUser = await googleSinIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    //Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  SimpleTime planningTime = SimpleTime(0, 0);
  SimpleTime diaryTime = SimpleTime(0, 0);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 30,
          ),
          StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (!snapshot.hasData) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: signInWithGoogle,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        FontAwesomeIcons.google,
                        color: Colors.green,
                      ),
                      Container(
                        width: 20,
                      ),
                      const Text(
                        "Sign in with Google",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${snapshot.data?.displayName}님 환영합니다.",
                        style: const TextStyle(fontSize: 25),
                      ),
                      TextButton(
                        onPressed: FirebaseAuth.instance.signOut,
                        child: const Text(
                          "logout",
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Text(
                  "  Planning Alarm     ",
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                  child: DropdownButtonFormField(
                    value: planningTime.hour,
                    items: List.generate(24, (i) {
                      if (i < 10) {
                        return DropdownMenuItem(value: i, child: Text('0$i'));
                      }
                      return DropdownMenuItem(value: i, child: Text('$i'));
                    }),
                    onChanged: (int? value) {
                      setState(() {
                        planningTime.hour = value!;

                      });
                    },
                  ),
                ),
                const Text(
                  " : ",
                  style: TextStyle(fontSize: 35),
                ),
                Expanded(
                  child: DropdownButtonFormField(
                    value: planningTime.minute,
                    items: List.generate(60, (i) {
                      if (i < 10) {
                        return DropdownMenuItem(value: i, child: Text('0$i'));
                      }
                      return DropdownMenuItem(value: i, child: Text('$i'));
                    }),
                    onChanged: (int? value) {
                      setState(() {
                        planningTime.minute = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Text(
                  "      Diary Alarm       ",
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                  child: DropdownButtonFormField(
                    value: diaryTime.hour,
                    items: List.generate(24, (i) {
                      if (i < 10) {
                        return DropdownMenuItem(value: i, child: Text('0$i'));
                      }
                      return DropdownMenuItem(value: i, child: Text('$i'));
                    }),
                    onChanged: (int? value) {
                      setState(() {
                        diaryTime.hour = value!;
                      });
                    },
                  ),
                ),
                const Text(
                  " : ",
                  style: TextStyle(fontSize: 35),
                ),
                Expanded(
                  child: DropdownButtonFormField(
                    value: diaryTime.minute,
                    items: List.generate(60, (i) {
                      if (i < 10) {
                        return DropdownMenuItem(value: i, child: Text('0$i'));
                      }
                      return DropdownMenuItem(value: i, child: Text('$i'));
                    }),
                    onChanged: (int? value) {
                      setState(() {
                        diaryTime.minute = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
