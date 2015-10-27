//
//  LUTImporterFilter.h
//  LUTImporter
//
//  Copyright (c) 2013 Stephan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OsiriXAPI/PluginFilter.h>

@interface LUTImporterFilter : PluginFilter {

}

- (long) filterImage:(NSString*) menuName;

@end
