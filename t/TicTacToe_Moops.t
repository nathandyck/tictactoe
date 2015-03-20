#!/usr/bin/perl
 
use strict;
use warnings;

use local::lib;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Moops;



say 'start';
my $x = TicTacToe->new;
$x->move('X','9');
$x->status;
say 'end';
