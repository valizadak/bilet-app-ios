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
		/// SDK məzmununun yuxarı sürüşmə payı — başlıq onun boş sahəsini örtsün deyə.
		/// Android-dəki CONTENT_SHIFT = 0.14f ilə eynidir.
		static let contentShift: CGFloat = 0.14
	}

	// MARK: - Xüsusiyyətlər

	private let contentViewController: UIViewController
	private let headerView = BiletHeaderView()
	private var contentTopConstraint: NSLayoutConstraint?

	/// SDK öz naviqasiyasını içəridə saxlayırsa, dərinliyi izləmək üçün.
	private weak var observedNavigationController: UINavigationController?
	private weak var originalNavigationDelegate: UINavigationControllerDelegate?

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
		observeNavigationIfPossible()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		contentTopConstraint?.constant = -view.bounds.height * Layout.contentShift
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
	}

	/// Axtarışdan sonra başlıq gizlədilməlidir ki, filtrləri və qiymət
	/// qrafikini örtməsin. SDK öz naviqasiyasını UINavigationController ilə
	/// qururasa, dərinliyə görə izləyirik; qurmursa başlıq həmişə görünür.
	private func observeNavigationIfPossible() {
		let navigation = contentViewController as? UINavigationController
			?? contentViewController.children.compactMap { $0 as? UINavigationController }.first

		guard let navigation = navigation else {
			return
		}

		observedNavigationController = navigation
		originalNavigationDelegate = navigation.delegate
		navigation.delegate = self
	}

	private func updateHeaderVisibility() {
		let depth = observedNavigationController?.viewControllers.count ?? 1
		let shouldShow = depth <= 1

		guard headerView.isHidden == shouldShow else {
			return
		}

		headerView.isHidden = !shouldShow
		contentTopConstraint?.constant = shouldShow
			? -view.bounds.height * Layout.contentShift
			: 0
	}

	// MARK: - Xidmətlər

	private func open(_ service: HomeService) {
		guard let url = service.url, UIApplication.shared.canOpenURL(url) else {
			return
		}
		UIApplication.shared.open(url)
	}
}

// MARK: - UINavigationControllerDelegate

extension FlightsContainerViewController: UINavigationControllerDelegate {

	func navigationController(
		_ navigationController: UINavigationController,
		willShow viewController: UIViewController,
		animated: Bool
	) {
		// SDK-nın öz delegate-i varsa, onu kəsmirik — çağırışı ötürürük.
		originalNavigationDelegate?.navigationController?(
			navigationController,
			willShow: viewController,
			animated: animated
		)
		updateHeaderVisibility()
	}

	func navigationController(
		_ navigationController: UINavigationController,
		didShow viewController: UIViewController,
		animated: Bool
	) {
		originalNavigationDelegate?.navigationController?(
			navigationController,
			didShow: viewController,
			animated: animated
		)
		updateHeaderVisibility()
	}
}
