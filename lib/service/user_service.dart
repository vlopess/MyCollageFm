// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_collage_fm/models/nostalgia_track.dart';
import 'package:my_collage_fm/models/user_dto.dart';
import 'package:my_collage_fm/service/prefs_service.dart';
import 'package:my_collage_fm/service/storage_service.dart';
import 'package:riverpod/riverpod.dart';

final userService = Provider(
  (ref) => UserService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    ref: ref
  )
);

class UserService {

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final ProviderRef ref;

  UserService({required this.auth, required this.firestore, required this.ref});

  Future<UserDTO?> getUser() async {
    var user =  auth.currentUser;
    var userData = await firestore.collection('users').where('email', isEqualTo: user!.email).get();
    if(userData.docs.isNotEmpty) return UserDTO.fromObject(userData.docs.first);
    return null;
  }

  Future<UserDTO?> getCurrentUser() async {
    var userDTO = await getUser();
    if(userDTO == null){
      var user =  auth.currentUser;
      String username = await SharedPreference.getUsername();
      userDTO = UserDTO(email: user!.email, name: username, nostalgiaTracks: []);
      saveUserData(userDTO);    
    }
    return userDTO;
  }

  Future<void> saveNostalgiaTrack(NostalgiaTrack nostalgiaTrackRegister) async {
    var userDTO = await getUser();

    if(userDTO != null){
      String uid = auth.currentUser!.uid;
      if(nostalgiaTrackRegister.image != null){
        String path = 'nostalgiaTracks/$uid/${nostalgiaTrackRegister.image?.path}';
        nostalgiaTrackRegister.path = path;
        nostalgiaTrackRegister.imageUrl = await ref.read(firebaseStorageRepository).storeFileToFirebase(path, nostalgiaTrackRegister.image!);
      }
      userDTO.nostalgiaTracks.add(nostalgiaTrackRegister);
      await firestore.collection('users').doc(uid).update({
        'nostalgiaTracks': userDTO.nostalgiaTracks.map((x) => x?.toMap()).toList(),
      });    
    }



  }
  void saveUserData(UserDTO user) async {
    String uid = auth.currentUser!.uid;
    await firestore.collection('users').doc(uid).set(user.toMap());
  }

  void logout() async {
    await auth.signOut();
  }

  Future<User?> loginGoogle() async {
        
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken:  googleAuth?.idToken
    );

    UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);
    return user.user;

  }

  Future<void> verifyUser(String username) async {
    var email = await SharedPreference.getValue('email');
    await firestore.collection('users').where('email', isNotEqualTo: email).get().then((value) => {
      if(value.docs.isNotEmpty){
        if(value.docs.first['email'] != email) throw Exception("User not found")
      }

    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getNostalgiaTracksUser() async {
    try {
      String uid = auth.currentUser!.uid;
      return await firestore.collection('users').doc(uid).get();      
    } catch (e) {
      rethrow;
    }
  }

  void deleteNostalgiaTrack({required NostalgiaTrack nostalgiaTrack}) async {
    var userDTO = await getUser();
    if(userDTO != null){
      String uid = auth.currentUser!.uid;      
      userDTO.nostalgiaTracks.removeWhere((element) => element!.imageUrl == nostalgiaTrack.imageUrl);
      await ref.read(firebaseStorageRepository).deleteFileToFirebase(nostalgiaTrack.path!);
      await firestore.collection('users').doc(uid).update({
        'nostalgiaTracks': userDTO.nostalgiaTracks.map((x) => x?.toMap()).toList(),
      }); 
    }
  }
}
  