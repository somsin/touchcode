//
//  NSDateFormatter_InternetDateExtensions.m
//  TouchCode
//
//  Created by Jonathan Wight on 5/16/09.
//  Copyright 2009 Small Society. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "NSDateFormatter_InternetDateExtensions.h"

#import "ISO8601DateFormatter.h"

struct SDateFormatTimeZonePair {
	NSString *dateFormat;
	NSString *timezone;
};

@implementation NSDateFormatter (NSDateFormatter_InternetDateExtensions)

//http://unicode.org/reports/tr35/tr35-4.html#Date_Format_Patterns
//http://www.faqs.org/rfcs/rfc2822.html
//http://en.wikipedia.org/wiki/ISO_8601

+ (NSDateFormatter *)RFC2822Formatter;
{
NSDateFormatter *theFormatter = [[[NSDateFormatter alloc] init] autorelease];
[theFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
[theFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
[theFormatter setDateFormat:@"EEE, d MMM yy HH:mm:ss ZZ"];
return(theFormatter);
}

+ (NSArray *)allRFC2822DateFormatters
{
static NSArray *sFormatters = NULL;

@synchronized(self)
	{
	if (sFormatters == NULL)
		{
		struct SDateFormatTimeZonePair thePairs[] = {
			{ .dateFormat = @"EEE, d MMM yy HH:mm:ss ZZ" },
			{ .dateFormat = @"EEE, d MMM yy HH:mm:ss zzz" },
			{ .dateFormat = @"EEE, d MMM yy HH:mm:ss 'Z'", @"UTC", },
			{ NULL, NULL },
			};
		
		NSMutableArray *theFormatters = [NSMutableArray array];
		for (int N = 0; thePairs[N].dateFormat != NULL; ++N)
			{
			NSDateFormatter *theFormatter = [[[NSDateFormatter alloc] init] autorelease];
			[theFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
			[theFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
			[theFormatter setDateFormat:thePairs[N].dateFormat];
			if (thePairs[N].timezone)
				[theFormatter setTimeZone:[NSTimeZone timeZoneWithName:thePairs[N].timezone]];
			
			[theFormatters addObject:theFormatter];
			}


		sFormatters = [theFormatters copy];
		}
	}
return(sFormatters);
}

@end
