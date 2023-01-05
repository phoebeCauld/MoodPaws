//
//  PetSelectorWithAnimatinView.swift
//  MoodPaws
//
//  Created by Perova Viktoriya Dmitrievna on 04.01.2023.
//

import UIKit

protocol PetSelectorWithAnimatinViewDelegate: AnyObject {
    func pageControl(
        _ collectionView: PetSelectorWithAnimatinView,
        curentPageDidChangeTo: Int
    )
}


final class PetSelectorWithAnimatinView: UIView {
    weak var delegate: PetSelectorWithAnimatinViewDelegate?

    private var petImage: [String]?
//    String? {
//        didSet {
//            guard let image = petImage else { return }
//
//            changePet(with: image)
//        }
//    }
    
    private let petImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    init() {
        super.init(frame: .zero)
        addSubview(petImageView)
        addConstraints()
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipePicture))
        rightSwipe.direction = .right
        addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipePicture))
        leftSwipe.direction = .left
        addGestureRecognizer(leftSwipe)
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
    private func addConstraints() {
        NSLayoutConstraint.activate([
            petImageView.topAnchor.constraint(equalTo: self.topAnchor),
            petImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            petImageView.widthAnchor.constraint(equalToConstant: 250),
            petImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    private func changePet(with newImageName: String) {
        UIView.animate(withDuration: 0.2, delay: 0.1) {
            self.petImageView.alpha = 0
        } completion: { _ in
            self.petImageView.image = .init(named: newImageName)
            self.petImageView.alpha = 1
        }
    }
    
    func configure(with petImage: [String]) {
        //guard let petImage = petImage else { return }
        self.petImage = petImage
        //petImageView.image = .init(named: petImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
