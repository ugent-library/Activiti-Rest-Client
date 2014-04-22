#!/usr/bin/env perl
use FindBin;
use lib "$FindBin::Bin/../lib";
use Activiti::Rest;
use Data::Dumper;

binmode STDOUT,":utf8";

my $client = Activiti::Rest->new(
  url => 'http://kermit:kermit@localhost:8080/activiti-rest/service'
);

my $pdefs = $client->process_definitions;
my @ids = map { $_->{id} } @{ $pdefs->{data} };
for my $id(@ids){
  print Dumper($client->process_definition(processDefinitionId => $id));
}
