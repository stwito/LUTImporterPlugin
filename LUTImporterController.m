//
//  LUTImporterController.m
//  LUTImporter
//
//  Created by Stephan Witoszynskyj on 06.11.13.
//
//

#import "LUTImporterController.h"

@implementation LUTImporterController

@synthesize lutNameField;
@synthesize fileNameField;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)selectFilePressed:(id)sender
{
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    openDlg.canChooseFiles          = YES;
    openDlg.canChooseDirectories    = NO;
    openDlg.allowsMultipleSelection = NO;
    
    
    if ( [openDlg runModal] == NSOKButton )
    {
        NSArray* files = [openDlg URLs];
        if (files.count == 1)
            [fileNameField setStringValue:[[files objectAtIndex:0] path]];
    }
}

- (IBAction)cancelPressed:(id)sender
{
    [self close];
}

- (IBAction)addPressed:(id)sender
{
    NSString *fileName = fileNameField.stringValue;
    NSString *lutName  = lutNameField.stringValue;
    
    if ([lutName isEqualTo:@""] || [fileName isEqualTo:@""]) {
        NSAlert *alert = [[[NSAlert alloc] init] autorelease];
		[alert setMessageText:@"Both, a name for the LUT and a file name have to be given!"];
		[alert runModal];
        
        return;
    }
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (! [fileMgr fileExistsAtPath:fileName]) {
        NSAlert *alert = [[[NSAlert alloc] init] autorelease];
		[alert setMessageText:[NSString stringWithFormat:@"File \"%@\" does not exist!",fileName]];
		[alert runModal];
        
        return;
    }
    
    if ([[fileMgr attributesOfItemAtPath:fileName error:nil] fileSize] != 4*256){
        NSAlert *alert = [[[NSAlert alloc] init] autorelease];
		[alert setMessageText:[NSString stringWithFormat:@"File \"%@\" has incorrect size (has to contain exactly 256 float values)!",fileName]];
		[alert runModal];
        
        return;
    }
    
    float *lut = (float*) [[fileMgr contentsAtPath:fileName] bytes];
    
    NSMutableDictionary *opacities = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey: @"OPACITY"] ];
    
    if ([opacities objectForKey:lutName]) {
        NSAlert *alert = [[[NSAlert alloc] init] autorelease];
		[alert setMessageText:[NSString stringWithFormat:@"A LUT called \"%@\" exists already!",lutName]];
		[alert runModal];
        
        return;
    }
    
    NSMutableDictionary *aOpacityFilter = [NSMutableDictionary dictionary];
    NSMutableArray *points = [NSMutableArray array];
	
	for(int i = 0; i < 256; i++)
	{
		NSPoint pt;
        
		pt.x = 1000+i;
		pt.y = lut[i];
		
		[points addObject: NSStringFromPoint( pt)];
	}
    
    [aOpacityFilter setObject:points forKey:@"Points"];
	[opacities setObject:aOpacityFilter forKey:lutName];
    
    [[NSUserDefaults standardUserDefaults] setObject:opacities forKey:@"OPACITY"];
    
    [self close];
}

@end
