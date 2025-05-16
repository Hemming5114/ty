//
//  STBeautySuiteValueModel.m

//  Copyright © 2020 STBeauty All rights reserved.
//

#import "STBeautySuiteValueModel.h"

float scropeTransfer(NSInteger value) {
    
    // 【-100，100】--> 【0，1.0】
    value += 100;
    return value/200.f;
}


@implementation STBeautySuiteValueModel

- (instancetype)initWithSuite:(STBeautySuite)suiteType {
    
    self = [super init];
    if (self) {
        
        _beautySuite = suiteType;
        [self resetBeautySuiteValueFor:suiteType];
        
    }
    return self;
}

- (void)resetBeautySuiteValueFor:(STBeautySuite)suiteType {
    
    self.fFilterStrength = 0.65;
    
    switch (suiteType) {
        case STBeautySuite_Natural:
        {
            self.fWhitenStrength = 0.4;
            self.fSmoothStrength = 0.75;
            self.fReddenStrength = 0.2;
            
            self.fShrinkFaceStrength = 0.3;
            self.fEnlargeEyeStrength = 0.2;
            self.fShrinkJawStrength = 0.0;
            self.fNarrowFaceStrength = 0.10;
            self.fRoundEyeStrength = 0.10;
            
            self.fThinFaceShapeStrength = 0.20;
            self.fChinStrength      = scropeTransfer(30);     //下巴
            self.fHairLineStrength  = scropeTransfer(0);     //额头
            self.fNarrowNoseStrength = 0.25;
            self.fLongNoseStrength  = scropeTransfer(10);     //长鼻
            self.fMouthStrength     = scropeTransfer(15);     //嘴形
            self.fBrightEyeStrength = 0.30;
            self.fRemoveDarkCirclesStrength = 0.50;
            self.fRemoveNasolabialFoldsStrength = 0.50;
            self.fWhiteTeethStrength = 0.50;
            self.fShrinkCheekboneStrength = 0.0;
        }
            break;
            
        case STBeautySuite_BigEye:
        {
            self.fWhitenStrength = 0.6;
            self.fSmoothStrength = 0.8;
            self.fReddenStrength = 0.5;
            
            self.fShrinkFaceStrength = 0.7;
            self.fEnlargeEyeStrength = 0.7;
            self.fShrinkJawStrength = 0.0;
            self.fNarrowFaceStrength = 0.0;
            self.fRoundEyeStrength = 0.20;
            
            self.fThinFaceShapeStrength = 0.0;
            self.fChinStrength      = scropeTransfer(00);     //下巴
            self.fHairLineStrength  = scropeTransfer(-70);     //额头
            self.fNarrowNoseStrength = 0.15;
            self.fLongNoseStrength  = scropeTransfer(20);     //长鼻
            self.fMouthStrength     = scropeTransfer(15);     //嘴形
            self.fBrightEyeStrength = 0.30;
            self.fRemoveDarkCirclesStrength = 0.50;
            self.fRemoveNasolabialFoldsStrength = 0.50;
            self.fWhiteTeethStrength = 0.50;
            self.fShrinkCheekboneStrength = 0.0;
        }
            break;
            
        case STBeautySuite_Custom:
        default: // 默认参数
        {
            self.fWhitenStrength = 0.6;
            self.fSmoothStrength = 0.8;
            self.fReddenStrength = 0.5;
            
            self.fShrinkFaceStrength = 0.4;
            self.fEnlargeEyeStrength = 0.4;
            self.fShrinkJawStrength = 0.3;
            self.fNarrowFaceStrength = 0.1;
            self.fRoundEyeStrength = 0.20;
            
            self.fThinFaceShapeStrength = 0.4;
            self.fChinStrength      = scropeTransfer(20);     //下巴
            self.fHairLineStrength  = scropeTransfer(-50);     //额头
            self.fNarrowNoseStrength = 0.30;
            self.fLongNoseStrength  = scropeTransfer(10);     //长鼻
            self.fMouthStrength     = scropeTransfer(20);     //嘴形
            self.fBrightEyeStrength = 0.30;
            self.fRemoveDarkCirclesStrength = 0.50;
            self.fRemoveNasolabialFoldsStrength = 0.50;
            self.fWhiteTeethStrength = 0.50;
            self.fShrinkCheekboneStrength = 0.0;
        }
            break;
    }
    
    // 默认值，没有交互调整的UI
    self.fOpenCanthusStrength = 0.0;
    self.fProfileRhinoplastyStrength = 0.0;
    self.fEyeAngleStrength   = 0.5;   // 眼角度
    self.fAppleMusleStrength = 0.0;
    self.fEyeDistanceStrength = 0.5;  // 眼距
    self.fPhiltrumStrength  = 0.5;    //缩人中
    
    self.fContrastStrength = 0.0;
    self.fSaturationStrength = 0.0;
    self.fSharpenStrength = 0.1;
    
}

@end
