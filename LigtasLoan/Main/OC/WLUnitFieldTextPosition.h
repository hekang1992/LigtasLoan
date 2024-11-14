

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLUnitFieldTextPosition : UITextPosition <NSCopying>

@property (nonatomic, readonly) NSInteger offset;

+ (instancetype)positionWithOffset:(NSInteger)offset;

@end

NS_ASSUME_NONNULL_END
