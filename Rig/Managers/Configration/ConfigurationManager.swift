//
//  ConfigurationManager.swift
//  Rig
//
//  Created by Mac on 07/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation

class ConfigurationManager
{
    enum Configuration: String
    {
        case debug = "Debug"
        case staging = "Staging"
        case production = "Release"
    }

    // MARK: Shared instance
    static let shared = ConfigurationManager()

    // MARK: Properties
    private let BaseURL = "BaseURL"
    private let configurationKey = "Configuration"
    private let configurationDictionaryName = "Configuration"
    private let BaseURLV = "BaseURLV"
    private let BaseURLVOffers = "BaseURLVOffers"
    private let BaseURLEndpoint = "BaseURLEndpoint"
    private let BaseURLEndpoint2 = "BaseURLEndpoint2"
    private let BaseURLEndpointPartner = "BaseURLEndpointPartner"
    private let BaseURLAuthEndpoint = "BaseURLAuthEndpoint"
    private let BaseURLImage = "BaseURLImage"
    private let BaseURLAudio = "BaseURLAudio"
    private let PayfortEnvoirnment = "PayfortEnvoirnment"

    let activeConfiguration: Configuration
    private let activeConfigurationDictionary: NSDictionary

    // MARK: Lifecycle
    init ()
    {
        let bundle = Bundle(for: ConfigurationManager.self)
        guard let rawConfiguration = bundle.object(forInfoDictionaryKey: configurationKey) as? String,
              let activeConfiguration = Configuration(rawValue: rawConfiguration),
              let configurationDictionaryPath = bundle.path(forResource: configurationDictionaryName, ofType: "plist"),
              let configurationDictionary = NSDictionary(contentsOfFile: configurationDictionaryPath),
              let activeEnvironmentDictionary = configurationDictionary[activeConfiguration.rawValue] as? NSDictionary
        else
        {
            fatalError("Configuration Error")
        }
        self.activeConfiguration = activeConfiguration
        self.activeConfigurationDictionary = activeEnvironmentDictionary
    }

    // MARK: Methods
    private func getActiveVariableValue<V>(forKey key: String) -> V
    {
        guard let value = activeConfigurationDictionary[key] as?  V else
        {
            fatalError("No value satysfying requirements")
        }
        return value
    }

    func isRunning(in configuration: Configuration) -> Bool
    {
        return activeConfiguration == configuration
    }

    func getBaseURL() -> URL
    {
        let backendUrlString: String = getActiveVariableValue(forKey: BaseURL)
        guard let backendUrl = URL(string: backendUrlString)
        else
        {
            fatalError("Backend URL missing")
        }
        return backendUrl
    }

    func getBaseURLV() -> URL
    {
        let backendUrlString: String = getActiveVariableValue(forKey: BaseURLV)
        guard let backendUrl = URL(string: backendUrlString)
        else
        {
            fatalError("Backend URL missing")
        }
        return backendUrl
    }


    func getBaseURLVOffers() -> URL
    {
        let backendUrlString: String = getActiveVariableValue(forKey: BaseURLVOffers)
        guard let backendUrl = URL(string: backendUrlString)
        else
        {
            fatalError("Backend URL missing")
        }
        return backendUrl
    }

    func getBaseURLEndpoint() -> URL
    {
        let backendUrlString: String = getActiveVariableValue(forKey: BaseURLEndpoint)
        guard let backendUrl = URL(string: backendUrlString)
        else
        {
            fatalError("Backend URL missing")
        }
        return backendUrl
    }

    func getBaseURLEndpoint2() -> URL
    {
        let backendUrlString: String = getActiveVariableValue(forKey: BaseURLEndpoint2)
        guard let backendUrl = URL(string: backendUrlString)
        else
        {
            fatalError("Backend URL missing")
        }
        return backendUrl
    }

    func getBaseURLEndpointPartner() -> URL
    {
        let backendUrlString: String = getActiveVariableValue(forKey: BaseURLEndpointPartner)
        guard let backendUrl = URL(string: backendUrlString)
        else
        {
            fatalError("Backend URL missing")
        }
        return backendUrl
    }

    func getBaseURLAuthEndpoint() -> URL
    {
        let backendUrlString: String = getActiveVariableValue(forKey: BaseURLAuthEndpoint)
        guard let backendUrl = URL(string: backendUrlString)
        else
        {
            fatalError("Backend URL missing")
        }
        return backendUrl
    }

    func getBaseURLImage() -> URL
    {
        let backendUrlString: String = getActiveVariableValue(forKey: BaseURLImage)
        guard let backendUrl = URL(string: backendUrlString)
        else
        {
            fatalError("Backend URL missing")
        }
        return backendUrl
    }

    func getBaseURLAudio() -> URL
    {
        let backendUrlString: String = getActiveVariableValue(forKey: BaseURLAudio)
        guard let backendUrl = URL(string: backendUrlString)
        else
        {
            fatalError("Backend Url missing")
        }
        return backendUrl
    }

    func getPayfortEnvoirnment() -> String
    {
        let payfortEnv: String = getActiveVariableValue(forKey: PayfortEnvoirnment)
        return payfortEnv
    }
}
