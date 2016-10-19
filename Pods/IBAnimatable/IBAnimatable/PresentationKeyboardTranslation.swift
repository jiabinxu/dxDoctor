//
//  Created by Tom Baranes on 13/08/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public enum ModalKeyboardTranslation: String, IBEnum {
  case none
  case moveUp
  case aboveKeyboard

  public func translationFrame(keyboardFrame: CGRect, presentedFrame: CGRect) -> CGRect {
    let keyboardMinY = UIScreen.main.bounds.height - keyboardFrame.height    
    var frame = presentedFrame
    switch self {
    case .moveUp: frame.origin.y -= keyboardFrame.height; break
    case .aboveKeyboard: frame.origin.y = keyboardMinY - presentedFrame.height - 20
    default: break
    }
    return frame
  }
}
