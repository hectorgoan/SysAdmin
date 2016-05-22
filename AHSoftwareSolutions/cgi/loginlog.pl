#!/usr/bin/perl -w

#use warnings;
#use strict;
use CGI qw(:standard);
use Log::Handler;
use DynGig::Util::Setuid;

DynGig::Util::Setuid->sudo( 'root' );
#Recogida de argumentos
my $_username;
$_username = param('username');
my $_ip;
$_ip = param('ip');
my $_mode;
$_mode = param('mode');

	
my $log = Log::Handler->new();

$log->add(
    file => {
        filename => "/var/log/djangoLog.log",
        maxlevel => "debug",
        minlevel => "warning",
    }
);

if($_mode eq "debug")
{
	$log->debug($_username." have logged in from $_ip");
}
if($_mode eq "warning")
{
	$log->warning($_username." HAVE TRIED TO LOG FROM $_ip");
}

