#!/usr/bin/env perl
use FindBin;
use lib "$FindBin::Bin/../lib";
use Activiti::Rest;
use Data::Dumper;

binmode STDOUT,":utf8";

my $client = Activiti::Rest->new(
  url => 'http://kermit:kermit@localhost:8080/activiti-rest/service'
);

my $form = $client->form(processDefinitionId => "vacationRequest:1:33");
print Dumper($form);
