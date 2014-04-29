package Activiti::Rest;
use Activiti::Sane;
use Carp qw(confess);
use Moo;
use Data::Util qw(:check :validate);
use JSON qw(decode_json encode_json);
use URI::Escape qw(uri_escape);
use Activiti::Rest::Response;

our $VERSION = "0.1";

#see: http://www.activiti.org/userguide

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
    path => "/repository/deployments",
    params => \%args,
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub deployment {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/repository/deployments/".uri_escape($args{deploymentId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub deployment_resources {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/repository/deployments/".uri_escape($args{deploymentId})."/resources",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub deployment_resource {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/repository/deployments/".uri_escape($args{deploymentId})."/resources/".uri_escape($args{resourceId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub process_definitions {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/repository/process-definitions",
    params => \%args,
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub process_definition {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/repository/process-definitions/".uri_escape($args{processDefinitionId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}

sub process_definition_resource_data {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/repository/process-definitions/".uri_escape($args{processDefinitionId})."/resourcedata",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}

sub process_definition_model {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/repository/process-definitions/".uri_escape($args{processDefinitionId})."/model",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub process_definition_identity_links {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/repository/process-definitions/".uri_escape($args{processDefinitionId})."/identitylinks",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub process_definition_identity_link {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/repository/process-definitions/".uri_escape($args{processDefinitionId})."/identitylinks/".uri_escape($args{family})."/".uri_escape($args{identityId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub models {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/repository/models",
    params => \%args,
    method => "GET"
  );  
  Activiti::Rest::Response->from_http_response($res);
}
sub model {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/repository/models/".uri_escape($args{modelId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub process_instances {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/process-instances",
    params => \%args,
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub process_instance {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/process-instances/".uri_escape($args{processInstanceId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub query_process_instances {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/query/process-instances",
    params => {},
    method => "POST",
    headers => {
      'Content-Type' => "application/json",
      Content => encode_json($args{content})
    }
  );
  Activiti::Rest::Response->from_http_response($res);
}

sub start_process_instance {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/process-instances",
    params => {},
    method => "POST",
    headers => {
      'Content-Type' => "application/json",
      Content => encode_json($args{content})
    }
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub process_instance_identitylinks {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/process-instances/".uri_escape($args{processInstanceId})."/identitylinks",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub process_instance_variables {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/process-instances/".uri_escape($args{processInstanceId})."/variables",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub process_instance_variable {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/process-instances/".uri_escape($args{processInstanceId})."/variables/".uri_escape($args{variableName}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub executions {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/executions",
    params => \%args,
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub execution {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/executions/".uri_escape($args{executionId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub execution_activities {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/executions/".uri_escape($args{executionId})."/activities",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub execution_variables {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/executions/".uri_escape($args{executionId})."/variables",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub tasks {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/tasks",
    params => \%args,
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub query_tasks {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/query/tasks",
    params => {},
    method => "POST",
    headers => {
      'Content-Type' => "application/json",
      Content => encode_json($args{content})
    }
  );
  Activiti::Rest::Response->from_http_response($res);
}

sub task {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/tasks/".uri_escape($args{taskId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub update_task {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/tasks/".uri_escape($args{taskId}),
    params => {},
    method => "PUT",
    headers => {
      'Content-Type' => "application/json",
      Content => encode_json($args{content})
    }
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub task_variables {
  my($self,%args)=@_;
  my $taskId = delete $args{taskId};
  my $res = $self->ua->request(
    path => "/runtime/tasks/".uri_escape($taskId)."/variables",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}

sub task_identity_links {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/tasks/".uri_escape($args{taskId})."/identitylinks",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub task_identity_links_users {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/tasks/".uri_escape($args{taskId})."/identitylinks/users",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub task_identity_links_groups {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/tasks/".uri_escape($args{taskId})."/identitylinks/groups",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub task_identity_link {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/tasks/".uri_escape($args{taskId})."/identitylinks/".uri_escape($args{family})."/".uri_escape($args{identityId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub task_comments {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/tasks/".uri_escape($args{taskId})."/comments",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub task_comment {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/tasks/".uri_escape($args{taskId})."/comments/".uri_escape($args{commentId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub task_events {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/tasks/".uri_escape($args{taskId})."/events",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub task_event {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/tasks/".uri_escape($args{taskId})."/events/".uri_escape($args{eventId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub task_attachments {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/tasks/".uri_escape($args{taskId})."/attachments",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub task_attachment {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/tasks/".uri_escape($args{taskId})."/attachments/".uri_escape($args{attachmentId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub task_attachment_content {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/runtime/tasks/".uri_escape($args{taskId})."/attachments/".uri_escape($args{attachmentId})."/content",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub historic_process_instances {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/history/historic-process-instances",
    params => \%args,
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub historic_process_instance {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/history/historic-process-instances/".uri_escape($args{processInstanceId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub historic_process_instance_comments {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/history/historic-process-instances/".uri_escape($args{processInstanceId})."/comments",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub historic_process_instance_comment {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/history/historic-process-instances/".uri_escape($args{processInstanceId})."/comments/".uri_escape($args{commentId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub historic_task_instances {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/history/historic-task-instances",
    params => \%args,
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub historic_task_instance {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/history/historic-task-instances/".uri_escape($args{taskInstanceId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub historic_task_instance_identity_links {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/history/historic-task-instances/".uri_escape($args{taskInstanceId})."/identitylinks",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub historic_activity_instances {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/history/historic-activity-instances",
    params => \%args,
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub historic_activity_instance {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/history/historic-activity-instances/".uri_escape($args{activityInstanceId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub users {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/identity/users",
    params => \%args,
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub user {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/identity/users/".uri_escape($args{userId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub user_info {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/identity/users/".uri_escape($args{userId})."/info",
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}

sub groups {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/identity/groups",
    params => \%args,
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}
sub group {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/identity/groups/".uri_escape($args{groupId}),
    params => {},
    method => "GET"
  );
  Activiti::Rest::Response->from_http_response($res);
}

#forms
sub form {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/form/form-data",
    params => \%args,
    method => "GET"
  );  
  Activiti::Rest::Response->from_http_response($res);
}
sub update_form {
  my($self,%args)=@_;
  my $res = $self->ua->request(
    path => "/form/form-data",
    params => \%args,
    method => "POST",
    headers => {
      'Content-Type' => "application/json",
      Content => encode_json($args{content})
    }
  );
  Activiti::Rest::Response->from_http_response($res);
}

1;
