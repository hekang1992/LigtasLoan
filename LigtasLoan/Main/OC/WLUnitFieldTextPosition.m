

#import "WLUnitFieldTextPosition.h"

@implementation WLUnitFieldTextPosition

+ (instancetype)positionWithOffset:(NSInteger)offset {
    WLUnitFieldTextPosition *position = [[self alloc] init];
    position->_offset = offset;
    return position;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [WLUnitFieldTextPosition positionWithOffset:self.offset];
}

@end
