# 🔍 iTunesProject

- iTunes Search API를 활용한 음악 및 팟캐스트, 영화 검색 앱입니다.
- 홈화면에서 계절별 음악 정보를 확인할 수 있으며 검색창을 통해 검색 결과를 확인할 수 있습니다.
- 검색 결과로는 팟 캐스트, 영화 목록을 제공하며 선택 시 상세 정보를 찾아볼 수 있습니다.

---

## 📸 화면 미리보기

<p align="center">
  <img src="https://github.com/user-attachments/assets/59abcace-71c0-40d2-981b-c806f3fa9f33" width="100%" />
</p>

---

## 🗓 프로젝트 일정

- **시작일:** 2025년 5월 12일
- **종료일:** 2025년 5월 19일

---

## 📂 폴더 구조
```
iTunesProject
├── App/                     # 앱 전역에서 사용되는 설정 관련 디렉토리
│   └── DIContainer
├── Data/                    # 비즈니스 로직의 중심이 되는 계층, 외부와의 의존이 없는 순수 로직 정의
│   ├── Error
│   ├── Manager
│   ├── Model
│   ├── Network
│   └── Repository/
│       └── Implementation
├── Domain                   # 외부 데이터 소스와의 연결 및 구체적인 비즈니스 로직 구현 담당
│   ├── Entity
│   ├── Repository/
│   │   └── Interface
│   ├── UseCase/
│   │   ├── Interface
│   │   └── Implementation
├── Presentation             # UI와 관련된 로직을 관리하는 계층
│   ├── Detail
│   ├── Home/
│   │   ├── Cell
│   │   ├── View
│   │   └── ViewModel
│   ├── Search/
│   ├── Shared/
│   │   ├── Animation
│   │   ├── Base/
│   │   ├── Constants
│   │   ├── Extension
│   │   └── Protocol
└── Resources/               # 프로젝트의 리소스를 관리하는 디렉토리
```

---

## 🛠 사용 기술

- **Swift 5**
- **UIKit**
- **MVVM Pattern**
- **Clean Architecture**
- **RxSwift & RxCocoa & RxDataSources**
- **SnapKit**
- **Then**
- **DI & DIP**

---

## 🌟 주요 기능

- 홈화면 봄, 여름, 가을, 겨울 테마의 음악 정보 확인 가능
- 팟 캐스트 및 영화 media 검색 기능 제공
- 검색 시 검색 결과 화면에서 PodCast, Movie 섹션으로 결과 제공
- 검색 결과가 없는 경우 '검색 결과 없음' 메시지 문구 표시
- 검색 단어를 결과 화면의 Title로 표시 (터치 시 홈화면으로 back)
- PodCast 및 Movie 아이템 클릭 시 상세화면 제공 (.pageSheet)
- 다크모드 지원
  
---

## 🧩 Trouble Shooting

### 🔍 SearchController를 통한 API 다중 구독 이슈

<p align="left">
  <img src="https://github.com/user-attachments/assets/95a9c422-5f63-4416-8075-d6f1a7c78447" width="25%" />
</p>

- **문제**
   - 검색어 입력 시 `debounce`를 사용해 1초 뒤 API를 호출하도록 구현했으나, PodCast Cell의 추천 문구가 계속 바뀌는 문제가 발생
   - 디버깅 결과, `fetchPodcasts, fetchMovies` API가 각각 7번씩 호출되며 중복 호출됨
- **원인**
  - `queryRelay`를 통해 `debounce`된 검색어로 API를 요청하도록 했지만, `.searchQuery` 액션이 발생할 때마다 `fetchSearchQuery()` 메서드를 호출하고 있었음
  - 즉, `queryRelay`에 값을 전달하는 것과 동시에 `queryRelay`를 구독하는 메서드를 매번 호출하여 `queryRelay`의 구독이 누적되고, 그에 따라 API 호출도 반복되는 문제가 발생한 것
  - 이는 PublishRelay가 cold observable이 아니므로 구독을 매번 새로 할 필요가 없다는 점을 간과한 설계였음
- **해결**
  - `queryRelay`는 한 번만 구독하면 되므로 `fetchSearchQuery()` 메서드는 `init()` 시점에 한 번만 호출되도록 수정
  - 이후에는 `.searchQuery` 액션 발생 시 `queryRelay.accept(query)`만 수행하도록 분리함

```swift
// ⚠️ 문제의 구조
init() {
    bind()
}

private func bind() {
    actionSubject
        .subscribe(with: self) { owner, action in
            switch action {
            case .searchQuery(let query):
                owner.queryRelay.accept(query)
                owner.fetchSearchQuery() // 문제의 호출 시점
            }
        }
        .disposed(by: disposeBag)
}
```

```swift
// ✅ 해결된 구조
init() {
    fetchSearchQuery()   // 구독은 1회만
    bind()
}

private func bind() {
    actionSubject
        .subscribe(with: self) { owner, action in
            switch action {
            case .searchQuery(let query):
                owner.queryRelay.accept(query) // 값만 전달
            }
        }
        .disposed(by: disposeBag)
}
```

---

