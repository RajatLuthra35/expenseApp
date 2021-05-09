import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

Future<bool> signUp(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> addItem(String item, String amount, String quantity) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    var value = double.parse(amount);
    var value1 = double.parse(quantity);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Items')
        .doc(item);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({
          'itemName': item,
          'Quantity': value1,
          'Amount': value * value1,
          'Time': Timestamp.now(),
        });
        return true;
      }
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> totalSum(String amount, String quantity) async {
  try {
    String uid = await FirebaseAuth.instance.currentUser.uid;
    var value = double.parse(amount);
    var value1 = double.parse(quantity);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Salary')
        .doc('usersalary');
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (snapshot.exists) {
        double newAmount = snapshot.data()['Balance'] - (value * value1);
        transaction.update(documentReference, {'Balance': newAmount});
        return true;
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> salary(String salaryamount) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    var value = double.parse(salaryamount);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Salary')
        .doc('usersalary');
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (snapshot.exists) {
        documentReference.update({
          'Fixedsalary': value,
        });
        double newAmount =
            snapshot.data()['Fixedsalary'] - snapshot.data()['spent'];
        transaction.update(documentReference, {'Balance': newAmount});
        return true;
      }
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> intialsalary(String salaryamount) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    var value = double.parse(salaryamount);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Salary')
        .doc('usersalary');
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({
          'Balance': value,
          'Fixedsalary': value,
          'spent': value,
        });
        return true;
      }
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> userInfo(String username, String emailid) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('userInfo')
        .doc('userinfo');
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({
          'username': username,
          'email id': emailid,
        });
        return true;
      } else if (snapshot.exists) {
        documentReference.update({
          'username': username,
          'email id': emailid,
        });
        return true;
      }
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> moneySpent(String amount, String quantity) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    var value = double.parse(amount);
    var value1 = double.parse(quantity);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Salary')
        .doc('usersalary');
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (snapshot.exists) {
        double newAmount = snapshot.data()['spent'] + value * value1;
        transaction.update(documentReference, {
          'spent': newAmount,
        });

        return true;
      }
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
}
