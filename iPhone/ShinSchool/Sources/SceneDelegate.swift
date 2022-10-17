import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(
    _ scene: UIScene, willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)

    // Notes for interviewer: Avoid storyboard because it's hard to resolve git merge conflicts in storeboard files.
    let schoolModelRequest = NewYorkSchoolModelRequest(clientConstants: ChaseClientConstants())
    let schoolListViewController = SchoolListViewController(schoolModelRequest: schoolModelRequest)
    window.rootViewController = UINavigationController(rootViewController: schoolListViewController)
    self.window = window
    window.makeKeyAndVisible()
  }
}
