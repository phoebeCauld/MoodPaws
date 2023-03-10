import UIKit

class InitialViewController: UIViewController {
    private var componentsFactory: IComponentsFactory
    private let blurView: UIVisualEffectView = .init(effect: UIBlurEffect.init(style: .regular))
    
    private lazy var titleLabel = componentsFactory.makeTitleLabel()
    private let petSelectorView = PetSelectorView()
    
    private lazy var petImagePageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .mpDarkPurple
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.addTarget(self, action: #selector(pageControlDidChangePage), for: .valueChanged)
        return pageControl
    }()
    
    private let petSelectButton: UIButton = {
        let button = UIButton()
        let title = NSAttributedString(
            string: "Select",
            attributes: [
                .font: UIFont.systemFont(ofSize: 25, weight: .semibold),
                .foregroundColor: UIColor.white
            ])
        button.setAttributedTitle(title, for: .normal)
        button.roundCorners(corners: .allCorners, radius: 20)
        button.backgroundColor = .mpDarkPurple
        return button
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter the name of your pet"
        textField.roundCorners(corners: .allCorners, radius: 20)
        textField.backgroundColor = .mpDarkPurple
        textField.setLeftPaddingPoints(16)
        textField.setRightPaddingPoints(16)
        textField.textColor = .white
        return textField
    }()
    
    private let nameSelectButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .black)
        let image = UIImage(systemName: "checkmark")?.withConfiguration(imageConfig)
        button.tintColor = .lightGray
        button.setImage(image, for: .normal)
        button.isEnabled = false
        button.roundCorners(corners: .allCorners, radius: 20)
        button.backgroundColor = .mpDarkPurple
        return button
    }()
    
    private lazy var nameSelectorStackView = componentsFactory.makeBaseStackView()
    
    private var nameCreatorBottomConstraint: NSLayoutConstraint?
    private var viewModel: IInitialViewModel
    
    init(viewModel: IInitialViewModel, componentsFactory: IComponentsFactory) {
        self.viewModel = viewModel
        self.componentsFactory = componentsFactory
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addConstraints()
        addKeyboardObservers()
        drawShape()
        
        guard let viewModel = viewModel as? InitialViewModel else { return }
        configureView(with: viewModel.state)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        blurView.frame = self.view.frame
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard nameTextField.isFirstResponder else { return }
        
        nameTextField.resignFirstResponder()
    }
    
    // MARK: keyboard activity

    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                               as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3, delay: 0.1) {
                self.blurView.alpha = 1
                self.nameCreatorBottomConstraint?.constant = -keyboardSize.height
                self.petSelectButton.isHidden = true
                self.nameSelectorStackView.isHidden = false
            }
            
            view.layoutIfNeeded()
        }
    }
    
    @objc
    private func keyboardWillHide() {
        self.nameCreatorBottomConstraint?.constant = -16
        view.layoutIfNeeded()
    }

    // MARK: Selection methods

    @objc
    private func pageControlDidChangePage(_ sender: UIPageControl) {
        petSelectorView.configure(with: viewModel.getNextPet(at: sender.currentPage))
    }

    @objc
    private func didSelectPetSupport() {
        viewModel.didSelectPetSupport(at: petImagePageControl.currentPage)
        
        nameTextField.becomeFirstResponder()
    }
    
    @objc
    private func finishInitialisaiton() {
        guard
            let name = nameTextField.text,
            !name.isEmpty else { return }
        
        viewModel.addPetName(name)
        viewModel.pushMainPageViewController()
    }
}

// MARK: UITextFieldDelegate

extension InitialViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        changeNameSelectButtonEnable(to: true)
    }
    
    private func changeNameSelectButtonEnable(to hasName: Bool) {
        guard hasName && nameSelectButton.isEnabled != hasName else { return }
        
        nameSelectButton.isEnabled = hasName
        nameSelectButton.tintColor = .white
    }
}

// MARK: PetSelectorWithAnimatinViewDelegate

