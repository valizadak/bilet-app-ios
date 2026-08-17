//
//  Copyright © 2020 CleverPumpkin. All rights reserved.
//

import Foundation
import UIKit

@UIApplicationMain
final class AppDelegate: PluggableAppDelegate, ConfigurableAppDelegate {
	
	// MARK: - Internal properties
	
	var window: UIWindow?
	var rootComponent: RootComponent?
	var rootCoordinator: Coordinator?

	// MARK: - Initialization

	override init() {
		// Dil interfeys qurulmamışdan əvvəl təyin olunmalıdır — sistem
		// resurs paketini işə düşəndə bir dəfə seçir.
		AppLanguage.applyDefaultOnFirstLaunch()
		super.init()
	}
	
	override var plugins: [AppDelegatePlugin] {
		privatePlugins
	}
	
	// MARK: - Private properties
	
	private lazy var privatePlugins: [AppDelegatePlugin] = [
		ConfigurationAppDelegatePlugin(appDelegate: self),
		BootstrapAppDelegatePlugin(appDelegate: self),
		FirebaseAppDelegatePlugin(appDelegate: self),
		DeeplinkAppDelegatePlugin(appDelegate: self),
		DebugAppDelegatePlugin(appDelegate: self),
		AdvertisingAppDelegatePlugin(appDelegate: self),
		AppsFlyerAppDelegatePlugin(appDelegate: self)
	]
}
