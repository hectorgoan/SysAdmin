#!/usr/bin/perl

use strict;
use warnings;
use CGI qw(:standard);
my $dirname;
my $_nick;
$_nick = param('nick');
$dirname ="/tmp/".$_nick;
mkdir $dirname, 0755;
