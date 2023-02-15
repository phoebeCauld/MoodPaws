import UIKit
import UPCarouselFlowLayout

class CurrentMoodCreatorViewController: UIViewController {
    private let leftArrowIcon = UIImageView()
    private let rightArrowIcon = UIImageView()
    private lazy var titleLabel = componentsFactory.makeCommonTextLabel()
    
    private lazy var headerStackView = componentsFactory.makeBaseStackView()
    private lazy var selectedItemLabel = componentsFactory.makeCommonTextLabel()
    private lazy var selectButton =  componentsFactory.makeActionButton()

    private var currentCenterImageIndex: Int = 0
    private var moods: [Mood] = []

    private let componentsFactory: IComponentsFactory
    private let viewModel: ICurrentMoodCreatorViewModel?
    
    
    init(viewModel: ICurrentMoodCreatorViewModel, componentsFactory: IComponentsFactory) {
        self.viewModel = viewModel
        self.componentsFactory = componentsFactory

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let carouselCollectionView: UICollectionView = {
        let layout = UPCarouselFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSizeMake(.itemSideLenth, .itemSideLenth)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast

        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        guard let viewModel = viewModel as? CurrentMoodCreatorViewModel else { return }
        
        configureView(with: viewModel.state)
        setupBottomSheet()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        setupConstrints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let indexPath = IndexPath(item: currentCenterImageIndex, section: 0)

        carouselCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubviews([
            headerStackView,
            selectedItemLabel,
            carouselCollectionView,
            selectButton,
        ])

        headerStackView.addArrangedSubviews([
            leftArrowIcon,
            titleLabel,
            rightArrowIcon,
        ])

        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        headerStackView.configure(axis: .horizontal, spacing: 10)
        headerStackView.distribution = .fillProportionally
        selectButton.addTarget(self, action: #selector(saveNewMood), for: .touchUpInside)
    }

    private func configureView(with model: CurrentMoodCreatorState) {
        titleLabel.configure(with: model.title)
        configureChevronImage(rightArrowIcon, imageName: "chevron.right")
        configureChevronImage(leftArrowIcon, imageName: "chevron.left")
        selectButton.configureButton(with: .init(title: "Save new mood", textSize: 18))
        self.moods = model.moods
        
        currentCenterImageIndex = moods.firstIndex { $0 == model.lastChoosenMood } ?? 0
        
        // Конифгурим после установки `currentCenterImageIndex`,
        // так как выставляем title по индексу текущего центрального эмоджи
        configureSelectedItemLabel()
    }

    private func configureChevronImage(_ imageView: UIImageView, imageName: String) {
        imageView.image = .init(systemName: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .mpDarkPurple
    }

    private func configureSelectedItemLabel() {
        let selectetdTitle = moods[currentCenterImageIndex].rawValue
        let selectedItemLabelModel = TextLabelModel(title: selectetdTitle)
        selectedItemLabel.configure(with: selectedItemLabelModel)
    }

    private func setupConstrints() {
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            headerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerStackView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -32),
            
            selectedItemLabel.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 12),
            selectedItemLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            carouselCollectionView.topAnchor.constraint(equalTo: selectedItemLabel.bottomAnchor, constant: 10),
            carouselCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carouselCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carouselCollectionView.heightAnchor.constraint(equalToConstant: .itemSideLenth + 10),
            
            selectButton.topAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor, constant: 12),
            selectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            selectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
    }

    private func setupBottomSheet() {
            guard let presentationController = self.presentationController as? UISheetPresentationController else { return }
            presentationController.detents = [
                .custom(resolver: { _ in
                    return 200
                })
            ]
            presentationController.prefersGrabberVisible = true
        }

    @objc
    private func saveNewMood() {
        let newMood = moods[currentCenterImageIndex].rawValue
        viewModel?.saveNewCurrentMoodAndDismiss(newMood)
    }
}

extension CurrentMoodCreatorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell

        cell.imageView.image = .init(named: moods[indexPath.row].rawValue)
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let center = CGPoint(x: carouselCollectionView.contentOffset.x + carouselCollectionView.bounds.width / 2,
                              y: carouselCollectionView.bounds.height / 2)
         
        guard let indexPath = carouselCollectionView.indexPathForItem(at: center),
              currentCenterImageIndex != indexPath.row else { return }

        currentCenterImageIndex = indexPath.row
        selectedItemLabel.text = moods[currentCenterImageIndex].rawValue
    }
}

class ImageCell: UICollectionViewCell {
    let  imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CGFloat {
    static let itemSideLenth: Self = 50
}
