//
//  LUTImporterController.h
//  LUTImporter
//
//  Created by Stephan Witoszynskyj on 06.11.13.
//
//

#import <Cocoa/Cocoa.h>

@interface LUTImporterController : NSWindowController
{
    IBOutlet NSTextField *lutNameField;
    IBOutlet NSTextField *fileNameField;
}

@property (assign) IBOutlet NSTextField *lutNameField;
@property (assign) IBOutlet NSTextField *fileNameField;

- (IBAction)selectFilePressed:(id)sender;

- (IBAction)cancelPressed:(id)sender;

- (IBAction)addPressed:(id)sender;

@end
