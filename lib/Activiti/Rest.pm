package Activiti::Rest;
use Activiti::Sane;
use Carp qw(confess);
use Moo;
use Data::Util qw(:check :validate);
use JSON qw(decode_json);
use URI::Escape qw(uri_escape);

our $VERSION = "0.1";

has url => (
  is => 'ro',
  isa => sub { $_[0] =~ /^https?:\/\//o or die("url must be a valid web url\n"); },
  required => 1
);
has ua => (
  is => 'ro',
  lazy => 1,
  builder => '_build_ua'
);
sub _build_ua {
  require Activiti::Rest::UserAgent::LWP;
  Activiti::Rest::UserAgent::LWP->new(url => $_[0]->url());  
}
sub deployments {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/deployments",
    params => \%args,
    method => "GET"
  );
  json_decode($res->content);
}
sub deployment {
  my($self,$id)=@_;
  my $res = $self->ua->request(
    path => "/deployments/".uri_escape($id),
    params => {},
    method => "GET"
  );
  json_decode($res->content);
}


1;
