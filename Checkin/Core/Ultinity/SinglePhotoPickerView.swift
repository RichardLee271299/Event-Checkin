//
//  SinglePhotoPickerView.swift
//  Checkin
//
//  Created by VNDC on 21/06/2023.
//

import SwiftUI
import UIKit

struct SinglePhotoPickerView: UIViewControllerRepresentable {

    private let sourceType: UIImagePickerController.SourceType
    private let onImagePicked: (UIImage) -> Void
    private let onCancel: () -> Void
    @Environment(\.presentationMode) private var presentationMode

    public init(sourceType: UIImagePickerController.SourceType, onImagePicked: @escaping (UIImage) -> Void, onCancel: @escaping () -> Void = { } ) {
        self.sourceType = sourceType
        self.onImagePicked = onImagePicked
        self.onCancel = onCancel
        
    }

    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = self.sourceType
        picker.delegate = context.coordinator
        return picker
    }

    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        print(uiViewController.mediaTypes)
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(
            onDismiss: {
                self.presentationMode.wrappedValue.dismiss()
            },
            onImagePicked: self.onImagePicked,
            onCancel: self.onCancel
        )
    }

    final public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        private let onDismiss: () -> Void
        private let onCancel: () -> Void
        private let onImagePicked: (UIImage) -> Void

        init(onDismiss: @escaping () -> Void, onImagePicked: @escaping (UIImage) -> Void, onCancel: @escaping () -> Void) {
            self.onDismiss = onDismiss
            self.onImagePicked = onImagePicked
            self.onCancel = onCancel
        }

        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if var image = info[.originalImage] as? UIImage {
                image = image.fixedOrientation
                self.onImagePicked(image)
            }
            self.onDismiss()
        }

        public func imagePickerControllerDidCancel(_: UIImagePickerController) {
            self.onCancel()
            self.onDismiss()
        }
    }
}
