#!/usr/bin/perl

use strict;
use warnings;
use CGI qw(:standard);
use Email::Send::SMTP::Gmail;


#Front-end
print "Content-type: text/html\n\n";
print <<ENDHTML;

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Diaweb 2 | A&H</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/font-awesome.min.css" rel="stylesheet">
    <link href="/css/prettyPhoto.css" rel="stylesheet">
    <link href="/css/main.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="/images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="/images/ico/apple-touch-icon-57-precomposed.png">
</head><!--/head-->

<body data-spy="scroll" data-target="#navbar" data-offset="0">
    <header id="header" role="banner">
        <div class="container">
            <div id="navbar" class="navbar navbar-default">
                <div class="navbar-header">                    
                    <a class="navbar-brand" href="http://hectorgoan.noip.me/"></a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        
                    </ul>
                </div>
            </div>
        </div>
    </header><!--/#header-->

    <!-- Manera cutre de hacer hueco a la tarjeta-->

    <p></p>
    </br>
    </br>
    <p></p>
    </br>
    <div class="gap"></div>

    <section id="about-us">
        <div class="container">
            <div class="box">
                <div class="center">
                    <h2>¡Hecho!</h2>
                    <p class="lead">Tu mensaje ha sido enviado<br>Muchas gracias por contactarnos</p>
                </div>
                <div class="gap"></div>            
            </div><!--/.box-->
        </div><!--/.container-->
    </section><!--/#about-us-->
    
    <footer id="footer">
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    &copy; 2016 A&H Software Solutions. All Rights Reserved.
                </div>
            </div>
        </div>
    </footer><!--/#footer-->

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.isotope.min.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <script src="js/main.js"></script>
</body>
</html>

ENDHTML


#Back-end
my $nombre;
$nombre = param('minombre');
my $email; 
$email = param('miemail');
my $texto;
$texto = param('mitexto');

my ($mail,$error)=Email::Send::SMTP::Gmail->new(-smtp=>'smtp.gmail.com', 
                                                -login=>'ahsoftsol@gmail.com', 
                                                -pass=>'USALdebian');

#print "session error: $error" unless ($email!=-1);

$mail->send(-to=>'ahsoftsol@gmail.com', 
			-subject=>$nombre.' quiere contactar contigo', 
			-body=>$nombre.' cuyo email es '.$email.' te ha dejado el mensaje: '.$texto);

$mail->bye;


#QUERY_STRING="m=2&n=4" ./mult.cgi


