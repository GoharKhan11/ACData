#!/usr/bin/perl
use LWP::UserAgent;
use LWP::Protocol::https;

$UserAgent = new LWP::UserAgent;
$Request = new HTTP::Request("get", "https://forums.ashesofcreation.com/discussion/46150/what-class-will-you-be-picking#latest");
$Response = $UserAgent->request($Request);

print $Response->(_content);
