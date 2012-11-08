package Quasar;

use strict;
use warnings;
use Data::Dumper;

{
  package Blackhole;

  sub new {
      my $class = shift;
      my $self = {};
      bless $self, $class;
      return $self;
  }

  sub AUTOLOAD {
      my $self = shift;
      return $self;
  }
}

my $blackhole = Blackhole->new();
print Dumper $blackhole->x()->y()->z();
