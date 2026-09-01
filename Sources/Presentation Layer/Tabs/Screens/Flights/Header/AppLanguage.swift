//
//  AppLanguage.swift
//  Bilet.az
//
//  Tətbiqin dili.
//
//  Müştərilərimiz Azərbaycandandır, ona görə tətbiq ilk dəfə açılanda
//  azərbaycan dilində açılmalıdır — telefonun dili nə olursa olsun.
//  Sonradan istifadəçi telefonun ayarlarından ("Preferred Language")
//  başqa dil seçsə, seçimi qorunur, biz bir daha müdaxilə etmirik.
//
//  DİQQƏT — burada incə bir məqam var:
//
//  `AppleLanguages` açarını yazmaq tək başına kifayət etmir. Sistem resurs
//  paketini proses işə düşəndə bir dəfə seçir, bizim yazımız isə ondan sonra
//  baş verir. Nəticədə ilk açılışda sabit mətnlər cihazın dilində, bizim
//  konfiqurasiyadan gələnlər isə azərbaycanca olurdu — interfeys qarışıq
//  görünürdü. App Store yoxlaması məhz buna görə rədd cavabı verdi
//  (Guideline 4 — Design, "mixed languages").
//
//  Ona görə ilk açılışda resurs paketi də dəyişdirilir: `Bundle.main`
//  azərbaycan paketinə yönləndirilir və bütün mətnlər eyni dildə olur.
//

import Foundation
import ObjectiveC

// MARK: - Dili məcbur edən resurs paketi

/// `Bundle.main` üçün əvəzedici: mətnləri seçilmiş dilin paketindən qaytarır.
private final class ForcedLanguageBundle: Bundle, @unchecked Sendable {

	/// Hansı dilin paketindən oxunacağı. Nil olsa, adi davranış işləyir.
	static var languageBundle: Bundle?

	override func localizedString(
		forKey key: String,
		value: String?,
		table tableName: String?
	) -> String {
		guard let bundle = Self.languageBundle else {
			return super.localizedString(forKey: key, value: value, table: tableName)
		}
		return bundle.localizedString(forKey: key, value: value, table: tableName)
	}
}

enum AppLanguage {

	private static let fallback = "az"
	private static let known = ["az", "en", "ru", "tr"]

	private static let languagesKey = "AppleLanguages"
	private static let defaultAppliedKey = "bilet_default_language_applied"

	/// Sistemin tətbiq üçün seçdiyi dilin iki hərfli kodu.
	static var current: String {
		let identifier = Bundle.main.preferredLocalizations.first
			?? Locale.preferredLanguages.first
			?? fallback
		let code = String(identifier.prefix(2)).lowercased()
		return known.contains(code) ? code : fallback
	}

	/// Başlıqdakı düymədə göstərilən qısa ad: AZ, EN, RU, TR
	static var currentShortTitle: String {
		current.uppercased()
	}

	/// Tətbiq ilk dəfə açılanda dili azərbaycancaya çevirir.
	/// İnterfeys qurulmamışdan əvvəl — `AppDelegate.init()`-də çağırılır.
	static func applyDefaultOnFirstLaunch() {
		let defaults = UserDefaults.standard

		guard !defaults.bool(forKey: defaultAppliedKey) else {
			return
		}
		defaults.set(true, forKey: defaultAppliedKey)

		// Sonrakı açılışlar üçün: sistem özü azərbaycan paketini seçəcək.
		var order = defaults.stringArray(forKey: languagesKey) ?? Locale.preferredLanguages
		order.removeAll { $0.lowercased().hasPrefix(fallback) }
		order.insert(fallback, at: 0)
		defaults.set(order, forKey: languagesKey)
		defaults.synchronize()

		// Bu açılış üçün: resurs paketi dərhal dəyişdirilir ki, sabit
		// mətnlər də azərbaycanca olsun və dil qarışığı yaranmasın.
		forceBundle(to: fallback)
	}

	private static func forceBundle(to code: String) {
		guard let path = Bundle.main.path(forResource: code, ofType: "lproj"),
			  let bundle = Bundle(path: path) else {
			return
		}
		ForcedLanguageBundle.languageBundle = bundle
		object_setClass(Bundle.main, ForcedLanguageBundle.self)
	}
}
