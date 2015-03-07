//
//  CoreDataStackConfiguration.m
//  Pods
//
//  Created by Martin Nash on 3/5/15.
//
//

#import "CoreDataStackConfiguration.h"


@implementation CoreDataStackConfiguration

-(instancetype)initWithConfigurator:(id<StackConfigurator>)config
{
    self = [super init];
    if (self) {
        _storeType = [config storeType];
        _modelName = [config modelName];
        _appIdentifier = [config appIdentifier];
        _dataFileNameWithExtension = [config dataFileNameWithExtension];
        _searchPathDirectory = [config searchPathDirectory];
    }
    return self;
}

+(instancetype)configurationWithStoreType:(NSString*)storeType modelName:(NSString*)modelName appIdentifier:(NSString*)appid dataFileNameWithExtension:(NSString*)dataFileName searchPathDirectory:(NSSearchPathDirectory)spd
{
    CoreDataStackConfiguration *config = [self new];
    config.modelName = modelName;
    config.appIdentifier = appid;
    config.storeType = storeType;
    config.dataFileNameWithExtension = dataFileName;
    config.searchPathDirectory = spd;
    return config;
}

@end

