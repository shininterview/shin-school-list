import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(
    _ scene: UIScene, willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)

    // Notes for interviewer: Avoid storyboard because it's hard to resolve git merge conflicts in
    // storeboard files.
    // Below is how I try to follow dependency injection pattern. I couldn't use my company's
    // internal dependency injection library. I could use a third party library demonstrated in the
    // following guide:
    // https://www.raywenderlich.com/22203552-resolver-for-ios-dependency-injection-getting-started
    let clientConstants = ChaseClientConstants()
    let schoolModelRequest = NewYorkSchoolModelRequest(clientConstants: clientConstants)
    let schoolSATScoreRequest = NewWorkSchoolSATScoreRequest(clientConstants: clientConstants)
    let deps = ChaseSchoolListViewControllerDeps(
      schoolModelRequest: schoolModelRequest, schoolSATScoreRequest: schoolSATScoreRequest)
    let schoolListViewController = SchoolListViewController(deps: deps)
    window.rootViewController = UINavigationController(rootViewController: schoolListViewController)
    self.window = window
    window.makeKeyAndVisible()
  }
}
