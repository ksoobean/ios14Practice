//
//  ImagePickerViewController.swift
//  ios14New
//
//  Created by master on 2021/05/04.
//

import UIKit
import Photos


class ImagePickerViewController: UIViewController {
    
    @IBOutlet weak var selectPreview: UIView!
    @IBOutlet weak var selectCollectionView: UICollectionView!
    
    @IBOutlet weak var imagePickerView: UIView!
    @IBOutlet weak var imagePickerCollectionView: UICollectionView!
    
    let pickerCellId: String = "ImagePickerCell"
    let selectCellId: String = "SelectPreviewCell"
    
    var fetchResult: PHFetchResult<PHAsset> = PHFetchResult<PHAsset>()
    var canAccessImages: [ImagePickerVM] = []

    var selectImages: [ImagePickerVM] = []
    
    var itemPerRow: CGFloat = 3.0
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 선택확인 뷰 영역 숨겨줌
        self.selectPreview.isHidden = true
        
        // 선택 확인 컬렉션뷰 레이아웃
        self.selectCollectionView.collectionViewLayout = self.selectPreviewLayout()
        self.selectCollectionView.delegate = self
        self.selectCollectionView.dataSource = self
        self.selectCollectionView.register(UINib.init(nibName: selectCellId, bundle: nil), forCellWithReuseIdentifier: selectCellId)
        
        // 이미지 피커 컬렉션뷰 레이아웃
        self.imagePickerCollectionView.collectionViewLayout = self.pickerLayout()
        self.imagePickerCollectionView.delegate = self
        self.imagePickerCollectionView.dataSource = self
        self.imagePickerCollectionView.register(UINib.init(nibName: pickerCellId, bundle: nil), forCellWithReuseIdentifier: pickerCellId)
        
        // 권한체크
        self.checkAuth {
            // 접근할 수 있는 이미지 가져오기
            self.getCanAccessImages()
        }
        
    }
    
    /// 접근할 수 있는 이미지 가져오기
    private func getCanAccessImages() {
        self.canAccessImages = []
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .fast
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)] // 최신순으로 정렬
        
        self.fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        
        self.fetchResult.enumerateObjects { (asset, _, _) in
            PHImageManager().requestImage(for: asset, targetSize: CGSize(width: 400, height: 400), contentMode: .aspectFit, options: options) { (image, info) in
                guard let image = image else { return }
                self.canAccessImages.append(ImagePickerVM(imageData: image, isSelected: false, index: -1))
                DispatchQueue.main.async {
                    self.imagePickerCollectionView.reloadData()
                }

            }
        }

    }
    
    /// 선택한 이미지 확인 뷰 셋팅
    private func setSelectPreview() {
        
        self.view.needsUpdateConstraints()
        UIView.animate(withDuration: 0.25, animations: {
            self.selectPreview.isHidden = self.selectImages.isEmpty
            self.view.layoutIfNeeded()
        })
        
        // 선택한 이미지들 컬렉션뷰(selectCollectionView)에 보여주기
        self.selectCollectionView.reloadData()
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setImageIndex() {
        var resultArray: [ImagePickerVM] = []
        for accessImage in self.canAccessImages {
            var newVM = accessImage
            newVM.imageData = accessImage.imageData
            newVM.index = self.selectImages.firstIndex {$0.imageData == accessImage.imageData} ?? -1
            newVM.isSelected = -1 == newVM.index ? false : true
            
            resultArray.append(newVM)
        }
        
        self.canAccessImages = resultArray
    }
}

//MARK:- 컬렉션뷰 관련
extension ImagePickerViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.selectCollectionView {
            return self.selectImages.count
        } else {
            return self.canAccessImages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.selectCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: selectCellId, for: indexPath) as! SelectPreviewCell
            cell.configureCell(vm: self.selectImages[indexPath.row])
                
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pickerCellId, for: indexPath) as! ImagePickerCell
            
            cell.configureCell(vm: self.canAccessImages[indexPath.row])
            
            // 셀 선택버튼(오른쪽상단) 클릭 핸들러
            cell.selectHandler = {
                if true == self.canAccessImages[indexPath.row].isSelected {
                    // 이미 선택된 아이템이면 해제
                    self.canAccessImages[indexPath.row].isSelected = false
                    self.selectImages.removeAll(){ $0.imageData == self.canAccessImages[indexPath.row].imageData }
                } else {
                    // 선택되지 않은 아이템이면 선택
                    self.canAccessImages[indexPath.row].isSelected = true
                    self.selectImages.append(self.canAccessImages[indexPath.row])
                }
                // 이미지 순서 업데이트
                self.setImageIndex()
                self.imagePickerCollectionView.reloadData()
                
                // 선택 확인 뷰 셋팅
                self.setSelectPreview()
            }
            
            return cell
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.selectCollectionView {
            // 선택 아이템 삭제
            self.selectImages.remove(at: indexPath.row)
            // 이미지 순서 업데이트
            self.setImageIndex()
            self.imagePickerCollectionView.reloadData()
            
            // 선택 확인 뷰 셋팅
            self.setSelectPreview()
        } else {
            // 확대 이미지 뷰어 보여주기
            
        }
    }
    
    /// 하단 이미지 피커 영역 레이아웃
    private func pickerLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnv: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/self.itemPerRow), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/self.itemPerRow))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // section 구성
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        
        return layout
    }
    
    /// 상단 선택한 이미지 확인 영역 레이아웃
    private func selectPreviewLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnv: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(82), heightDimension: .absolute(82))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(layoutEnv.container.contentSize.width), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // section 구성
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            
            return section
        }
        
        return layout
    }
    
}

//MARK:- PHPhotoLibraryChangeObserver
extension ImagePickerViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        // 이미지 추가/삭제 수정 시 호출
        // fetch
        self.canAccessImages.removeAll()
        // 전부 다 말고 수정된 거만
        guard let details = changeInstance.changeDetails(for: self.fetchResult) else { return }
        self.update(changes: details.fetchResultAfterChanges)

    }
    
    func update(changes: PHFetchResult<PHAsset>) {
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        
        changes.enumerateObjects { (asset, _, _) in
            PHImageManager().requestImage(for: asset, targetSize: CGSize(width: 400, height: 400), contentMode: .aspectFill, options: requestOptions) { (image, info) in
                guard let image = image else { return }
                self.canAccessImages.append(ImagePickerVM(imageData: image))
                DispatchQueue.main.async {
                    self.imagePickerCollectionView.reloadData()
                }
            }
        }
    }
}


//MARK:- 권한체크
extension ImagePickerViewController {
    func checkAuth(complete: @escaping () -> Void) {
        switch PHPhotoLibrary.authorizationStatus() {
        
        case .authorized:
            // 옵저버 등록
            PHPhotoLibrary.shared().register(self)
            complete()
        default:
            // 권한체크 재요청
            PHPhotoLibrary.requestAuthorization { status in
                print("권한 재요청함")
            }
        }
    }
}
