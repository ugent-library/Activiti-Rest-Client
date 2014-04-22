package Activiti::Rest::UserAgent;
use Activiti::Sane;
use Data::Util qw(:validate :check);
use Moo::Role;

has url => (
  is => 'ro',
  isa => sub { $_[0] =~ /^https?:\/\//o or die("url must be a valid web url\n"); },
  required => 1
);

#usage: request($params,$method)
requires qw(request);

1;
