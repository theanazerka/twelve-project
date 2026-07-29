#import "TGFileReferenceManager.h"
#import "../submodules/LegacyComponents/LegacyComponents/TGMediaOriginInfo.h"
#import "TGDownloadMessagesSignal.h"

@interface TGFileReferenceManager ()
{
    SQueue *_queue;
    NSMutableDictionary *_processedOriginInfos;
}
@end

@implementation TGFileReferenceManager

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        _queue = [[SQueue alloc] init];
        _processedOriginInfos = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (SSignal *)updatedOriginInfo:(TGMediaOriginInfo *)originInfo
{
    if (originInfo == nil)
        return [SSignal fail:nil];
    
    return [[SSignal alloc] initWithGenerator:^id<SDisposable>(SSubscriber *subscriber)
    {
        NSString *key = originInfo.key;
        SMetaDisposable *disposable = [[SMetaDisposable alloc] init];
        [_queue dispatch:^
        {
            SVariable *info = _processedOriginInfos[key];
            if (info == nil)
            {
                info = [[SVariable alloc] init];
                [info set:[TGDownloadMessagesSignal remoteOriginInfo:originInfo]];
                _processedOriginInfos[key] = info;
            }
            
            [disposable setDisposable:[info.signal startWithNext:^(id next)
            {
                // A file reference is short-lived. Keep concurrent refreshes
                // coalesced, but discard the completed value so a later
                // FILE_REFERENCE_EXPIRED error performs a fresh request.
                [_queue dispatch:^
                {
                    if (_processedOriginInfos[key] == info)
                        [_processedOriginInfos removeObjectForKey:key];
                }];
                [subscriber putNext:next];
                [subscriber putCompletion];
            } error:^(id error)
            {
                [_queue dispatch:^
                {
                    if (_processedOriginInfos[key] == info)
                        [_processedOriginInfos removeObjectForKey:key];
                }];
                [subscriber putError:error];
            } completed:nil]];
        }];
        return disposable;
    }];
}

@end
