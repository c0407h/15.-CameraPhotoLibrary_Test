//
//  ViewController.swift
//  CameraPhotoLibrary
//
//  Created by 이충현 on 2021/02/04.
//

import UIKit
// 카메라와 포토 라이브러리를 사용하기 위해 ImagePickerController와
// 이 컨트롤러를 사용하기 위한 델리게이트 프로토콜이 필요함
// 그리고 미디어 타입이 정의된 헤더 파일이 있어야하는데 MobileCoreServices 헤더를 추가
import MobileCoreServices

// ImagePickerController를 사용하기 위해 델리게이트 프로토콜 선언 추가-
class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var imgView: UIImageView!
    
    // UIImagePickerController의 인스턴스 변수 생성
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    
    // 촬영을 하거나 포토 라이브러리에서 불러온 사진(Image)을 저장할 변수
    var captureImage: UIImage!
    
    // 녹화한 비디오의 URL을 저장할 변수
    var videoURL: URL!
    
    // 이미지 저장 여부를 나타낼 변수
    var flagImageSave = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnCaptureImageFromCamera(_ sender: UIButton) {
        //'사진 촬영'코드
        
        // 카메라의 사용 가능 여부를 확인하는 코드
        // 사용할 수 있는 경우에만 아래 내용 수행
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            //카메라 촬영 후 저장할 것이기 때문에 이미지 저장을 허용한다.
            flagImageSave = true
            //이미지 피커의 델리게이트를 self로 설정
            imagePicker.delegate = self
            //이미지 피커의 소스 타입을 camera로 설정
            imagePicker.sourceType = .camera
            //이미지 타입은 kUTTpyeImage로 설정
            imagePicker.mediaTypes = [kUTTypeImage as String]
            // 편집은 허용하지 않는다
            imagePicker.allowsEditing = false
            
            //현재 뷰 컨트롤러를 imagePicker로 대체
            // 즉 뷰에 imagePicker가 보이게 한다
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            // 카메라를 사용할 수 없을 때는 경고 창을 띄움
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    @IBAction func btnLKoadImageFromLibrary(_ sender: UIButton) {
        // '사진 불러오기 ' 코드
        // -> 포토 라이브러리의 사용 가능 여부를 확인한 후 소스 타입은 photoLibrarty,
        // 미디어 타입은 kUTTypeImage로 설정하고 편집은 허용한다
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
            
        } else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album")
        }
    }
    
    @IBAction func btnRecordVideoFromCamera(_ sender: UIButton) {
        //'비디오 촬영'코드 작성
        // 사진 촬영 코드와 유사하지만 비디오 촬영 코드에서는 카메라 사용 여부를
        // 확인한 후 소스타입은 camera, 미디어 타입은 kUTTypeMovie로 설정,
        // 편집 허용하지 않음
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = false
            

            present(imagePicker, animated: true, completion: nil)
        }
        else {
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    @IBAction func btnLoadVideoFromLibrary(_ sender: UIButton) {
        //'비디오 불러오기' 코드
        // 포토라이브러리 사용 여부를 확인 한 후 소스타입은 photoLibrary,
        // 미디어 타입은 kUTTypeMovie로 설정 편집 허용하지 않음
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
            
        } else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album")
        }
    
    }
    
    // 델리게이트 메서드 구현
    // 사용자가 사진이나 비디오 촬영하거나 포토 라이브러리에서 선택이 끝났을 때
    // 호출되는 didFinishPickingMediaWithInfo메서드 구현
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 미디어 종류를 확인한다.
        let mediaType = info[UIImagePickerController.InfoKey.mediaType]
                        as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            //미디어 종류가 image 사진일 경우
            
            // 사진을 가져와 captureImage에 저장한다
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            
            // flagImageSave가 true 이면 가져온 사진을 포토 라이브러리에 저장
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            // 가져온 사진을 이미지 뷰에 출력
       imgView.image = captureImage
        }
        // 미디어 종류가 Movie 비디오일 경우
        else if mediaType.isEqual(to: kUTTypeMovie as NSString as String) {
            
            if flagImageSave {
                // flagImageSave가 true이면 촬영한 비디오를 가져와 포토 라이브러리에 저장
                videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL)
                
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
            }
        }
        // 현재의 뷰 컨트롤러를 제거, 즉 뷰에서 이미지 피커 화면을 제거하여 초기 뷰를 보여줌
        self.dismiss(animated: true, completion: nil)
    }
    
    // 사용자가 사진이나 비디오를 찍지 않고 취소하거나 선택하지 않고 취소를 하는 경우에
    // 호출되는 ㅑmagePickerControllerDidCancel 메서드를 구현
    // 이경우 다시 처음의 뷰 상태로 돌아가야 하므로 현재의 뷰 컨트롤러에 보이는 이미지 피커를 제거하여 초기 뷰를 보여 줘야한다
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // 경고 표시용 메서드
    // 문제가 생겼을 때 화면에 표시해 줄 경고 표시용 메서드 작성
    // 아래 코드는 타이틀과 메시지를 받아 경고 창을 표현해 주는 메서드
    // *경고 창을 만드는 방법은 06장 얼럿 참조*
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

