//
//  KMKeyChainKit.h
//  VPNManager
//
//  Created by Mioke on 1/25/16.
//  Copyright © 2016 Mioke. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
    Please link the lib <Security> in Build phase: Link the binary with library
 */
#import <Security/Security.h>

NS_ASSUME_NONNULL_BEGIN

@interface KMKeyChainKit : NSObject

/**
 *  Get value from key chain using unique identifier
 *
 *  @param identifier Unique identifier
 *
 *  @return Value stored in key chain, if it doesn't exists, return nil then.
 */
- (nullable NSString *)getValueWithIdentifier:(NSString *)identifier;
/**
 *  Save value to key chain.
 *
 *  @param value      Value need to be stored
 *  @param identifier Identifier mark the value
 *
 *  @return Success or not
 */
- (BOOL)saveValue:(NSString *)value forIdentifier:(NSString *)identifier;
/**
 *  Update the value of identifier in key chain
 *
 *  @param value     New value need to be stored
 *  @param identifer Identifier mark the value
 *
 *  @return Success or not
 */
- (BOOL)updateValue:(NSString *)value forIdentifier:(NSString *)identifer;
/**
 *  Delete value of identifier in key chain
 *
 *  @param identifier Identifier mark the value
 *
 *  @return Success or not
 */
- (BOOL)deleteValueWithIdentifier:(NSString *)identifier;

- (nullable NSData *)searchKeyChainMatching:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
