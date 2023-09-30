import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../All Functions Page/Functions.dart';

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({super.key});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  @override
  Widget build(BuildContext context) {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    String? userName = FirebaseAuth.instance.currentUser?.displayName;
    String? userImage = FirebaseAuth.instance.currentUser?.photoURL;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: RichText(
            softWrap: true,
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: 'Payment',
                    style: TextStyle(fontSize: 24, color: Colors.black, fontFamily: 'PoppinsBold')),
                TextSpan(
                    text: 'Gateway',
                    style: TextStyle(fontSize: 24, color: Color(0xFF016DF7), fontFamily: 'PoppinsBold')),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //const Center(child: Icon(Icons.account_circle_rounded, size: 250)),
                const SizedBox(height: 60),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(300), color: Colors.cyanAccent),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 200,
                      height: 200,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(imageUrl: '$userImage', fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Text('Name: $userName',
                    style: const TextStyle(fontFamily: 'PoppinsBold', color: Colors.black, fontSize: 24)),
                Text('Email: $userEmail',
                    style: const TextStyle(fontFamily: 'PoppinsReg', color: Colors.black, fontSize: 16)),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Payment through Mobile Banking', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    nextPage(const showMobileWithdraw(), context);
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  child: const Text('Payment through Bank', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    nextPage(showBankWithdraw(), context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
/*
  showSnackbar() {
    ScaffoldMessenger.of(BuildContext as BuildContext).showSnackBar(SnackBar(
      content: const Text("Transaction Request Success!"),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.blue,
      elevation: 15,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(20),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(20),
    ));
    /*const snackbar = SnackBar(
      content: Text('Transaction Success!'),
      duration: Duration(seconds: 2),
    );
    scaffoldKey.currentState!.showSnackBar(snackbar);*/
  }

  void showMobileWithdraw(context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: const Text("Withdraw Money", style: TextStyle(color: Colors.black)),
            content: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Enter Amount",
                          prefixIcon: const Icon(
                            Icons.attach_money_outlined,
                            color: Colors.black,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Cant be a Empty!';
                          }
                          return null;
                        },
                        onChanged: (val) {},
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Select Platform",
                          prefixIcon: const Icon(
                            Icons.account_balance_wallet,
                            color: Colors.black,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Cant be a Empty!';
                          }
                          return null;
                        },
                        onChanged: (val) {},
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Account Number",
                          prefixIcon: const Icon(
                            Icons.numbers,
                            color: Colors.black,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Cant be a Empty!';
                          }
                          return null;
                        },
                        onChanged: (val) {},
                      ),
                    ],
                  )),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel", style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // ADD DATA
                    /*transactionHistory.add({
                      'name': name,
                      'balance': transfer2Costumer ?? 0,
                      // 'balance': balanceController.text ?? 0,
                    });*/
                    Navigator.of(context).pop();
                    showSnackbar();
                  }
                },
                child: const Text("Withdraw", style: TextStyle(color: Colors.black)),
              ),
            ],
          );
        });
  }

  void showBankWithdraw(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: const Text("Withdraw Money", style: TextStyle(color: Colors.black)),
            content: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Enter Amount",
                          prefixIcon: const Icon(
                            Icons.attach_money_outlined,
                            color: Colors.black,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Cant be a Empty!';
                          }
                          return null;
                        },
                        onChanged: (val) {},
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Bank Name",
                          prefixIcon: const Icon(
                            Icons.account_balance,
                            color: Colors.black,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Cant be a Empty!';
                          }
                          return null;
                        },
                        onChanged: (val) {},
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Branch Name",
                          prefixIcon: const Icon(
                            Icons.account_balance,
                            color: Colors.black,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Cant be a Empty!';
                          }
                          return null;
                        },
                        onChanged: (val) {},
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Account Number",
                          prefixIcon: const Icon(
                            Icons.numbers,
                            color: Colors.black,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Cant be a Empty!';
                          }
                          return null;
                        },
                        onChanged: (val) {},
                      ),
                    ],
                  )),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel", style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // ADD DATA
                    /*transactionHistory.add({
                      'name': name,
                      'balance': transfer2Costumer ?? 0,
                      // 'balance': balanceController.text ?? 0,
                    });*/
                    //Navigator.of(context).pop();
                    snackBar("Transaction Request Success!", context);
                  }
                },
                child: const Text("Withdraw", style: TextStyle(color: Colors.black)),
              ),
            ],
          );
        });
  }
 */
}

