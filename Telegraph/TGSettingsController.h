#import "../submodules/LegacyComponents/LegacyComponents/LegacyComponents.h"

#import "../submodules/LegacyComponents/LegacyComponents/ActionStage.h"

@interface TGSettingsController : TGViewController <ASWatcher, UIAlertViewDelegate>
@property (nonatomic, strong) ASHandle *actionHandle;

@end
