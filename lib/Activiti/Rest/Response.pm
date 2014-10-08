package Activiti::Rest::Response;
use Activiti::Sane;
use Activiti::Rest::Error;
use Moo;
use JSON qw(decode_json);
use Encode qw(decode);

has content => (
  is => 'ro',
  predicate => 'has_content'
);
has parsed_content => (
  is => 'ro',
  predicate => 'has_parsed_content'
);
has content_type => (
  is => 'ro',
  required => 1
);
has code => (
  is => 'ro',
  required => 1
);

sub from_http_response {
  my($class,$res)=@_;

  #status code indicates 'failure'
  unless($res->is_success){

    my $code = $res->code;

    #The operation failed. The operation requires an Authentication header to be set. If this was present in the request, the supplied credentials are not valid or the user is not authorized to perform this operation.
    if($code eq "401"){
      Activiti::Rest::Error::UnAuthorized->throw($res->message);
    }

    #The operation is forbidden and should not be re-attempted. This does not imply an issue with authentication not authorization, it's an operation that is not allowed. Example: deleting a task that is part of a running process is not allowed and will never be allowed, regardless of the user or process/task state.
    elsif($code eq "403"){
      Activiti::Rest::Error::Forbidden->throw($res->message);
    }

    #The operation failed.The requested resource was not found.
    elsif($code eq "404"){
      Activiti::Rest::Error::NotFound->throw($res->message);
    }

    #The operation failed. The used method is not allowed for this resource. Eg. trying to update (PUT) a deployment-resource will result in a 405 status.
    elsif($code eq "405"){
      Activiti::Rest::Error::MethodNotAllowed->throw($res->message);
    }

    #The operation failed. The operation causes an update of a resource that has been updated by another operation, which makes the update no longer valid. Can also indicate a resource that is being created in a collection where a resource with that identifier already exists.
    elsif($code eq "409"){
      Activiti::Rest::Error::Conflict->throw($res->message);
    }

    #The operation failed. The request body contains an unsupported media type. Also occurs when the request-body JSON contains an unknown attribute or value that doesn't have the right format/type to be accepted.
    elsif($code eq "415"){
      Activiti::Rest::Error::UnsupportedMediaType->throw($res->message);
    }

    #The operation failed. An unexpected exception occurred while executing the operation. The response-body contains details about the error.
    elsif($code eq "500"){
      Activiti::Rest::Error::InternalServerError->throw($res->content);
    }

    #common error
    else{
      Activiti::Rest::Error->throw($res->message);
    }

  }

  my $content_type = $res->header('Content-Type');
  my $content_length = $res->header('Content-Length');

  my(%new_args) = (
    code => $res->code,
    content_type => $content_type
  );

  if($res->code ne "204" && defined($content_type)){

    $new_args{content} = $res->content;

    if($content_type =~ /json/o){
      $new_args{parsed_content} = decode_json($res->content);
    }elsif($content_type =~ /xml/o){
      $new_args{parsed_content} = decode('UTF-8',$res->content);
    }

  }

  __PACKAGE__->new(%new_args);
}

1;
