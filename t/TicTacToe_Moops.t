#!/usr/bin/perl
 
use strict;
use warnings;

use local::lib;
use Moops;
use lib "lib";  #TODO: need a better directory agnostic way



say 'start';
my $x = TicTacToe->new;
$x->move('X','9');
$x->status;
say 'end';
