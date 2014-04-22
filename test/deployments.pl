#!/usr/bin/env perl
use FindBin;
use lib "$FindBin::Bin/../lib";
use Activiti::Rest;
use Data::Dumper;

binmode STDOUT,":utf8";

my $client = Activiti::Rest->new(
  url => 'http://kermit:kermit@localhost:8080/activiti-rest/service'
);

my $deployments = $client->deployments;
my @ids = map { $_->{id} } @{ $deployments->{data} };
for my $id(@ids){
  print Dumper($client->deployment(deploymentId => $id));
}
