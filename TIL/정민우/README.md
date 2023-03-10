# 특화 프로젝트

## 1. 목표

Flutter를 이용한 크로스플랫폼 모바일 app 제작

- 완성도 있는 결과물 제작

- 철저한 팀 단위 계획으로 프로젝트 진행

- 계획적인 컴포넌트(위젯) 단위 디자인 설계 -> figma

- android, ios app 배포

## 2. 역할

`디자인`, `프론트엔드`, `모바일`

## 3. 개발 전 진행사항

- 아이디어 회의

  - 아이디어 중점

    - 음성 AI 도메인에 부합하는 아이디어 설정

    - 창의적인 아이디어

    - 모바일 앱을 효과적으로 활용할 수 있는 아이디어

  - 내가 낸 아이디어 목록

    - `소리로 하는 추리게임` : 소리로 증거를 듣고, 사용자의 음성으로 증거를 수집하며 추리하는 추리게임.

    - `참여자의 목소리를 인식하는 퀴즈게임` : 다화자의 목소리를 구분하여 먼저 정답을 외치는 정답자를 자동으로 구분해주는 퀴즈개임 앱.

    - `의약품 정보 음성검색` : 음성으로 특정 약의 외형을 설명하면, 어떤 약인지 검색해준다.

    - `지방자치단체 홈페이지 음성 도우미` : 지방정부 홈페이지 활성화를 위한 음성 도우미

    - `수면 질, 코골이 측정` : 수면 중 소리 데이터를 이용한 뒤척임 정도로 수면의 질, 깊은 잠 여부 측정, 코골이, 잠꼬대 녹음 및 횟수 분석.

    - `소리내어 말하는 하루의 목표, 동기부여 앱` : 하루 한번 소리내어 목표를 말하며 매일의 동기부여

    - `커플용 오늘의 하루 한 문장 앱` : 일정 시간을 정해놓고 휴대폰을 뒤집어놓은 후 대화 나누기. 오늘의 한 문장을 골라서 일기처럼 기록.

- 와이어프레임
  ![와이어프레임](/README_assets/WireFrame.png/)

- 디자인시스템
  ![디자인시스템](/README_assets/DesignSystem.png/)

## 4. 개인 학습 내용

### [🤖 SubPJT1](https://lab.ssafy.com/s08-ai-speech-sub1/S08P21B302/-/tree/conference/정민우/SubPJT1)

### [📱 Flutter](https://lab.ssafy.com/s08-ai-speech-sub1/S08P21B302/-/tree/conference/정민우/Flutter)

### [💻 Dart](https://lab.ssafy.com/s08-ai-speech-sub1/S08P21B302/-/tree/conference/정민우/Dart)

---

- 2.24.(금)

  - Flutter, AndroidStudio, Xcode 개발 환경설정

- 2.25.(토)

  - Flutter 개념 학습

    - 프로젝트 구조(Android, ios)

    - Android Virtual Device, Xcode Simulator 구성

  - Dart 기본 문법 학습

    - 변수, 조건문, 반복문

- 2.26.(일)

  - Flutter 개념 학습

    - Layout

      - `child`, `children: []`

      - `Container()`, `SizedBox()`

      - `Row()`, `Column()`

      - `Flexible()`

    - Style

      각 기본 위젯마다 설정 방법과 요소가 천지차이다.. 필요할때마다 공식문서 또는 자동완성을 적극 활용해야 한다.

  - Dart 기본 문법 학습

    - 함수, `final`/`const`, `class`

- 2.27.(월)

  - Flutter Todo-List 만들기 실습

    - `MaterialApp()`

    - `StatefulWidget` vs `StatelessWidget`

    - Scaffold() 내부 구조 => `appBar`, `Body`, `bottomNavigationBar`

- 2.28.(화)

  - Flutter Todo-List 만들기 실습

    - `Map`, `List`, `반복문`, `조건문`을 활용한 간단한 CRUD

    - `ListView()`를 이용한 Widget 반복 출력

    - `setState()`

    - Color, Style 설정하는 방법

