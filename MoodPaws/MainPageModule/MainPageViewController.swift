import UIKit

final class MainPageViewController: UIViewController {
    private let viewModel: IMainPageViewModel?

    private let calendarView = MoodCalendarView()

    init(viewModel: IMainPageViewModel) {
        self.viewModel = viewModel

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
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        configureView(with: viewModel.state)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        setupConstraints()
    }

    private func setupVC() {
        view.addSubviews([
            calendarView,
        ])
    }

    private func configureView(with state: MainPageViewState) {
        calendarView.configure(with: state.calendar)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
}