extension InitialViewController: PetSelectorViewDelegate {
    func pageControl(
        _ collectionView: PetSelectorView,
        curentPageDidChangeTo pageAmount: Int
    ) {
        var newPage = 0
        let suggestionPageNumber = petImagePageControl.currentPage + pageAmount
        
        switch suggestionPageNumber {
        case let page where page < 0:
            newPage = petImagePageControl.numberOfPages - 1
        case let page where page > petImagePageControl.numberOfPages - 1:
            newPage = 0
        default:
            newPage = suggestionPageNumber
        }
        
        petImagePageControl.currentPage = newPage
        petSelectorView.configure(with: viewModel.getNextPet(at: petImagePageControl.currentPage))
    }
}

// MARK: View configuration

private extension InitialViewController {
    private func setupView() {
        view.backgroundColor = .white
        
        nameSelectorStackView.addArrangedSubviews([
            nameTextField,
            nameSelectButton,
        ])
        
        view.addSubviews([
            titleLabel,
            petSelectorView,
            petImagePageControl,
            petSelectButton,
            blurView,
            nameSelectorStackView,
        ])
        
        blurView.alpha = 0
        petSelectorView.delegate = self
        nameTextField.delegate = self
        petSelectButton.addTarget(self, action: #selector(didSelectPetSupport), for: .touchUpInside)
        nameSelectButton.addTarget(self, action: #selector(finishInitialisaiton), for: .touchUpInside)
    }
    
    private func configureView(with state: InitialModelViewState) {
        titleLabel.configure(with: .init(title: "Chose your support pet",
                                         textColor: .mpDarkPurple,
                                         textAlignment: .center))
        
        nameSelectorStackView.configure(axis: .horizontal, spacing: 16)
        nameSelectorStackView.distribution = .fillProportionally
        
        petSelectorView.configure(with: state.petsImage.first ?? "")
        petImagePageControl.numberOfPages = state.pets.count
        nameSelectorStackView.isHidden = true
    }
    
    private func addConstraints() {
        nameCreatorBottomConstraint = nameSelectorStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 180),
            titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: self.view.frame.size.width - 50),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            petSelectorView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            petSelectorView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            petSelectorView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            petSelectorView.heightAnchor.constraint(equalToConstant: 200),
            petSelectorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            petImagePageControl.topAnchor.constraint(equalTo: petSelectorView.bottomAnchor, constant: 30),
            petImagePageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            petImagePageControl.widthAnchor.constraint(equalToConstant: self.view.frame.size.width - 50),
            petImagePageControl.heightAnchor.constraint(equalToConstant: 10),
            
            petSelectButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            petSelectButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            petSelectButton.widthAnchor.constraint(equalToConstant: self.view.frame.size.width - 50),
            petSelectButton.heightAnchor.constraint(equalToConstant: 60),
            
            nameCreatorBottomConstraint!,
            nameSelectorStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nameSelectorStackView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width - 50),
            nameSelectorStackView.heightAnchor.constraint(equalToConstant: 60),
            nameSelectButton.widthAnchor.constraint(equalToConstant: 60),
        ])
    }

    private func drawShape() {
        let path = UIBezierPath()
        let x: CGFloat = UIScreen.main.bounds.size.width
        
        path.move(to: CGPoint(x: 0, y: 0)) // top left
        path.addLine(to: CGPoint(x: 0, y: 180)) // bottom left
        path.addCurve(
            to: CGPoint(x: 100, y: 119),
            controlPoint1: CGPoint(x: 8, y: 130),
            controlPoint2: CGPoint(x: 20, y: 130)
        )
        path.addCurve(
            to: CGPoint(x: x, y: 130),
            controlPoint1: CGPoint(x: x - 40, y: 80),
            controlPoint2: CGPoint(x: x - 20, y: 50)
        )
        path.addLine(to: CGPoint(x: x, y: 0)) // top right
        path.close() // close the path from bottom right to bottom left
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.mpDarkPurple.cgColor
        
        view.layer.addSublayer(shapeLayer)
    }
}