class showMobileWithdraw extends StatefulWidget {
  const showMobileWithdraw({super.key});

  @override
  State<showMobileWithdraw> createState() => _showMobileWithdrawState();
}

class _showMobileWithdrawState extends State<showMobileWithdraw> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int platform = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: const Text("Payment Gateway", style: TextStyle(color: Colors.black)),
      content: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Enter Amount",
                    prefixIcon: const Icon(
                      Icons.attach_money_outlined,
                      color: Colors.black,
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Cant be a Empty!';
                    }
                    return null;
                  },
                  onChanged: (val) {},
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black54), borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(0),
                  child: DropdownButton(
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Bkash')),
                      DropdownMenuItem(value: 2, child: Text('Nagad')),
                      DropdownMenuItem(value: 3, child: Text('Rocket')),
                    ],
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    onChanged: (int? value) => setState(() => platform = value!),
                    value: platform,
                    isExpanded: true,
                    iconSize: 30,
                    padding: const EdgeInsets.only(left: 15, right: 12, top: 8, bottom: 8),
                    icon: const Icon(Icons.account_balance_wallet),
                    //borderRadius: BorderRadius.circular(20),
                  ),
                ),
                /*Card(
                  elevation: 5,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 6, left: 10, top: 10, right: 0),
                        child: const Text("Select Platform:", style: TextStyle(fontSize: 18)),
                      ),
                      RadioMenuButton(
                          value: "male",
                          groupValue: gender,
                          onChanged: (value) => setState(() => gender = "male"),
                          child: const Text("Male")),
                      RadioMenuButton(
                          value: "female",
                          groupValue: gender,
                          onChanged: (value) => setState(() => gender = "female"),
                          child: const Text("Female")),
                      RadioMenuButton(
                          value: "female",
                          groupValue: gender,
                          onChanged: (value) => setState(() => gender = "female"),
                          child: const Text("Female")),
                    ],
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Select Platform",
                    prefixIcon: const Icon(
                      Icons.account_balance_wallet,
                      color: Colors.black,
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Cant be a Empty!';
                    }
                    return null;
                  },
                  onChanged: (val) {},
                ),*/
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Account Number",
                    prefixIcon: const Icon(
                      Icons.numbers,
                      color: Colors.black,
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Cant be a Empty!';
                    }
                    return null;
                  },
                  onChanged: (val) {},
                ),
              ],
            )),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel", style: TextStyle(color: Colors.black)),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // ADD DATA
              /*transactionHistory.add({
                      'name': name,
                      'balance': transfer2Costumer ?? 0,
                      // 'balance': balanceController.text ?? 0,
                    });*/
              Navigator.of(context).pop();
              snackBar("Transaction Request Success!", context);
            }
          },
          child: const Text("Make Payment", style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}

class showBankWithdraw extends StatelessWidget {
  showBankWithdraw({super.key});
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: const Text("Payment Gateway", style: TextStyle(color: Colors.black)),
      content: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Enter Amount",
                    prefixIcon: const Icon(
                      Icons.attach_money_outlined,
                      color: Colors.black,
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Cant be a Empty!';
                    }
                    return null;
                  },
                  onChanged: (val) {},
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Bank Name",
                    prefixIcon: const Icon(
                      Icons.account_balance,
                      color: Colors.black,
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Cant be a Empty!';
                    }
                    return null;
                  },
                  onChanged: (val) {},
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Branch Name",
                    prefixIcon: const Icon(
                      Icons.account_balance,
                      color: Colors.black,
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Cant be a Empty!';
                    }
                    return null;
                  },
                  onChanged: (val) {},
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Account Number",
                    prefixIcon: const Icon(
                      Icons.numbers,
                      color: Colors.black,
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Cant be a Empty!';
                    }
                    return null;
                  },
                  onChanged: (val) {},
                ),
              ],
            )),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel", style: TextStyle(color: Colors.black)),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // ADD DATA
              /*transactionHistory.add({
                      'name': name,
                      'balance': transfer2Costumer ?? 0,
                      // 'balance': balanceController.text ?? 0,
                    });*/
              Navigator.of(context).pop();
              snackBar("Transaction Request Success!", context);
            }
          },
          child: const Text("Make Payment", style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
