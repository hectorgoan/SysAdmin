#!/usr/bin/perl

use warnings;
#use strict;
use CGI qw(:standard);
use Email::Send::SMTP::Gmail;

#Recogida de argumentos
my $_ip;
$_ip = param('ip');
my $_mode;
$_mode = param('mode');
my $_hash;
$_hash = param('hash');

if ($_hash ne "MEOWPasswdCoffe") 
{
	die();
}

my $_tipoAlerta;

if ($_mode eq "debug")
{
	$_tipoAlerta = "acaba de "
}
if ($_mode eq "warning")
{
	$_tipoAlerta = "HA INTENTADO "
}
	
#Notificación vía mail
#DUMMY GMAIL ACCOUNT - NOTHING IMPORTANT HERE - REPLACE IT WITH YOUR'S
my ($mail,$error)=Email::Send::SMTP::Gmail->new(-smtp=>'smtp.gmail.com', 
                                                -login=>'ahsoftsol@gmail.com', 
                                                -pass=>'USALdebian');
                                                
my $message = <<"END_MSG";
Atención,

"administrador" $_tipoAlerta iniciar sesión en el sistema AHSoftSol desde: $_ip 
En el archivo /var/log/djangoLog.log encontrará mas información acerca del suceso

Un saludo.
END_MSG

#print "session error: $error" unless ($email!=-1);
$mail->send(-to=>'ahsoftsol@gmail.com', 
			-subject=>'INICIO SESION ADMIN', 
			-body=>$message);

$mail->bye;

