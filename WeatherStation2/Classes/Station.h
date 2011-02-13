//
//  Station.h
//

#import <Foundation/Foundation.h>


@interface Station : NSObject 
{
	NSString *stationName;
	NSString *stationCode;
	NSDate *dateCreated;
	NSNumber *latitude;
	NSNumber *longitude;
}
@property (nonatomic, copy) NSString *stationName;
@property (nonatomic, copy) NSString *stationCode;
@property (nonatomic, readonly) NSDate *dateCreated;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;

+ (id)randomStation;

- (id)initWithStationName:(NSString *)name 
				code:(NSString *)sNumber
					latitude:(NSNumber *)lat
				   longitude:(NSNumber *)lng;

@end
