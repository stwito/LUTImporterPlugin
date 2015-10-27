//
//  LUTImporterFilter.m
//  LUTImporter
//
//  Copyright (c) 2013 Stephan. All rights reserved.
//

#import "LUTImporterFilter.h"
#import "LUTImporterController.h"

@implementation LUTImporterFilter

- (void) initPlugin
{
}

- (long) filterImage:(NSString*) menuName
{
    LUTImporterController *window = [[LUTImporterController alloc] initWithWindowNibName:@"LUTImporterController"];
	[window showWindow:nil];
    
    return 0;
}

@end
