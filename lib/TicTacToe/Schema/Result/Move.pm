package TicTacToe::Schema::Result::Move;

use local::lib;
use Modern::Perl;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("moves");
__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "game_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "player",
  { data_type => "int", is_nullable => 0 },
  "position",
  { data_type => "int", is_nullable => 0 },
  "timestamp",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->belongs_to('game' => 'TicTacToe::Schema::Result::Game', 'game_id');

1;