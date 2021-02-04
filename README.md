# 15.-CameraPhotoLibrary_Test
15.카메라와 포토 라이브러리에서 미디어 가져오기  


<hr/>

카메라 앱 빌드시 오류발생  
-> 시뮬레이터 대신 기기를 연결하여 빌드 과정중 오류가 발생함

## 오류 내용
2021-02-05 01:15:41.532218+0900 CameraPhotoLibrary[400:9064] [Camera] Failed to read exposureBiasesByMode dictionary: Error Domain=NSCocoaErrorDomain Code=4864 "*** -[NSKeyedUnarchiver _initForReadingFromData:error:throwLegacyExceptions:]: data is NULL" UserInfo={NSDebugDescription=*** -[NSKeyedUnarchiver _initForReadingFromData:error:throwLegacyExceptions:]: data is NULL}  
2021-02-05 01:15:41.576319+0900 CameraPhotoLibrary[400:9092] [access] This app has crashed because it attempted to access privacy-sensitive data without a usage description.  The app's Info.plist must contain an NSCameraUsageDescription key with a string value explaining to the user how the app uses this data.
(lldb) 


### **> 오류 사항**
  1. 개발자 프로그램은 등록하지 않았음
  2. 기기를 연결해 빌드하고 사진 촬영을 눌렀을 때 위와 같은 오류가 발생함
  3. 위와 같은 내용은 카메라의 사용 권한에 대해 키를 입력하지 않았기때문임

### **-> 해결방안**
  1. 프로젝트 내비게이터 영역에서 [info.plist] 클릭
  2. Key 항목 중 [Main storyboard file base name]에 마우스커서를 올리면 + , - 표시가 나온다 여기서 + 클릭
  3. 추가된 항목에서 Privacy 입력하면 목록이 나오는데 [Privacy - Camera Usage Description] 을 선택
  4. 더 정확하게는 사용하려면 권한 확인에 대한 설명을 키 값인 [Value]에 넣어야 하지만 빈 칸으로 두어도 상관없다.
  5. 같은 방법으로 포토 라이브러리 접근에 대한 키와 마이크로폰 접근에 대한 키를 추가 할 수있다.
   -> 마이크로 폰 접근 키 : Privacy - Microphone Usage Description
   -> 포토라이브러리 저장키 : Privacy - Photo Library Addions Usage Description
   -> 포토라이브러리 접근키 : Privacy - Photo Library Usage Description

   **(!!!대소문자를 구분하여 입력해야 목록이 나온다!!!)**
