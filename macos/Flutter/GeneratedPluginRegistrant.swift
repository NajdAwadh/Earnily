//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import cloud_firestore
<<<<<<< HEAD
import firebase_auth
import firebase_core

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  FLTFirebaseFirestorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseFirestorePlugin"))
  FLTFirebaseAuthPlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseAuthPlugin"))
=======
import firebase_core

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  FLTCloudFirestorePlugin.register(with: registry.registrar(forPlugin: "FLTCloudFirestorePlugin"))
>>>>>>> 5d7c0d8e153175c72367e6a5af10f4f5adebafa0
  FLTFirebaseCorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseCorePlugin"))
}
