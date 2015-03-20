package TicTacToe::Schema::Result::Game;

use local::lib;
use Modern::Perl;

use base 'DBIx::Class::Core';
__PACKAGE__->table("games");
__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "player1",
  { data_type => "char", is_nullable => 1, size => 100 },
  "player2",
  { data_type => "char", is_nullable => 1, size => 100 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->has_many('moves' => 'TicTacToe::Schema::Result::Move','game_id');

#define all the win conditions on a 1..9 board
my $wins = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]];

sub move {
    my $self = shift;
    my $position = shift;
    
    #see if there is already a winner
    my $status = $self->status;
    if ($status =~ /Player: [0..1] wins/) {
        return "Game is already over: $status"
    }
    
    #see if the board is filled
    if ($self->moves->count == 9) {
        return "Board is full with no winner. Cat's game.";
    }
    
    #figure out whos turn it it
    my $player;
    if ($self->search_related('moves',{ player => 0 })->count <= $self->search_related('moves',{ player => 1 })->count) {
        $player = 0;
    } else {
        $player = 1;
    }
    
    #check for valid position on the board
    if (($position < 1) || ($position > 9)) {
        return 'Invalid Move';
    }
    
    #check if the move exists
    if ($self->search_related('moves',{ position => $position })->count) {
        #move already taken
        return 'Move already taken';
    } else {
        $self->create_related('moves',{ player => $player, position => $position });
    }
    
    #return status
    return $self->status;
}

sub status {
    my $self = shift;
    
    #rough logic influenced by: http://curtisquarterly.blogspot.com/2005/04/writing-tic-tac-toe-bot-in-perl.html
    
    #check each winning possibilities for each player
    foreach my $win (@{$wins}) {
        
        foreach my $player (0..1) {

            my $found = $self->search_related('moves', {
                player => $player,
                position => { -in => $win },
            })->count;
            
            #match 3 out of 3 FTW
            if ($found == 3) {
                return "Player: $player wins";
            }
        }
        
    }
    
    return 'No winner yet';  #whos turn?
}


1;