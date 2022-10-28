import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_injected_web3/dart_injected_web3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: InjectedWebview(
            requestAccounts: getAccount,
            signTransaction: signTransaction,
            signPersonalMessage: signPersonelMessage,
            initialUrlRequest: URLRequest(
                url: Uri.parse(
                    'https://wallet.polygon.technology/login?next=%2Fwallet')),
            chainId: 1,
            rpc: "https://rpc.ankr.com/polygon_mumbai"),
      ),
    );
  }

  Future<String> getAccount(String _, int_) async {
    Credentials fromHex = EthPrivateKey.fromHex(
        "6843dc59d41289cc20e905180f6702621dcb9798b4413c031f8cb6ef0d9fc3e0");
    return (await fromHex.extractAddress()).toString();
  }

  Future<String> signTransaction(JsTransactionObject data, int chainId) async {
    // Credentials fromHex = EthPrivateKey.fromHex(
    //     "6843dc59d41289cc20e905180f6702621dcb9798b4413c031f8cb6ef0d9fc3e0");
    // final web3 =
    //     Web3Client("https://rpc.ankr.com/polygon_mumbai", http.Client());
    // try {
    //   final trx = Transaction(
    //       from: EthereumAddress.fromHex(
    //         data.from!,
    //       ),
    //       to: EthereumAddress.fromHex(data.to!),
    //       value: EtherAmount.inWei(BigInt.parse(data.value!)),
    //       data: hexToBytes(data.data!));
    //   final signedTx = await web3.signTransaction(fromHex, trx);
    //   debugPrint("SignedTx ${signedTx}");
    //   return bytesToHex(signedTx);
    // } catch (e) {
    //   debugPrint("TxError ${e}");
    // }

    return "0x45fb0060681bf5d8ea675ab0b3f76aa15c84b172f2fb3191b7a8ceb1e6a7f372";
  }

  Future<String> signPersonelMessage(String data, int chainId) async {
    try {
      Credentials fromHex = EthPrivateKey.fromHex(
          "6843dc59d41289cc20e905180f6702621dcb9798b4413c031f8cb6ef0d9fc3e0");
      final sig = await fromHex.signPersonalMessage(
          Uint8List.fromList(utf8.encode(data)),
          chainId: chainId);

      debugPrint("SignedTx ${sig}");
      return bytesToHex(sig, include0x: true);
    } catch (e) {
      debugPrint("$e");
    }
    return "";
  }
}
