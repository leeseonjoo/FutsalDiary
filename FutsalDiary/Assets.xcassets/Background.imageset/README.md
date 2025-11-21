# Background 이미지 추가 방법

저장소 정책 때문에 `background.png` 바이너리 파일은 Git에 포함하지 않습니다. 대신 아래 순서로 로컬에서 파일을 추가해 주세요.

1. 제공받은 `background.png`를 이 디렉터리(`Assets.xcassets/Background.imageset/`)에 복사합니다.
2. Xcode에서 프로젝트를 열면 `Background` 이미지 셋이 자동으로 원본 파일을 참조합니다.
3. 커밋 시 `.gitignore`에 의해 이 파일은 추적되지 않으므로 원본을 다시 커밋하려고 할 필요가 없습니다.

> 참고: 다른 개발자와 공유해야 할 경우 사내 아트 드라이브나 배포용 스토리지를 통해 파일을 전달해 주세요.
