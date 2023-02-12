import UIKit

final class MainPageViewController: UIViewController {
    private let viewModel: IMainPageViewModel?
    private var componentsFactory: IComponentsFactory

    private let topBackgroundView = UIView()
    private lazy var calendarView = MoodCalendarView(componentsFactory: componentsFactory)
    private lazy var noteView = NoteView(componentsFactory: componentsFactory)
    private lazy var currentMoodAddView = CurrentMoodAddView(componentsFactory: componentsFactory)

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
        configureView(with: viewModel.model)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        setupConstraints()
    }

    private func setupVC() {
        view.addSubviews([
            topBackgroundView,
            calendarView,
            noteView,
            currentMoodAddView,
        ])
        noteView.delegate = self
        currentMoodAddView.delegate = self
        topBackgroundView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 50)
        topBackgroundView.backgroundColor = .mpLightPurple
    }

    private func configureView(with model: MainPageModel) {
        calendarView.configure(with: model.calendar)
        noteView.configure(with: model.noteView)
        currentMoodAddView.configureView(with: model.currentMoodAdd)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            topBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBackgroundView.heightAnchor.constraint(equalToConstant: 350),
            
            calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            noteView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 32),
            noteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            noteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            currentMoodAddView.topAnchor.constraint(greaterThanOrEqualTo: noteView.bottomAnchor),
            currentMoodAddView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            currentMoodAddView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            currentMoodAddView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
        ])
    }
}

extension MainPageViewController: NoteCellViewDelegate {
    func didTapOnCell(_ cell: NoteCellView, withType type: NoteCellModel.NoteType) {
        viewModel?.didTapOnCell(with: type)
    }
}

extension MainPageViewController: CurrentMoodAddViewDelegate {
    func goToCurrentMoodCreatorView(_ view: CurrentMoodAddView) {
        //
    }
}
