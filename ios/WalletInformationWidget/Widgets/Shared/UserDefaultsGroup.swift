//
//  UserDefaultsGroup.swift
//  MarketWidgetExtension
//
//  Created by Marcos Rodriguez on 10/31/20.
//  Copyright © 2020 BlueWallet. All rights reserved.
//

import Foundation

enum UserDefaultsGroupKey: String {
  case GroupName = "group.io.bluewallet.bluewallet"
  case PreferredCurrency = "preferredCurrency"
  case ElectrumSettingsHost = "electrum_host"
  case ElectrumSettingsTCPPort = "electrum_tcp_port"
  case ElectrumSettingsSSLPort = "electrum_ssl_port"
  case AllWalletsBalance = "WidgetCommunicationAllWalletsSatoshiBalance"
  case AllWalletsLatestTransactionTime = "WidgetCommunicationAllWalletsLatestTransactionTime"
}

struct UserDefaultsElectrumSettings {
  let host: String?
  let port: Int32?
  let sslPort: Int32?
}

let DefaultElectrumPeers = [UserDefaultsElectrumSettings(host: "electrum1.bluewallet.io", port: 50001, sslPort: 443),
                              UserDefaultsElectrumSettings(host: "electrum2.bluewallet.io", port: 50001, sslPort: 443),
                              UserDefaultsElectrumSettings(host: "electrum3.bluewallet.io", port: 50001, sslPort: 443)]

class UserDefaultsGroup {
  static private let suite = UserDefaults(suiteName: UserDefaultsGroupKey.GroupName.rawValue)

  static func getElectrumSettings() -> UserDefaultsElectrumSettings {
    guard let electrumSettingsHost = suite?.string(forKey: UserDefaultsGroupKey.ElectrumSettingsHost.rawValue), let electrumSettingsTCPPort = suite?.string(forKey: UserDefaultsGroupKey.ElectrumSettingsTCPPort.rawValue), let electrumSettingsSSLPort = suite?.string(forKey: UserDefaultsGroupKey.ElectrumSettingsSSLPort.rawValue) else {
      return UserDefaultsElectrumSettings(host: "electrum1.bluewallet.io", port: 50001, sslPort: 443)
    }
    
    let host = electrumSettingsHost
    let sslPort = Int32(electrumSettingsSSLPort) ?? 443
    let port = Int32(electrumSettingsTCPPort) ?? 50001

    return UserDefaultsElectrumSettings(host: host, port: port, sslPort: sslPort)
  }
  
  static func getAllWalletsBalance() -> Double {
    guard let allWalletsBalance = suite?.string(forKey: UserDefaultsGroupKey.AllWalletsBalance.rawValue) else {
      return 0
    }

    return Double(allWalletsBalance) ?? 0
  }
  
  static func getAllWalletsLatestTransactionTime() -> Int {
    guard let allWalletsTransactionTime = suite?.string(forKey: UserDefaultsGroupKey.AllWalletsLatestTransactionTime.rawValue) else {
      return 0
    }

    return Int(allWalletsTransactionTime) ?? 0
  }
  
}
