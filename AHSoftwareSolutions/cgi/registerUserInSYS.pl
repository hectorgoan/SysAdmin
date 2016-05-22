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
my $_email;
$_email = param('email');
my $_password;
$_password = param('password');
my $_nombre;
$_nombre = param('nombre');
my $_direccion;
$_direccion = param('direccion');
my $_rol;
$_rol = param('rol');

my $homePath ="/home/" . $_nick . "/";
mkdir $homePath;
chmod(0751, $homePath);
chmod(0755, "/home/");

#Creacción de la cuenta del usuario (comprobación del rol para decidir grupo)
if ($_rol eq "Profesor")
{
	Linux::usermod->add($_nick, $_password, '', 1001, '', $homePath, "/bin/bash");
}else{
	Linux::usermod->add($_nick, $_password, '', 1002, '', $homePath, "/bin/bash");
}
	#Asignación del /home y rellenado del mismo
my $user;
$user=Linux::usermod->new($_nick );
chown($user->get(uid), $user->get(gid), $homePath );
copy("/etc/skel/condiciones.txt", $homePath . "condiciones.txt");

my $mailPath = $homePath."/mail/";
my $webPath = $homePath."/public_html/";

mkdir $mailPath;
mkdir $webPath;

chmod(0700, $mailPath);
chmod(0705, $webPath);

chown($user->get(uid), $user->get(gid), $mailPath );
chown($user->get(uid), $user->get(gid), $webPath );

my $WebDir = "/etc/skel/public_html";

File::Copy::Recursive::dircopy $WebDir,$webPath;

#80mb in kb = 81920kb
`setquota -u $_nick 0 81920 0 0 -a $homePath`;

