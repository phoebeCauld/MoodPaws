//
//  PetSelectorView.swift
//  MoodPaws
//
//  Created by Perova Viktoriya Dmitrievna on 06.01.2023.
//

import UIKit
import Lottie

protocol PetSelectorViewDelegate: AnyObject {
    func pageControl(
        _ collectionView: PetSelectorView,
        curentPageDidChangeTo: Int
    )
}


final class PetSelectorView: UIView {
    weak var delegate: PetSelectorViewDelegate?

    private var animatedView = LottieAnimationView()

    init() {
        super.init(frame: .zero)

        addSubview(animatedView)
        animatedView.translatesAutoresizingMaskIntoConstraints = false

        addConstraints()

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipePicture))
        rightSwipe.direction = .right
        addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipePicture))
        leftSwipe.direction = .left
        addGestureRecognizer(leftSwipe)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with petImage: String) {
        animatedView.animation = .named(petImage)
        animatedView.contentMode = .scaleAspectFit
        animatedView.loopMode = .loop
        animatedView.play()
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            animatedView.topAnchor.constraint(equalTo: self.topAnchor),
            animatedView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            animatedView.widthAnchor.constraint(equalToConstant: 250),
            animatedView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }

    @objc private func swipePicture(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
            delegate?.pageControl(self, curentPageDidChangeTo: 1)
        case .right:
            delegate?.pageControl(self, curentPageDidChangeTo: -1)
        default:
            break
        }
    }
}
