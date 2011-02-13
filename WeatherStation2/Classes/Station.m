//
//  Station.m
// 

#import "Station.h"


@implementation Station

@synthesize stationName, stationCode, dateCreated, latitude, longitude;

+ (id)randomStation 
{
	NSArray *randomAdjectiveList = [NSArray arrayWithObjects:@"Fluffy",
														  @"Rusty",
														  @"Shiny", nil];
	NSArray *randomNounList = [NSArray arrayWithObjects:@"Bear",
														@"Spork",
														@"Mac", nil];
	
	int adjectiveIndex = random() % [randomAdjectiveList count];
	int nounIndex = random() % [randomNounList count];
	NSString *randomName = [NSString stringWithFormat:@"%@ %@",
								[randomAdjectiveList objectAtIndex:adjectiveIndex],
								[randomNounList objectAtIndex:nounIndex]];
	NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c", 
													'0' + random() % 10,
													'A' + random() % 26,
													'0' + random() % 10,
													'A' + random() % 26,
													'0' + random() % 10];

	Station *newPossession = 
		[[[self alloc] initWithStationName:randomName
								 code:randomSerialNumber
									 latitude:[NSNumber numberWithDouble:47.5+(rand()%100)*0.1]
									longitude:[NSNumber numberWithDouble:-122.5+(rand()%100)*0.1]] autorelease];
	return newPossession;
}

- (id)initWithStationName:(NSString *)name
				code:(NSString *)sNumber
					latitude:(NSNumber *)lat
				   longitude:(NSNumber *)lng
{
	// Call the superclass's designated initializer 
	self = [super init];
	
	// Did the superclass's initialization fail? 
	if (!self)
		return nil;
	
	// Give the instance variables initial values 
	[self setStationName:name]; 
	[self setStationCode:sNumber]; 
	[self setLatitude:lat];
	[self setLongitude:lng];
	dateCreated = [[NSDate alloc] init];
	
	// Return the address of the newly initialized object
	return self;
}

- (id)init
{
    return [self initWithStationName:@"Possession"
								code:@""
							   latitude:[NSNumber numberWithInt:1000]
							  longitude:[NSNumber numberWithInt:1000]];
}
- (NSString *)description {
	NSString *descriptionString = [[[NSString alloc] initWithFormat:@"%@ (%@)",
									stationName, stationCode] autorelease];
	return descriptionString;
}

@end