## 📝 클린 아키텍처를 적용해본 내용
### ✅ 모듈화 (Modularity)
- 모듈화의 목적
  - 유지보수성을 높이고, 기능 단위로 코드를 관리 가능하게 하기 위함
  - 각 레이어의 책임 분리 (Responsibility Segregation)
  - 테스트 용이성 향상 (특히 ViewModel / UseCase 단위 테스트)

```markdown
iTunesProject
├── App/DI            👉 ITunesDIContainer, 의존성 주입 설정
├── Data              👉 Network, Repository 구현체
├── Domain            👉 Entity, UseCase, Protocol
├── Presentation      👉 ViewController, View, ViewModel
├── Resources         👉 Assets, Extension 등
```
- 각 모듈별 책임 명시
  - App/DI: 객체 간 의존성 연결 역할 (예: ITunesDIContainer)
  - Data: 외부 의존 처리. API 호출, Repository의 구체 구현
  - Domain: 핵심 비즈니스 로직. Entity, UseCase, Protocol
  - Presentation: UI, 사용자 상호작용 처리. ViewController, ViewModel 포함
  - Resources: 확장 유틸 관리

### ✅ 의존성 주입 (Dependency Injection)
- 도입 배경
  - 본 프로젝트는 클린 아키텍처 기반으로 각 레이어 간의 결합도를 낮추고 유지보수성을 높이기 위해, DIContainer 패턴을 도입하여 의존성을 외부에서 주입받는 구조로 설계함
  - 이를 통해 ViewController나 ViewModel 내부에서 객체를 직접 생성하지 않고, 객체 간의 생명주기 관리와 테스트 용이성을 확보할 수 있도록 구현

- 사용 방식
```swift
final class ITunesDIContainer: ITunesDIContainerInterface {
    func makeHomeViewModel() -> HomeViewModel {
        let repository = MusicRepository()
        let useCase = MusicUseCase(repository: repository)
        return HomeViewModel(useCase: useCase)
    }
    
    func makeSearchViewController() -> SearchViewController {
        let viewModel = makeSearchViewModel()
        return SearchViewController(searchViewModel: viewModel)
    }
}
```

- ViewModel 생성을 DIContainer에서 담당
- UseCase와 Repository를 DIContainer 내부에서 구성
- 필요 시 SearchViewController 등 하위 모듈까지 DIContainer에서 직접 생성

</br>

```swift
final class HomeViewController: BaseViewController {
    private let diContainer: ITunesDIContainerInterface
    private let homeViewModel: HomeViewModel
    private lazy var searchViewController = diContainer.makeSearchViewController()
    
    init(diContainer: ITunesDIContainerInterface) {
        self.diContainer = diContainer
        self.homeViewModel = diContainer.makeHomeViewModel()
        super.init(nibName: nil, bundle: nil)
    }
}
```

- ViewController는 DIContainer의 구현체를 init 시점에 주입받아 사용
- 직접 객체를 생성하지 않고, ViewModel 및 하위 VC 모두 DIContainer를 통해 획득
- ITunesDIContainerInterface를 통해 테스트 또는 모킹 가능

</br>

- 의존성 흐름 원칙
```markdown
HomeViewController
   └── diContainer ← ITunesDIContainerInterface
             ├── makeHomeViewModel()
             │     └── MusicUseCase
             │           └── MusicRepository
             └── makeSearchViewController()
                   └── SearchViewModel ← SearchUseCase ← SearchRepository
```

### ✅ 의존성 역전 원칙
- 정의
  - 의존성 역전 원칙은 SOLID 원칙 중 **D**에 해당하며, 다음 두 가지를 의미함
    - 고수준 모듈은 저수준 모듈에 의존하면 안됨. 둘 다 추상화에 의존
    - 추상화는 세부 사항에 의존하면 안됨. 세부 사항이 추상화에 의존
    - 즉, 구체 타입이 아닌 프로토콜(인터페이스)에 의존하도록 구조화

</br>

- DIP 적용 예시
  
```swift
//MARK: - 예시 1: HomeViewModel ← MusicUseCase ← MusicRepositoryInterface
final class MusicUseCase: MusicUseCaseInterface {
    private let repository: MusicRepositoryInterface

    init(repository: MusicRepositoryInterface) {
        self.repository = repository
    }
}
```
- MusicUseCase는 MusicRepository의 구체 구현이 아닌, MusicRepositoryInterface에 의존

</br>

```swift
//MARK: - 예시 2: HomeViewController ← DIContainer ← ViewModel
final class HomeViewController: BaseViewController {
    private let homeViewModel: HomeViewModel

    init(diContainer: ITunesDIContainerInterface) {
        self.homeViewModel = diContainer.makeHomeViewModel()
    }
}
```
- HomeViewController는 ViewModel을 직접 생성하지 않고, 외부에서 주입
  - 의존성 방향을 거꾸로(역전) 설정하여 결합도를 낮춤

---

## 💦 메모리 이슈 디버깅 및 경험
### 메모리 누수가 발견되지는 않았지만 Instruments - Leaks 사용 경험
- Xcode Menu - Product - Profile
- Instruments - Leaks
- Recording Button Click

<p align="center">
  <img src="https://github.com/user-attachments/assets/5ad7314a-95ba-4384-8382-9407412249a8" width="90%" />
</p>

---
