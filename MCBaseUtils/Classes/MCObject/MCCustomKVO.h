//
//  MCCustomKVO.h
//  MCOCModule
//
//  Created by mingci on 2021/10/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_OPTIONS(NSUInteger,MCKeyValueObservingOptions){
    
    MCKeyValueObservingOptionNew = 0x01,
    
    MCKeyValueObservingOptionOld = 0x02,
    
};

@interface MCCustomKVO : NSObject

@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, assign) MCKeyValueObservingOptions options;

- (instancetype)initWithObserver:(NSObject * _Nullable)observer forKeyPath:(NSString * _Nullable)keyPath options:(MCKeyValueObservingOptions)options;


@end

NS_ASSUME_NONNULL_END
