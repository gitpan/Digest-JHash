package Digest::JHash;

use strict;

require Exporter;
require DynaLoader;

our @ISA = qw(Exporter DynaLoader);

our @EXPORT_OK = qw( jhash );
our $VERSION   = '0.02';

bootstrap Digest::JHash $VERSION;

1;

=head1 NAME

Digest::JHash - Perl extension for JHash Hashing Algoritm

=head1 SYNOPSIS

    use Digest::JHash qw(jhash);

    $digest = jhash($data);

    # note that calling jhash() directly like this is the fastest way:

    $digest = Digest::JHash::jhash($data);

=head1 DESCRIPTION

The C<Digest::JHash> module allows you to use the fast JHash hashing algorithm
developed by Bob Jenkins from within Perl programs. The algorithm takes as
input a message of arbitrary length and produces as output a 32-bit
"message digest" of the input in the form of an unsigned long integer.

Call it a low calorie version of MD5 if you like.

See http://burtleburtle.net/bob/hash/doobs.html for more information.

=head1 FUNCTIONS

=over 4

=item jhash($data)

This function will calculate the JHash digest of the "message" in $data
and return a 32 bit integer result (an unsigned long in the C)

=back

=head1 EXPORTS

None by default but you can have the jhash() function if you ask nicely.
See below for reasons not to use Exporter (it is slower than a direct call)

=head1 SPEED NOTE

If speed is a major issue it is roughly twice as fast to do call the jhash()
function like Digest::JHash::jhash('message') than it is to import the
jhash() method using Exporter so you can call it as simply jhash('message').
There is a short script that demonstrates the speed of differecnt calling
methods (direct, OO and Imported) in misc/oo_vs_func.pl

=head1 AUTHORS

The JHash implementation was written by Bob Jenkins
(C<bob_jenkins@burtleburtle.net>).

This perl extension was written by Andrew Towers
(C<mariofrog@bigpond.com>).

A few mods were added by James Freeman
(C<james.freeman@id3.org.uk>).

=head1 SEE ALSO

http://burtleburtle.net/bob/hash/doobs.html

=cut
