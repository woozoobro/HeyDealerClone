# HeyDealerClone

> HeyDealer를 "똑같이" 만들어 보겠다는 목표를 가지고 작업을 진행했습니다.

---

## 📱 기존 앱

| 온보딩1 | 온보딩2 | 번호판1 |
| :-----: | :-----: | :-----: |
|![헤이1](https://github.com/woozoobro/HeyDealerClone/assets/99154211/424fc1d7-4fd2-4d76-be57-76a81a13d4a7)| ![헤이2](https://github.com/woozoobro/HeyDealerClone/assets/99154211/9928e453-0934-4ef9-b7be-d7c44a16bcb1) | ![헤이3](https://github.com/woozoobro/HeyDealerClone/assets/99154211/2312e739-2f56-41ee-b852-decc2a7ffaf8) |

| 번호판2 | 번호판3 | - |
| :-----: | :-----: | :-----: |
| ![헤이4](https://github.com/woozoobro/HeyDealerClone/assets/99154211/30ec3a69-e8fc-4545-83cc-18fc37335ca5) | ![헤이5](https://github.com/woozoobro/HeyDealerClone/assets/99154211/be853f3e-d8d0-49db-bd87-20be9968fd23) | |

## 📱 작업한 내용
| 온보딩1 | 온보딩2 | 번호판1 |
| :-----: | :-----: | :-----: |
|![온보딩1번](https://github.com/woozoobro/HeyDealerClone/assets/99154211/281de76a-5e06-4599-a79b-752ea6790c6a)| ![온보딩2번](https://github.com/woozoobro/HeyDealerClone/assets/99154211/24f8600a-5dd4-4a5a-a560-a150ae8be7a6) |![번호판1번](https://github.com/woozoobro/HeyDealerClone/assets/99154211/0f5d939d-a89e-4989-8c34-877389348134) |

| 초록번호판 | 노랑번호판 | 커서 애니메이션 |
| :-----: | :-----: | :-----: |
| ![초록번호판](https://github.com/woozoobro/HeyDealerClone/assets/99154211/d84505d5-f952-45a3-839f-5cb6a54a934a) | ![노랑번호판](https://github.com/woozoobro/HeyDealerClone/assets/99154211/82d88ae0-abd6-4402-941d-d3ffd75e3f3a)| ![유저 경험](https://github.com/woozoobro/HeyDealerClone/assets/99154211/4c1c9c65-3da0-481b-81d0-64fe7e178316) |


## 🌟 핵심 키워드
- TimelineView
- SceneKit
- Custom Component

## 온보딩 뷰

### ✅ 구현에 성공한 부분
- 번호판과 버블

번호판 뒤의 몽글몽글한 버블이 Lottie일지, SwiftUI일지 고민을 많이 했습니다.
Figma에서 작업한 오브젝트를 SVG로 변환한뒤 SVG를 SwiftUI의 Path 코드로 변환하는 방법을 찾아
해당 Path와 TimelineView를 이용해 몽글몽글함을 표현해 봤습니다.

번호판의 경우 이후에도 계속 등장하는 것으로 유추해 볼 때 
SwiftUI일 것이라 판단해 shadow와 innerShadow를 활용해 3d 오브젝트 느낌을 줬습니다.

제자리에서 도는 애니메이션의 경우 position과 geometry를 이용해 구현했습니다.
이 때 애니메이션이 제대로 렌더링되지 않는 현상이 나타났습니다. 

rotation3dEffect로 한번 감싸주니 전체 오브젝트가 3d object 묶여서 그런지
애니메이션이 정상적으로 렌더링 됐습니다.

### ❌ 구현에 실패한 부분
- 차 애니메이션

동의하고 시작 버튼을 누르면 로우폴리 오브젝트가 등장하고 번호판이 애니메이션 됩니다.
영상일지, 실제 3d object일지 고민을 하다 USDZ 파일을 Scene 뷰로 전환 후 애니메이션을 줬습니다.
이후에 등장하는 번호판 애니메이션은 앞전에 작성한 오브젝트를 사용했습니다.

이렇게 구현을 한 뒤 두가지 문제점들을 발견해 구현에 성공하지 못했다고 판단했습니다.

1. 앱에 단 한번 등장하는 애니메이션을 위해 20mb라는 리소스가 낭비 된다.
2. 차가 사라지고 난 뒤의 번호판 애니메이션이 디바이스별로 height를 맞추지 않는다면 이후의 애니메이션이 연결되지 않는다.

과연 온보딩 애니메이션이 영상이었을지, 오브젝트였을지 아직도 궁금한 것 같습니다. 

## 내차 팔 때 탭

### ✅ 구현에 성공한 부분
- 번호판 텍스트 필드  

현재 텍스트 필드의 폰트 크기가 동적으로 변하고 있습니다.  
숫자일 경우 폰트가 크고, 글자일 경우 폰트가 작습니다.

SwiftUI TextField의 경우 해당 기능을 지원하지 않기 때문에  

1. UITextField를 UIViewRepresentable로 감싸서 구현을 먼저 시도해봤습니다.

```swift
import SwiftUI

class CustomTextField: UITextField {
    override var intrinsicContentSize: CGSize { CGSize(width: UIView.noIntrinsicMetric, height: super.intrinsicContentSize.height)}
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.textAlignment = .center
//        self.contentVerticalAlignment = .center
//    }
}

struct RepresentableTextField: UIViewRepresentable {
    @Binding var text: String
    private let numberFontSize: CGFloat = 48
    private let hangleFontSize: CGFloat = 36
    private let customFont: String = "Pretendard-Bold"
    
    func makeUIView(context: Context) -> CustomTextField {
        let textField = CustomTextField()
        textField.delegate = context.coordinator
//        textField.textAlignment = .center
        textField.contentVerticalAlignment = .center
        textField.contentHorizontalAlignment = .center
        textField.font = UIFont(name: customFont, size: 40)
        textField.textColor = UIColor(Color.theme.background)
        textField.placeholder = "12가 3425"
        textField.attributedPlaceholder = attributedString(for: "12가 3425")
        
        return textField
    }
    
    func updateUIView(_ uiView: CustomTextField, context: Context) {
        uiView.contentHorizontalAlignment = .center
        uiView.contentVerticalAlignment = .center
        uiView.attributedText = attributedString(for: text)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: RepresentableTextField
        
        init(_ parent: RepresentableTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}

extension RepresentableTextField {
    func attributedString(for string: String) -> NSAttributedString {
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.gray.withAlphaComponent(0.5)
        shadow.shadowOffset = CGSize(width: 1, height: 1)
        shadow.shadowBlurRadius = 2
        
        let attributedString = NSMutableAttributedString(string: string)
        let range = NSRange(location: 0, length: string.count)
        
        attributedString.mutableString.enumerateSubstrings(in: range, options: .byComposedCharacterSequences) { substring, substringRange, _, _ in
            if let character = substring?.first,
               NSCharacterSet.decimalDigits.contains(character.unicodeScalars.first!) {
                let attributes: [NSAttributedString.Key : Any] = [
                    .font : UIFont(name: customFont, size: numberFontSize) as Any,
                    .kern : 2,
                    .shadow : shadow
                ]
                attributedString.addAttributes(attributes, range: substringRange)
            } else {
                let attributes: [NSAttributedString.Key : Any] = [
                    .font : UIFont(name: customFont, size: hangleFontSize) as Any,
                    .baselineOffset : 5,
                    .kern : 2,
                    .shadow : shadow
                ]
                attributedString.addAttributes(attributes, range: substringRange)
            }
        }
        
        return attributedString
    }
}
```

폰트가 동적으로 변하게 하지만 Layout에서 문제가 발생한다는 걸 발견하게 되었습니다.


2. 위와 같은 문제로 다른 방법을 고민해보게 되었습니다.

앱의 UI를 자세히 들여다보다 기존의 TextField와 조금씩 다른 부분들을 발견했습니다.

- 커서의 굵기가 다르다. 기본 TextField의 커서보다 통통.
- 텍스트 필드의 경우 커서가 on이 된 상태에서 한번 더 탭을 하게 되면 blink가 초기화 되야 하지만 그렇지 않음.
- 절대적인 타이밍으로 커서가 blink 되고 있고
- 복붙 액션도 켜져 있지 않다. (기존 텍스트필드도 override하면 가능하긴 하지만)
- 폰트가 커졌다 작아질 때 커서가 애니메이션이 되고 있다.

여기서 힌트를 얻어 직접 TextField Like 뷰를 구성해보게 되었습니다.

TextField를 보이지 않게 처리 한 후,  
커서처럼 깜빡이는 rectangle에 애니메이션을 주는 방법으로 구현해보게 되었습니다.

제일 시간이 많이 걸리고 Challenging하게 느껴졌던 부분은  
번호판 규칙을 구현하는 부분이었습니다.

- 숫자로 시작할 때와 한글로 시작할 때 다른 layout
- 중간 한글이 바,사,아,자 들어가면 yellow 번호판
- 한글로 시작하고 위의 케이스 이외에 종성이 나오면 green
- 이외엔 normal 번호판

string을 필터링하는 것과 더불어 케이스에 맞는 UI를 보여주는 것이 
