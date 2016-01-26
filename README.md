# KMKeyChainKit
A tool for manage the key chain, quicker and easier. 

## Install
1. Download the zip and copy the folder `KMKeyChainKit` to your project.
2. Add the link to the `Security.framework` in build phase.
3. Import the `KMKeyChainKit.h` where you want to use.

## Usage

```objc
    KMKeyChainKit *kit = [[KMKeyChainKit alloc] init];
    
    // add
    [kit saveValue:@"pwd12345" forIdentifier:@"username"];
    NSLog(@"%@", [kit getValueWithIdentifier:@"username"]);
    // change
    [kit updateValue:@"pwd54321" forIdentifier:@"username"];
    NSLog(@"%@", [kit getValueWithIdentifier:@"username"]);
    // delete
    [kit deleteValueWithIdentifier:@"username"];
    NSLog(@"%@", [kit getValueWithIdentifier:@"username"]);

```
