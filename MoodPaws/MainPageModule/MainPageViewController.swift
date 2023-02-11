import UIKit

final class MainPageViewController: UIViewController {
    private let viewModel: IMainPageViewModel?
    private var componentsFactory: IComponentsFactory

    private let topBackgroundView = UIView()
    private lazy var calendarView = MoodCalendarView(componentsFactory: componentsFactory)

    init(viewModel: IMainPageViewModel, componentsFactory: IComponentsFactory) {
        self.viewModel = viewModel
        self.componentsFactory = componentsFactory

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        view.backgroundColor = .white

        guard let viewModel = viewModel as? MainPageViewModel else { return }
        configureView(with: viewModel.state)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        setupConstraints()
    }

    private func setupVC() {
        view.addSubviews([
            topBackgroundView,
        ])
        
        topBackgroundView.addSubview(calendarView)
        
        topBackgroundView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 50)
        topBackgroundView.backgroundColor = .mpLightPurple
    }

    private func configureView(with state: MainPageViewState) {
        calendarView.configure(with: state.calendar)
    }

    private func setupConstraints() {
        topBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            topBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBackgroundView.heightAnchor.constraint(equalToConstant: 350),
            
            calendarView.topAnchor.constraint(equalTo: topBackgroundView.topAnchor, constant: 100),
            calendarView.trailingAnchor.constraint(equalTo: topBackgroundView.trailingAnchor, constant: -16),
            calendarView.leadingAnchor.constraint(equalTo: topBackgroundView.leadingAnchor, constant: 16),
        ])
    }
}
