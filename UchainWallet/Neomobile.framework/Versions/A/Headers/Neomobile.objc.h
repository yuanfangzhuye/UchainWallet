// Objective-C API for talking to github.com/inwecrypto/mobilesdk/neomobile Go package.
//   gobind -lang=objc github.com/inwecrypto/mobilesdk/neomobile
//
// File is generated by gobind. Do not edit.

#ifndef __Neomobile_H__
#define __Neomobile_H__

#include <Foundation/Foundation.h>
#include "Neomobile.h"
#include "ref.h"

@class NeomobileTx;
@class NeomobileWallet;

@interface NeomobileTx : NSObject <goSeqRefInterface> {
}
@property(strong, readonly) id _ref;

- (instancetype)initWithRef:(id)ref;
- (instancetype)init;
- (NSString*)data;
- (void)setData:(NSString*)v;
- (NSString*)id_;
- (void)setID:(NSString*)v;
@end

@interface NeomobileWallet : NSObject <goSeqRefInterface> {
}
@property(strong, readonly) id _ref;

- (instancetype)initWithRef:(id)ref;
- (instancetype)init;
- (NSString*)address;
- (NeomobileTx*)createAssertTx:(NSString*)assert from:(NSString*)from to:(NSString*)to amount:(double)amount unspent:(NSString*)unspent error:(NSError**)error;
- (NeomobileTx*)createClaimTx:(double)amount address:(NSString*)address unspent:(NSString*)unspent error:(NSError**)error;
- (NeomobileTx*)createNep5Tx:(NSString*)asset from:(NSString*)from to:(NSString*)to amount:(int64_t)amount unspent:(NSString*)unspent error:(NSError**)error;
- (NeomobileTx*)mintToken:(NSString*)asset gas:(double)gas amount:(double)amount unspent:(NSString*)unspent error:(NSError**)error;
- (NSString*)mnemonic:(NSString*)lang error:(NSError**)error;
- (NSString*)pubKey;
- (NSString*)toKeyStore:(NSString*)password error:(NSError**)error;
@end

FOUNDATION_EXPORT NSString* NeomobileDecodeAddress(NSString* address, NSError** error);

FOUNDATION_EXPORT NSString* NeomobileEncodeAddress(NSString* address, NSError** error);

FOUNDATION_EXPORT NeomobileWallet* NeomobileFromKeyStore(NSString* ks, NSString* password, NSError** error);

FOUNDATION_EXPORT NeomobileWallet* NeomobileFromMnemonic(NSString* mnemonic, NSString* lang, NSError** error);

FOUNDATION_EXPORT NeomobileWallet* NeomobileFromWIF(NSString* wif, NSError** error);

FOUNDATION_EXPORT NeomobileWallet* NeomobileNew(NSError** error);

#endif
