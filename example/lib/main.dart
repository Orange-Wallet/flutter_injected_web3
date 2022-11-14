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

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String rpc = "https://rpc.ankr.com/polygon";
  int chainId = 137;

  MyApp({Key? key}) : super(key: key);

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
            isDebug: true,
            initialUrlRequest:
                URLRequest(url: Uri.parse('https://opensea.io/')),
            chainId: chainId,
            rpc: rpc),
      ),
    );
  }

  Future<String> changeNetwork(InAppWebViewController controller,
      JsAddEthereumChain data, int chainId) async {
    try {
      rpc = "https://rpc.ankr.com/eth";
      chainId = int.parse(data.chainId!);
    } catch (e) {
      debugPrint("$e");
    }
    return rpc;
  }

  Future<IncomingAccountsModel> getAccount(
      InAppWebViewController _, String ___, int __) async {
    Credentials fromHex = EthPrivateKey.fromHex(
        "Private key here");
    final address = await fromHex.extractAddress();
    return IncomingAccountsModel(
        address: address.toString(), chainId: chainId, rpcUrl: rpc);
  }

  Future<String> signTransaction(
      InAppWebViewController _, JsTransactionObject data, int chainId) async {
    return "0x45fb0060681bf5d8ea675ab0b3f76aa15c84b172f2fb3191b7a8ceb1e6a7f372";
  }

  Future<String> signPersonelMessage(
      InAppWebViewController _, String data, int chainId) async {
    try {
      Credentials fromHex = EthPrivateKey.fromHex(
          "Private key here");
      final sig = await fromHex.signPersonalMessage(hexToBytes(data));

      debugPrint("SignedTx ${sig}");
      return bytesToHex(sig, include0x: true);
    } catch (e) {
      debugPrint("$e");
    }
    return "";
  }
}
