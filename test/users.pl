#!/usr/bin/env perl
use FindBin;
use lib "$FindBin::Bin/../lib";
use Activiti::Rest;
use Data::Dumper;

binmode STDOUT,":utf8";

my $client = Activiti::Rest->new(
  url => 'http://kermit:kermit@localhost:8080/activiti-rest/service'
);

my $users = $client->users;
my @ids = map { $_->{id} } @{ $users->{data} };
for my $id(@ids){
  print Dumper($client->user(userId => $id));
  print Dumper($client->user_info(userId => $id));
}
