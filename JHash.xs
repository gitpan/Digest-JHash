#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

/* Jenkins Hash http://burtleburtle.net/bob/hash/doobs.html */

const int DEBUG = 0;

#define MIX(a,b,c) \
{ \
  a -= b; a -= c; a ^= (c>>13); \
  b -= c; b -= a; b ^= (a<<8); \
  c -= a; c -= b; c ^= (b>>13); \
  a -= b; a -= c; a ^= (c>>12);  \
  b -= c; b -= a; b ^= (a<<16); \
  c -= a; c -= b; c ^= (b>>5); \
  a -= b; a -= c; a ^= (c>>3);  \
  b -= c; b -= a; b ^= (a<<10); \
  c -= a; c -= b; c ^= (b>>15); \
}

unsigned long jhash( SV* str )
{
    STRLEN rawlen;
    char* p;
    unsigned long a, b, c, len, length;

    /* extract the string data and string length from the perl scalar */
    p = (char*)SvPV(str, rawlen);
    length = len = (unsigned long)rawlen;

    /* Test for undef or null string case and return 0 */
    if ( length == 0 ) {
        DEBUG && printf( "Recieved a null or undef string!\n" );
      return 0;
    }

    DEBUG && printf( "Received string '%.*s'.\n", (int)len, p );

    a = b = 0x9e3779b9;        /* golden ratio suggested by Jenkins */
    c = 0;
    while (len >= 12)
    {
        a += (p[0] + (((unsigned long)p[1])<<8) + (((unsigned long)p[2])<<16) +
              (((unsigned long)p[3])<<24));
        b += (p[4] + (((unsigned long)p[5])<<8) + (((unsigned long)p[6])<<16) +
              (((unsigned long)p[7])<<24));
        c += (p[8] + (((unsigned long)p[9])<<8) + (((unsigned long)p[10])<<16) +
              (((unsigned long)p[11])<<24));
        MIX(a, b, c);
        p += 12;
        len -= 12;
    }
    c += length;
    switch(len) {
    case 11: c+=((unsigned int)p[10]<<24);
    case 10: c+=((unsigned int)p[9]<<16);
    case 9:  c+=((unsigned int)p[8]<<8);
    case 8:  b+=((unsigned int)p[7]<<24);
    case 7:  b+=((unsigned int)p[6]<<16);
    case 6:  b+=((unsigned int)p[5]<<8);
    case 5:  b+=((unsigned int)p[4]);
    case 4:  a+=((unsigned int)p[3]<<24);
    case 3:  a+=((unsigned int)p[2]<<16);
    case 2:  a+=((unsigned int)p[1]<<8);
    case 1:  a+=((unsigned int)p[0]);
    }
    MIX(a, b, c);

    DEBUG && printf( "Hash value is %d.\n", (int)(c) );

    return(c);
}

MODULE = Digest::JHash        PACKAGE = Digest::JHash

PROTOTYPES: ENABLE

unsigned long
jhash(str)
    SV*    str
