//
//  SplashAnimator.swift
//  Bilet.az
//
//  Açılış animasiyası: brend rəngli fonda bilet.az loqosu soldan sağa
//  açılır, bir an dayanır, sonra əriyib tətbiqi göstərir.
//
//  Sistemin öz açılış ekranı (Splash.storyboard) eyni brend rəngindədir,
//  ona görə keçid gözə çarpmır — istifadəçi ancaq loqonun yazıldığını görür.
//

import UIKit

enum SplashAnimator {

	private enum Timing {
		/// Loqonun soldan sağa açılması
		static let reveal: TimeInterval = 0.45
		/// Açıldıqdan sonra gözləmə
		static let hold: TimeInterval = 0.35
		/// Əriyib yox olma
		static let fade: TimeInterval = 0.30
	}

	private enum Layout {
		/// Loqonun eni ekran eninin bu qədər hissəsini tutur
		static let widthRatio: CGFloat = 0.52
		/// Loqo faylının nisbəti: 480 × 109
		static let aspectRatio: CGFloat = 480.0 / 109.0
		/// Mərkəzdən bir qədər yuxarı — optik olaraq daha balanslı görünür
		static let verticalOffset: CGFloat = -0.04
	}

	private static let background = UIColor(red: 0, green: 0xAE / 255, blue: 0xDB / 255, alpha: 1)

	/// Pəncərənin üstünə örtük qoyur və animasiyanı oynadır.
	/// Bitəndən sonra örtük özü silinir.
	static func play(over window: UIWindow) {
		guard let logo = R.image.biletLogo() else {
			return
		}

		let overlay = UIView(frame: window.bounds)
		overlay.backgroundColor = background
		overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		window.addSubview(overlay)

		let logoWidth = window.bounds.width * Layout.widthRatio
		let logoHeight = logoWidth / Layout.aspectRatio
		let centerY = window.bounds.midY + window.bounds.height * Layout.verticalOffset

		// Açılma effekti: loqo kəsilən qutunun içindədir, qutunun eni
		// sıfırdan tam ölçüyə qədər genişlənir.
		let clip = UIView(frame: CGRect(
			x: (window.bounds.width - logoWidth) / 2,
			y: centerY - logoHeight / 2,
			width: 0,
			height: logoHeight
		))
		clip.clipsToBounds = true
		overlay.addSubview(clip)

		let logoView = UIImageView(image: logo)
		logoView.contentMode = .scaleAspectFit
		logoView.frame = CGRect(x: 0, y: 0, width: logoWidth, height: logoHeight)
		clip.addSubview(logoView)

		UIView.animate(
			withDuration: Timing.reveal,
			delay: 0,
			options: [.curveEaseOut],
			animations: {
				clip.frame.size.width = logoWidth
			},
			completion: { _ in
				UIView.animate(
					withDuration: Timing.fade,
					delay: Timing.hold,
					options: [.curveEaseIn],
					animations: {
						overlay.alpha = 0
					},
					completion: { _ in
						overlay.removeFromSuperview()
					}
				)
			}
		)
	}
}
