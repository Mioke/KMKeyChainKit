//
//  KMKeyChainKit.m
//  VPNManager
//
//  Created by Mioke on 1/25/16.
//  Copyright © 2016 Mioke. All rights reserved.
//

#import "KMKeyChainKit.h"

NS_ASSUME_NONNULL_BEGIN

#warning Change the serviece name to your own
static NSString *serviceName = @"com.kleinmioke.kmkeychainkit";

@implementation KMKeyChainKit

- (nonnull NSMutableDictionary *)newKeyChainDictionaryWithIdentifier:(NSString *)identifier {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    
    NSData *encoded = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    
    [dic setObject:encoded forKey:(id)kSecAttrGeneric];
    [dic setObject:encoded forKey:(id)kSecAttrAccount];
    [dic setObject:serviceName forKey:(id)kSecAttrService];
    
    return dic;
}

- (nullable NSData *)searchKeyChainMatching:(NSString *)identifier {
    
    NSMutableDictionary *searchDic = [self newKeyChainDictionaryWithIdentifier:identifier];
    
    [searchDic setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    [searchDic setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    
    CFDataRef result = NULL;
    SecItemCopyMatching((CFDictionaryRef)searchDic, (CFTypeRef *)&result);
    
    NSData *data = (__bridge NSData *)result;
//    CFRelease(result);
    return data;
}

- (nullable NSString *)getValueWithIdentifier:(NSString *)identifier {
    
    NSData *data = [self searchKeyChainMatching:identifier];
    
    if (data == nil) {
        return nil;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (BOOL)saveValue:(NSString *)value forIdentifier:(NSString *)identifier {
    
    NSMutableDictionary *dic = [self newKeyChainDictionaryWithIdentifier:identifier];
    
    [dic setObject:[value dataUsingEncoding:NSUTF8StringEncoding]
            forKey:(id)kSecValueData];
    OSStatus status = SecItemAdd((CFDictionaryRef)dic, NULL);
    
    if (status == errSecSuccess) {
        return YES;
    }
    printf("Key chain save error: %d\n", status);
    return NO;
}

- (BOOL)updateValue:(NSString *)value forIdentifier:(NSString *)identifer {
    
    NSMutableDictionary *search = [self newKeyChainDictionaryWithIdentifier:identifer];
    NSDictionary *updateAttributes = @{(id)kSecValueData: [value dataUsingEncoding:NSUTF8StringEncoding]};
    
    OSStatus status = SecItemUpdate((CFDictionaryRef)search, (CFDictionaryRef)updateAttributes);
    
    if (status == errSecSuccess) {
        return YES;
    }
    printf("Key chain update error: %d\n", status);
    return NO;
}

- (BOOL)deleteValueWithIdentifier:(NSString *)identifier {
    
    if (SecItemDelete((CFDictionaryRef)[self newKeyChainDictionaryWithIdentifier:identifier]) == errSecSuccess) {
        return YES;
    } else {
        return NO;
    }
}

@end

NS_ASSUME_NONNULL_END



