//
//  NSMutableArray+TYSafeCheck.m
//  TommyTemplate
//
//  Created by Tommy on 2017/9/13.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "NSMutableArray+TYSafeCheck.h"
#import <objc/runtime.h>

@implementation NSMutableArray (TYSafeCheck)

//+ (void)load {
//    [[self class] swizzleMethod:@selector(addObject:) withMethod:@selector(safeAddObject:)];
//    [[self class] swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:)];
//    [[self class] swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(safeInsertObject:atIndex:)];
//    [[self class] swizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(safeRemoveObjectAtIndex:)];
//    [[self class] swizzleMethod:@selector(replaceObjectAtIndex:withObject:) withMethod:@selector(safeReplaceObjectAtIndex:withObject:)];
//}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(addObject:) withMethod:@selector(safeAddObject:)];
        [obj swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:)];
        [obj swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(safeInsertObject:atIndex:)];
        [obj swizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(safeRemoveObjectAtIndex:)];
        [obj swizzleMethod:@selector(replaceObjectAtIndex:withObject:) withMethod:@selector(safeReplaceObjectAtIndex:withObject:)];
    });
}

#pragma mark - magic

- (void)safeAddObject:(id)anObject {
    //do safe operate
    if (anObject) {
        [self safeAddObject:anObject];
    } else {
        NSAssert(anObject,@"safeAddObject: anObject is nil");
    }
}

- (id)safeObjectAtIndex:(NSInteger)index {
    //do safe operate
    if (index >= 0 && index <= self.count) {
        return [self safeObjectAtIndex:index];
    }
    NSAssert([self safeObjectAtIndex:index], @"safeObjectAtIndex: index is invalid");
    return nil;
}

- (void)safeInsertObject:(id)anObject
                 atIndex:(NSUInteger)index {
    //do safe operate
    if (anObject && (index > 0 || index == 0) && index <= self.count) {
        [self safeInsertObject:anObject atIndex:index];
    } else {
        NSLog(@"safeInsertObject:atIndex: anObject or index is invalid");
    }
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
    //do safe operate
    if ((index > 0 || index == 0) && index <= self.count) {
        [self safeRemoveObjectAtIndex:index];
    } else {
        NSLog(@"safeRemoveObjectAtIndex: index is invalid");
    }
}

- (void)safeReplaceObjectAtIndex:(NSUInteger)index
                      withObject:(id)anObject {
    //do safe operate
    if (anObject && (index > 0 || index == 0) && index <= self.count) {
        [self safeReplaceObjectAtIndex:index withObject:anObject];
    } else {
        NSLog(@"safeReplaceObjectAtIndex:withObject: anObject or index is invalid");
    }
}

- (void)swizzleMethod:(SEL)origSelector
           withMethod:(SEL)newSelector {
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, origSelector);
    Method swizzledMethod = class_getInstanceMethod(class, newSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
