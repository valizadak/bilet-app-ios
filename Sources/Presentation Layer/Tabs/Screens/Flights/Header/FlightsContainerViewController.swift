//
//  FlightsContainerViewController.swift
//  Bilet.az
//
//  SDK-nın uçuş ekranını öz içinə alır və üstünə bilet.az başlığını qoyur.
//  Android-də activity_main.xml-də etdiyimizin qarşılığıdır: SDK məzmunu
//  yuxarı sürüşdürülür, başlıq onun üstündə dayanır.
//

import UIKit

final class FlightsContainerViewController: UIViewController {

	// MARK: - Ölçülər

	private enum Layout {
		/// SDK məzmununun yuxarı sürüşmə payı — yalnız axtarış ekranında tətbiq olunur.
		///
		/// Diqqət: sürüşdürmə SDK-nın görünüşünü ekrandan hündür edir. Başqa
		/// ekrana keçəndə dərhal ləğv edilməsə, SDK öz başlığını yanlış
		/// hündürlüyə görə yerləşdirir və o, siyahının üstünə düşür.
		/// Ona görə ekran dəyişikliyi hər kadrda yoxlanılır.
		static let contentShift: CGFloat = 0.21
	}

	// MARK: - Xüsusiyyətlər

	private let contentViewController: UIViewController
	private let headerView = BiletHeaderView()
	private var contentTopConstraint: NSLayoutConstraint?

	/// Axtarış ekranının növü. Üstdəki ekran bundan fərqlənəndə başlıq gizlənir.
	private var rootScreenKind: String?
	private var screenWatcher: CADisplayLink?

	// MARK: - Yaradılma

	init(contentViewController: UIViewController) {
		self.contentViewController = contentViewController
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) istifadə olunmur")
	}

	// MARK: - Həyat dövrü

	override func viewDidLoad() {
		super.viewDidLoad()
		embedContent()
		addHeader()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		applyContentShift()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		headerView.refreshLanguageTitle()

		// İlk görünəndə üstdəki ekranı yadda saxlayırıq — sonrakı müqayisə
		// bununla aparılır.
		if rootScreenKind == nil {
			rootScreenKind = currentScreenKind()
		}
		startWatching()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		stopWatching()
	}

	// MARK: - Quraşdırma

	private func embedContent() {
		addChild(contentViewController)
		contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(contentViewController.view)

		let top = contentViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
		contentTopConstraint = top

		NSLayoutConstraint.activate([
			top,
			contentViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			contentViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			contentViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])

		contentViewController.didMove(toParent: self)
	}

	private func addHeader() {
		headerView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(headerView)

		NSLayoutConstraint.activate([
			headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
		])

		headerView.onSelect = { [weak self] service in
			self?.open(service)
		}
		headerView.onLanguageTap = {
			Self.openSystemLanguageSettings()
		}
	}

	// MARK: - Başlığın görünməsi
	//
	// Axtarışdan sonra başlıq gizlədilməlidir ki, filtrləri və qiymət
	// qrafikini örtməsin. SDK bağlı olduğu üçün onun daxili keçidlərinə
	// birbaşa qoşulmaq mümkün deyil, ona görə üstdəki ekranın növü izlənir:
	// dəyişən kimi başlıq gizlənir, axtarış ekranına qayıdanda geri gəlir.

	/// Hər kadrda yoxlanılır. Adi taymer (0.25 san) gec qalırdı: SDK yeni
	/// ekranı biz sürüşdürməni ləğv etməmişdən əvvəl yerləşdirir və
	/// yerləşdirmə yadda qalırdı.
	private func startWatching() {
		stopWatching()
		let link = CADisplayLink(target: self, selector: #selector(watchTick))
		link.add(to: .main, forMode: .common)
		screenWatcher = link
	}

	private func stopWatching() {
		screenWatcher?.invalidate()
		screenWatcher = nil
	}

	@objc
	private func watchTick() {
		updateHeaderVisibility()
	}

	/// Ekranların yığınında ən üstdəkinin növünü qaytarır.
	private func currentScreenKind() -> String {
		var controller: UIViewController = contentViewController

		while true {
			if let presented = controller.presentedViewController {
				controller = presented
				continue
			}
			if let navigation = controller as? UINavigationController,
			   let top = navigation.topViewController,
			   top !== controller {
				controller = top
				continue
			}
			if let tabs = controller as? UITabBarController,
			   let selected = tabs.selectedViewController {
				controller = selected
				continue
			}
			if controller.children.count == 1, let only = controller.children.first {
				controller = only
				continue
			}
			break
		}

		return String(describing: type(of: controller))
	}

	private func updateHeaderVisibility() {
		guard let root = rootScreenKind else {
			return
		}
		let shouldShow = currentScreenKind() == root

		guard headerView.isHidden == shouldShow else {
			return
		}

		headerView.isHidden = !shouldShow
		applyContentShift()

		// Ölçü dəyişdiyi üçün SDK-ya yenidən yerləşdirmə tapşırılır —
		// əks halda o, əvvəlki hündürlüyə görə hesabladığı yerləri saxlayır.
		contentViewController.view.setNeedsLayout()
		contentViewController.view.layoutIfNeeded()
	}

	private func applyContentShift() {
		contentTopConstraint?.constant = headerView.isHidden
			? 0
			: -view.bounds.height * Layout.contentShift
	}

	// MARK: - Dil

	/// Telefonun ayarlarında tətbiqin öz səhifəsini açır. Orada iOS-un
	/// "Preferred Language" bölməsi olur: dil seçiləndən sonra sistem
	/// tətbiqi özü yenidən açır, istifadəçidən heç nə tələb olunmur.
	private static func openSystemLanguageSettings() {
		guard let url = URL(string: UIApplication.openSettingsURLString),
			  UIApplication.shared.canOpenURL(url) else {
			return
		}
		UIApplication.shared.open(url)
	}

	// MARK: - Xidmətlər

	private func open(_ service: HomeService) {
		guard let url = service.url, UIApplication.shared.canOpenURL(url) else {
			return
		}
		UIApplication.shared.open(url)
	}
}
