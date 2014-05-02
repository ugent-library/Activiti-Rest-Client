#!/usr/bin/env perl
use FindBin;
use lib "$FindBin::Bin/../lib";
use Activiti::Rest;
use Data::Dumper;

binmode STDOUT,":utf8";

my $client = Activiti::Rest->new(
  url => 'http://rest:rest@andric.ugent.be:8888/activiti-rest/service'
);

my $res = $client->delete_historic_process_instance(processInstanceId => 418);

print Dumper($res->parsed_content);
