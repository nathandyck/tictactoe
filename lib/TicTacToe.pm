#!/usr/bin/perl
 
use strict;
use warnings;

use local::lib;
use Moops;

my $board = "123456789";
my @wins = qw/ 123 456 789 147 258 369 159 357 /;





class TicTacToe {
    has id => (is => "ro", isa => Int);
    has player1 => (is => "ro", isa => Str);
    has player2 => (is => "ro", isa => Str);
   
    #new will have to create a row in the db
    
    method new_game (Str $player1, Str $player2) {
        say 'Starting new game: $player1 vs $player2';
        #write to db
        #set id
    }
    
    method move (Str $token, Int $move) {
        # check move
        
        #save db
        
        #return status
        
    }
    
    method status () {
        say 'status is good';
    }
}

#class Moves {
#    has id
#    has game_id
#    has position
#    has timestamp => (
#        is => 'rwp',
#        isa => InstanceOf['Datetime']
#    )
#}


#class TicTacToe :ro {
#
#   
#   has player1    => (isa => Str);
#   has player2    => (isa => Str);
#   
#   has last_login  => (
#      is      => 'rwp',
#      isa     => InstanceOf['DateTime'],
#      handles => { 'date_of_last_login' => 'date' },
#   );
#   
#   method login ( Str $pw ) {
#      return 0 if $pw ne $self->password;
#      $self->_set_last_login( DateTime->now );
#      return 1;
#   }
#}














#logic grabbed from here: http://curtisquarterly.blogspot.com/2005/04/writing-tic-tac-toe-bot-in-perl.html 
sub move { # Returns 0 for invalid, 1 for valid, 2 for winning move
 my $piece = shift; # X or O
 my $move  = shift; # 1 through 9
 return 0 if $piece !~ /^[XO]$/ or $move !~ /^[1-9]$/;
 return 0 unless $board =~ s/$move/$piece/;
 for (0..7) {
  return 2 if $wins[$_] =~ s/$move/$piece/ && $wins[$_] eq $piece x 3;
 }
 return 1;
}