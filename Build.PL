use warnings;
use strict;
use Module::Build;

my $requires = {
  perl => '5.10.0',
  Carp => 0,
  'Moo' => 0,
  'URI::Escape' => 0,
  'LWP::UserAgent' => 0,
  'Data::Util' => 0,
  'Throwable::Error' => 0
};
my $recommends = {
  'Term::ReadKey' => 0
};
my $build = Module::Build->new(
  module_name => 'Activiti-Rest-Client',
  dist_author => [
    'Nicolas Franck <nicolas.franck@ugent.be>'
  ],
  dist_abstract => 'Client api for the rest api of Activiti',
  requires => $requires,
  recommends => $recommends,
  build_requires => {
    'Software::License' => 0,
    'Test::Exception' => 0,
    'Test::More' => 0,
  },
  configure_requires => { 'Module::Build' => 0.42 },
  create_license => 1,
  license => 'perl',
  dist_version_from => 'lib/Activiti/Rest/Client.pm',
  create_makefile_pl => 'traditional'
);
$build->create_build_script;
