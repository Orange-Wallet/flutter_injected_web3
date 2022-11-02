import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_injected_web3/dart_injected_web3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  String rpc = "https://rpc.ankr.com/polygon_mumbai";
  int chainId = 80001;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: InjectedWebview(
            addEthereumChain: changeNetwork,
            requestAccounts: getAccount,
            signTransaction: signTransaction,
            signPersonalMessage: signPersonelMessage,
            initialUrlRequest:
                URLRequest(url: Uri.parse('https://app.uniswap.org/#/swap')),
            chainId: chainId,
            rpc: rpc),
      ),
    );
  }

  Future<String> changeNetwork(JsAddEthereumChain data, int chainId) async {
    try {
      rpc = "https://rpc.ankr.com/polygon";
      chainId = int.parse(data.chainId!);
    } catch (e) {
      debugPrint("$e");
    }
    return rpc;
  }

  Future<String> getAccount(String _, int_) async {
    Credentials fromHex = EthPrivateKey.fromHex(
        "6843dc59d41289cc20e905180f6702621dcb9798b4413c031f8cb6ef0d9fc3e0");
    return (await fromHex.extractAddress()).toString();
  }

  Future<String> signTransaction(JsTransactionObject data, int chainId) async {
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
