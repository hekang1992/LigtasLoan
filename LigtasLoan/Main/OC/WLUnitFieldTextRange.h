

#import <UIKit/UIKit.h>
#import "WLUnitFieldTextPosition.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLUnitFieldTextRange : UITextRange <NSCopying>

@property (nonatomic, readonly) WLUnitFieldTextPosition *start;
@property (nonatomic, readonly) WLUnitFieldTextPosition *end;

@property (nonatomic, readonly) NSRange range;

+ (nullable instancetype)rangeWithStart:(WLUnitFieldTextPosition *)start end:(WLUnitFieldTextPosition *)end;

+ (nullable instancetype)rangeWithRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