- 3.1.(수)

  - Flutter 연락처 앱 만들기 실습

    - dependencies 세팅(`Pubspec.yaml`, `Pub get`)

    - Permission : 유저에게 데이터 접근권한 요청하는 방법

      - `permission_handler` 라이브러리를 활용한 연락처 데이터 접근

    - `async`, `await`

- 3.2.(목)

  - Flutter 인스타그램 클론코딩

    - `theme()`

    - import custom font

  - SubPJT1

    - Language processing & transformer

    - TTS

- 3.3.(금)

  - flutter

    - gallary permition

    - share

- 3.4.(토)

  - Dart 문법

- 3.5.(일)

  - Dart 문법

- 3.6.(월)

  - flutter

    - instagram clone coding 완성

  - 목업 제작 시작

- 3.7.(화)

  - 목업 70% 이상 완료

- 3.8.(수)

  - 목업 제작 완료

![목업](/README_assets/Mockup.png/)

[▶️ Figma Flow](https://www.figma.com/proto/u83HRrNeDlQm7oqFonlJan/Cocook?node-id=1%3A3&viewport=394%2C326%2C0.1&scaling=scale-down&starting-point-node-id=51%3A174&show-proto-sidebar=1)

- 3.9.(목)

  - flutter : `shared preference`, `page transition`, `gestureDetector()`, `Provider`를 이용한 상태관리, `Gridview`

  - 프로젝트 구조 설계

    ```
    📦 co_cook
    ├─ android/
    ├─ assets/
    │  ├─ images/
    │  │  └─ ...
    │  └─ fonts/
    │     └─ ...
    ├─ ios/
    └─ lib/
      ├─ providers/
      │  ├─ auth_provider.dart
      │  └─ ...
      ├─ screens/
      │  ├─ screen1/
      │  │  ├─ screen1.dart
      │  │  └─ widgets/
      │  │     ├─ local_widget1.dart
      │  │     ├─ local_widget2.dart
      │  │     └─ ...
      │  └─ ...
      ├─ services/
      │  ├─ feature1.dart
      │  ├─ feature2.dart
      │  └─ ...
      ├─ styles/
      │  ├─ colors.dart
      │  └─ fonts.dart
      ├─ utils/
      │  ├─ feature1.dart
      │  ├─ feature2.dart
      │  └─ ...
      ├─ widgets/
      │  ├─ button/
      │  │  ├─ button1.dart
      │  │  ├─ button2.dart
      │  │  └─ ...
      │  ├─ input/
      │  │  ├─ input1.dart
      │  │  ├─ input2.dart
      │  │  └─ ...
      │  └─ ...
      └─ main.dart
    ```

    - `assets`: 앱에서 사용하는 이미지 및 폰트와 같은 리소스 파일을 포함하는 폴더

    - `providers`: 앱의 상태 관리를 위한 Provider 클래스를 포함하는 폴더

    - `screens`: 앱의 화면을 담당하는 위젯을 포함하는 폴더

    - `services`: 데이터베이스, 인증, 푸시 알림과 같은 서비스와 관련된 클래스를 포함하는 폴더

    - `styles`: 앱의 테마와 관련된 파일을 포함하는 폴더

    - `utils`: 유틸리티 클래스와 함수를 포함하는 폴더

    - `widgets`: 재사용 가능한 전역 위젯을 포함하는 폴더

    - `android` 및 `ios`: 각각 Android 및 iOS 앱을 빌드하는 데 필요한 파일을 포함하는 폴더

  - Code Convention

    - 폴더, 파일 명 규칙

      - snake_case

    - 코드 스타일 규칙

      - 함수 : PascalCase, 동사로 시작

        - 예) getUserData, addIngredientsTag ...

      - 변수 : camelCase, 명사, 선언

        - 예) userName, recipeId ...

        - List : 변수명 + List

          - 예) mainRecipeList ...

      - id값 : 변수명 + Id

        - 예) userId ...

```
추후 필수 학습 목록

- 비동기 처리

- 상태관리

- 로그인/로그아웃 인증 및 토큰 관리

- REST API

- 배포 관련(build, 앱 마켓 심의 체크리스트 등)
```
