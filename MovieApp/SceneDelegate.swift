import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private var movieUseCase: MovieUseCase!


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        movieUseCase = MovieUseCase()
        let vc = TabViewController(viewModel: MovieCategoriesListViewModel(movieUseCase: movieUseCase))
        //let vc = MovieListViewController(viewModel: MovieListViewModel(movieUseCase: movieUseCase))
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.backgroundColor = .white

        let coordinator = MovieListCoordinator(navigationController: navigationController)
        vc.setCoordinator(coordinator: coordinator)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

