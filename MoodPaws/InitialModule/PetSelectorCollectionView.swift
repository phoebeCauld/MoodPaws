//
//  PetSelectorCollectionView.swift
//  MoodPaws
//
//  Created by Perova Viktoriya Dmitrievna on 04.01.2023.
//

import UIKit

protocol PetSelectorCollectionViewDelegate: AnyObject {
    func pageControl(
        _ collectionView: PetSelectorCollectionView,
        curentPageDidChangeTo: Int
    )
}

final class PetSelectorCollectionView: UICollectionView {

    weak var viewDelegate: PetSelectorCollectionViewDelegate?
    private var petImages: [String]?
    

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        super.init(frame: .zero, collectionViewLayout: layout)
                
        register(PetSelectorCell.self, forCellWithReuseIdentifier: "cellid")

        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        self.delegate = self
        self.dataSource = self
       
    }
    
    func configure(with petImages: [String]) {
        self.petImages = petImages
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PetSelectorCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        petImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! PetSelectorCell

        guard let petImages = petImages else { return cell }

        cell.configure(with: petImages[indexPath.item])

        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let currentPageNumber = Int(x / frame.width)

        viewDelegate?.pageControl(self, curentPageDidChangeTo: currentPageNumber)
    }
}

extension PetSelectorCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
