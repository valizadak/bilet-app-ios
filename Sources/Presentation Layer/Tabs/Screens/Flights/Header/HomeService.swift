//
//  HomeService.swift
//  Bilet.az
//
//  Başlıqdakı sürüşən menyunun elementləri.
//  Android-dəki HomeServices.kt ilə eyni siyahı və eyni linklər.
//

import Foundation

private let whatsApp = "https://api.whatsapp.com/send?phone=994704474843"

enum HomeService: CaseIterable {

	case flights
	case visa
	case hotel
	case tour
	case transfer
	case insurance
	case esim

	/// Aviabilet öz ekranımızdır — xarici link açmır, sadəcə seçili görünür.
	var url: URL? {
		let string: String?
		switch self {
		case .flights:   string = nil
		case .visa:      string = "https://viza.az"
		case .hotel:     string = whatsApp
		case .tour:      string = whatsApp
		case .transfer:  string = whatsApp
		case .insurance: string = whatsApp
		case .esim:      string = "https://airalo.tpo.lu/RlQE56IT"
		}
		return string.flatMap(URL.init(string:))
	}

	var isFlights: Bool {
		url == nil
	}

	var title: String {
		switch Self.languageCode {
		case "ru": return russianTitle
		case "en": return englishTitle
		case "tr": return turkishTitle
		default:   return azerbaijaniTitle
		}
	}

	// MARK: - Tərcümələr
	//
	// Mətnlər burada saxlanılır, .strings faylında yox: bu elementlər yalnız
	// bizim başlığa aiddir və R.swift generasiyasından asılı olmasın deyə.

	private var azerbaijaniTitle: String {
		switch self {
		case .flights:   return "Aviabilet"
		case .visa:      return "Viza"
		case .hotel:     return "Otel"
		case .tour:      return "Tur"
		case .transfer:  return "Transfer"
		case .insurance: return "Sığorta"
		case .esim:      return "eSİM"
		}
	}

	private var turkishTitle: String {
		switch self {
		case .flights:   return "Uçak bileti"
		case .visa:      return "Vize"
		case .hotel:     return "Otel"
		case .tour:      return "Tur"
		case .transfer:  return "Transfer"
		case .insurance: return "Sigorta"
		case .esim:      return "eSIM"
		}
	}

	private var russianTitle: String {
		switch self {
		case .flights:   return "Авиабилеты"
		case .visa:      return "Виза"
		case .hotel:     return "Отель"
		case .tour:      return "Туры"
		case .transfer:  return "Трансфер"
		case .insurance: return "Страховка"
		case .esim:      return "eSIM"
		}
	}

	private var englishTitle: String {
		switch self {
		case .flights:   return "Flights"
		case .visa:      return "Visa"
		case .hotel:     return "Hotel"
		case .tour:      return "Tours"
		case .transfer:  return "Transfer"
		case .insurance: return "Insurance"
		case .esim:      return "eSIM"
		}
	}

	private static var languageCode: String {
		let identifier = Locale.preferredLanguages.first ?? "az"
		return String(identifier.prefix(2)).lowercased()
	}
}
