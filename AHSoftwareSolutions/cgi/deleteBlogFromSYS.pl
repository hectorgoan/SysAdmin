#!/usr/bin/perl
use CGI qw(:standard);

use Linux::usermod;
use File::Copy;
use DynGig::Util::Setuid;
use File::Copy::Recursive;
use File::Path;
 
DynGig::Util::Setuid->sudo( 'root' );

#Recogida de argumentos
my $_nick;
$_nick = param('nick');


my $homePath ="/home/" . $_nick . "/";
my $webPath = $homePath."/public_html/";

rmtree($webPath, 1, 1 );

mkdir $webPath;
chmod(0705, $webPath);
$user=Linux::usermod->new($_nick );
chown($user->get(uid), $user->get(gid), $webPath );

my $WebDir = "/etc/skel/public_html";

File::Copy::Recursive::dircopy $WebDir,$webPath;



