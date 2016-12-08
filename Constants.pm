#!/usr/bin/perl
no strict 'refs';
use warnings FATAL => 'all';

package Constants;

use Exporter qw/import/;
use File::Slurp qw/read_file/;
use JSON::PP;

my $text      = read_file('ex.json');
my $constants = decode_json($text);

my @exp_subs;
foreach my $const ( keys %$constants ) {
    my $subname = __PACKAGE__ . '::' . $const;
    *$subname = sub { $constants->{$const} };
    push @exp_subs, $const;
}

our @EXPORT_OK = @exp_subs;
