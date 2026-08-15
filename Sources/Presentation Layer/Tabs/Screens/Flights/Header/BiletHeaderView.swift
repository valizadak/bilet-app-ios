//
//  BiletHeaderView.swift
//  Bilet.az
//
//  Axtarış ekranının üstündəki başlıq: bilet.az loqosu və altında
//  üfüqi sürüşən xidmət menyusu. Android versiyasının eyni quruluşu.
//

import UIKit

final class BiletHeaderView: UIView {

	// MARK: - Ölçülər
	//
	// Loqonun sol kənarı ilə menyunun ilk sözünün sol kənarı üst-üstə düşməlidir.
	// Menyu elementlərinin öz daxili boşluğu olduğuna görə sürüşən sahə
	// bir qədər sola çəkilir (18 - 10 = 8).

	private enum Layout {
		static let sideInset: CGFloat = 18
		static let scrollInset: CGFloat = 8
		static let itemInset: CGFloat = 10
		static let logoHeight: CGFloat = 26
		static let logoTop: CGFloat = 6
		static let menuTop: CGFloat = 14
		static let menuHeight: CGFloat = 24
		static let bottom: CGFloat = 10
	}

	private enum Palette {
		static let active = UIColor.white
		static let inactive = UIColor.white.withAlphaComponent(0.7)
	}

	// MARK: - Xüsusiyyətlər

	/// Menyudan xidmət seçiləndə çağırılır. Aviabilet üçün çağırılmır.
	var onSelect: ((HomeService) -> Void)?

	private let logoImageView = UIImageView()
	private let scrollView = UIScrollView()
	private let itemsStack = UIStackView()

	// MARK: - Yaradılma

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupSubviews()
		setupConstraints()
		fillMenu()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) istifadə olunmur")
	}

	// MARK: - Quraşdırma

	private func setupSubviews() {
		backgroundColor = .clear
		isUserInteractionEnabled = true

		logoImageView.image = R.image.biletLogo()
		logoImageView.contentMode = .scaleAspectFit
		logoImageView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(logoImageView)

		scrollView.showsHorizontalScrollIndicator = false
		scrollView.alwaysBounceHorizontal = true
		scrollView.contentInset = UIEdgeInsets(
			top: 0,
			left: Layout.scrollInset,
			bottom: 0,
			right: Layout.sideInset
		)
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(scrollView)

		itemsStack.axis = .horizontal
		itemsStack.spacing = 0
		itemsStack.alignment = .center
		itemsStack.translatesAutoresizingMaskIntoConstraints = false
		scrollView.addSubview(itemsStack)
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([
			logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.sideInset),
			logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: Layout.logoTop),
			logoImageView.heightAnchor.constraint(equalToConstant: Layout.logoHeight),

			scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
			scrollView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Layout.menuTop),
			scrollView.heightAnchor.constraint(equalToConstant: Layout.menuHeight),
			scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.bottom),

			itemsStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			itemsStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
			itemsStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
			itemsStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
			itemsStack.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor),
		])
	}

	private func fillMenu() {
		for service in HomeService.allCases {
			let button = UIButton(type: .system)
			button.setTitle(service.title, for: .normal)
			button.setTitleColor(service.isFlights ? Palette.active : Palette.inactive, for: .normal)
			button.titleLabel?.font = .systemFont(
				ofSize: 15,
				weight: service.isFlights ? .semibold : .regular
			)
			button.contentEdgeInsets = UIEdgeInsets(
				top: 0,
				left: Layout.itemInset,
				bottom: 0,
				right: Layout.itemInset
			)
			button.addTarget(self, action: #selector(didTapItem(_:)), for: .touchUpInside)
			button.tag = HomeService.allCases.firstIndex(of: service) ?? 0
			itemsStack.addArrangedSubview(button)
		}
	}

	// MARK: - Hadisələr

	@objc
	private func didTapItem(_ sender: UIButton) {
		guard HomeService.allCases.indices.contains(sender.tag) else {
			return
		}
		let service = HomeService.allCases[sender.tag]
		guard !service.isFlights else {
			return
		}
		onSelect?(service)
	}
}
