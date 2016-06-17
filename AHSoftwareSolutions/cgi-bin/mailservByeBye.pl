#!/usr/bin/perl

use strict;
use warnings;
use CGI qw(:standard);
use Email::Send::SMTP::Gmail;

my $nombre; 
$nombre = param('nombre');
my $email; 
$email = param('email');
my $nick;
$nick = param('nick');
my $_hash;
$_hash = param('hash');
#DUMMY GMAIL ACCOUNT - NOTHING IMPORTANT HERE - REPLACE IT WITH YOUR'S
if ($_hash ne "PasswdMEOWbarf") 
{
	die();
}
my ($mail,$error)=Email::Send::SMTP::Gmail->new(-smtp=>'smtp.gmail.com', 
                                                -login=>'ahsoftsol@gmail.com', 
                                                -pass=>'USALdebian');
my $message = <<"END_MSG";
Adios $nombre

En cualquier momento puedes volver a registrarte en DiaWeb 2.0, eres bienvenido!

 
Un saludo.
END_MSG

#print "session error: $error" unless ($email!=-1);

$mail->send(-to=>$email, 
			-subject=>'Hasta luego!', 
			-body=>$message);

$mail->bye;


#QUERY_STRING="m=2&n=4" ./mult.cgi


