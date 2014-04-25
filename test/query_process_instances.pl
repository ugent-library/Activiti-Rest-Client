#!/usr/bin/env perl
use FindBin;
use lib "$FindBin::Bin/../lib";
use Activiti::Rest;
use Data::Dumper;

binmode STDOUT,":utf8";

my $client = Activiti::Rest->new(
  url => 'http://rest:rest@andric.ugent.be:8888/activiti-rest/service'
);

my $res = $client->query_process_instances(
  content => {
    "processDefinitionKey" => "CustomerRequest",
    includeProcessVariables => "true",
    "variables" => [],
    processInstanceId => 418    
#    [
#      {
#          "name" => "lastname";
#          "value" => "Spillemaeckers";
#          "operation" => "equals";
#          "type" => "string"
#      }
#    ]
  }
);

die("no parsed content") unless $res->has_parsed_content;

print Dumper($res->parsed_content);
