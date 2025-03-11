import UIKit

extension UIViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePicker() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "拍照", style: .default) { _ in
                self.presentImagePicker(sourceType: .camera)
            })
        }
        
        alert.addAction(UIAlertAction(title: "从相册选择", style: .default) { _ in
            self.presentImagePicker(sourceType: .photoLibrary)
        })
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    public func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage {
            handleSelectedImage(image)
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    @objc open func handleSelectedImage(_ image: UIImage) {
        // 子类重写此方法处理选中的图片
    }
} 