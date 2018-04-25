# NAME

Activiti::Rest::Client - Low level client for the Activiti Rest API

# AUTHORS

Nicolas Franck `<nicolas.franck at ugent.be>`

# NOTE

This is a work in progress. More documentation will be added in time

# PROJECT

see http://www.activiti.org/userguide

# SYNOPSIS

    my $client = Activiti::Rest::Client->new(
      url => 'http://kermit:kermit@localhost:8080/activiti-rest/service'
    );

    my $res = $client->process_definitions;

    die("no parsed content") unless $res->has_parsed_content;

    my $pdefs = $res->parsed_content;

    my @ids = map { $_->{id} } @{ $pdefs->{data} };
    for my $id(@ids){
      print Dumper($client->process_definition(processDefinitionId => $id)->parsed_content);
    }

# CONSTRUCTOR parameters

## url

    base url of the activiti rest api
    activiti-rest uses basic http authentication, so username and password should be included in the url

    e.g.

    http://kermit:kermit@localhost:8080/activiti-rest/service

## timeout

    timeout in seconds when connecting to the activiti rest api

    default value is 180

# METHODS

## deployments

    Retrieve list of Deployments

    parameters: see user guide (http://www.activiti.org/userguide/index.html#N13293)

    equal to rest call:

      GET repository/deployments

## deployment

    Get a deployment

    parameters:
      deploymentId

    other parameters: see user guide (http://www.activiti.org/userguide/index.html#N1332E)

    equal to rest call:

      GET repository/deployments/:deploymentId

## deployment\_resources

    List resources in a deployment

    parameters:

      deploymentId

    other parameters: see user guide (http://www.activiti.org/userguide/index.html#N133F1)

    equal to rest call:

      GET repository/deployments/:deploymentId/resources

## deployment\_resource

    Get a deployment resource

    parameters:

      deploymentId
      resourceId

    other parameters: see user guide (http://www.activiti.org/userguide/index.html#N1345B)

    equal to rest call:

      GET repository/deployments/:deploymentId/resources/:resourceId

## process\_definitions

    List of process definitions

    parameters: see user guide (http://www.activiti.org/userguide/index.html#N13520)

    equal to rest call:

      GET repository/process-definitions

## process\_definition

    Get a process definition

    parameters:

      processDefinitionId

    other parameters: see user guide (http://www.activiti.org/userguide/index.html#N13605)

    equal to rest call:

      GET repository/process-definitions/:processDefinitionId

## process\_definition\_resource\_data

    Get a process definition resource content

    parameters:

      processDefinitionId

    equal to rest call:

      GET repository/process-definitions/:processDefinitionId/resourcedata

## process\_definition\_model

    Get a process definition BPMN model

    parameters:

      processDefinitionId

    equal to rest call:

      GET repository/process-definitions/:processDefinitionId/model

## process\_definition\_identity\_links

    Get all candidate starters for a process-definition

    parameters:

      processDefinitionId

    equal to rest call:

      GET repository/process-definitions/:processDefinitionId/identitylinks

## process\_definition\_identity\_link

    Get a candidate starter from a process definition

    parameters: (see http://www.activiti.org/userguide/index.html#N138A9)

      processDefinitionId
      family
      identityId

    equal to rest call:

      GET repository/process-definitions/:processDefinitionId/identitylinks/:family/:identityId

## models

    Get a list of models

    Parameters: see user guide (http://www.activiti.org/userguide/index.html#N1390A)

    equal to rest call:

      GET repository/models

## models

    Get a model

    Parameters:

      modelId

    equal to rest call:

      GET repository/models/:modelId

## process\_instances

    List of process instances

    Parameters: see user guide (http://www.activiti.org/userguide/index.html#restProcessInstancesGet)

    equal to rest call:

      GET runtime/process-instances

## process\_instance

    Get a process instance

    Parameters:

      processInstanceId

    equal to rest call:

      GET runtime/process-instances/:processInstanceId

## query\_process\_instances

    Query process instances

    Parameters: see user guide (http://www.activiti.org/userguide/index.html#N13E2A)

    equal to rest call:

      POST runtime/process-instances

## start\_process\_instance

    Start a process instance

    Parameters: see user guide (http://www.activiti.org/userguide/index.html#N13CE6)

    equal to rest call:

      POST runtime/process-instances

## process\_instance\_identitylinks

    Get involved people for process instance

    Parameters:

      processInstanceId

    equal to rest call:

      GET runtime/process-instances/:processInstanceId/identitylinks

## process\_instance\_variables

    List of variables for a process instance

    Parameters:

      processInstanceId

    equal to rest call:

      GET runtime/process-instances/:processInstanceId/variables

## process\_instance\_variable

    Get a variable for a process instance

    Parameters:

      processInstanceId
      variableName

    equal to rest call:

      GET runtime/process-instances/:processInstanceId/variables/:variableName

## process\_instance\_diagram

    Get a diagram for a process instance

    Parameters:

      processInstanceId

    equal to rest call:

      GET runtime/process-instances/:processInstanceId/diagram

    when successfull the "content_type" of the response is "image/png" and "content" is equal to the image data

## executions

    List of executions

    Parameters: see user guide (http://www.activiti.org/userguide/index.html#restExecutionsGet)

    equal to rest call:

      GET repository/executions

## query\_executions

    Query executions

    Parameters in request body (i.e. 'content' hash)

    equal to rest call:

        POST query/executions

## signal\_execution

    send signal to execution

    equal to rest call:

        PUT runtime/executions/{executionId}

## execution

    Get an execution

    Parameters:

      executionId

    equal to rest call:

      GET repository/executions/:executionId

## execution\_activities

    Get active activities in an execution

    Parameters:

      executionId

    equal to rest call:

      GET repository/executions/:executionId/activities

## execution\_variables

    List of variables for an execution

    Parameters:

      executionId

    equal to rest call:

      GET repository/executions/:executionId/variables

## tasks

    List of tasks

    Parameters: see user guide (http://www.activiti.org/userguide/index.html#restTasksGet)

    equal to rest call:

      GET runtime/tasks

## query\_tasks

    Query for tasks

    Parameters: see user guide (http://www.activiti.org/userguide/index.html#N148B7)

    equal to rest call:

      POST query/tasks

## task

    Get a task

    Parameters:

      taskId

    equal to rest call:

      GET runtime/tasks/:taskId

## update\_task

    Update a task

    Parameters:

      taskId

    Body parameters: see user guide (http://www.activiti.org/userguide/index.html#N148FA)

    equal to rest call:

      PUT runtime/tasks/:taskId

## task\_variables

    Get all variables for a task

    Parameters:

      taskId
      scope (global|local)

    equal to rest call:

      GET runtime/tasks/:taskId/variables?scope=:scope

## task\_variable

    Get one variable for a task

    Parameters:

      taskId
      scope (global|local)

    equal to rest call:

      GET runtime/tasks/:taskId/variables/:variableName?scope=:scope

## task\_identity\_links

    Get all identity links for a task

    Parameters:

      taskId

    equal to rest call:

      GET runtime/tasks/:taskId/identitylinks

## task\_identity\_links\_users

## task\_identity\_links\_groups

    Get all identity links for a task for either groups or users

    Parameters:

      taskId

    equal to rest call:

      GET runtime/tasks/:taskId/identitylinks/(users|groups)

## task\_comments

    Get all comments on a task

    Parameters:

      taskId

    equal to rest call:

      GET runtime/tasks/:taskId/comments

## task\_comment

    Get a comments on a task

    Parameters:

      taskId
      commentId

    equal to rest call:

      GET runtime/tasks/:taskId/comments/:commentId

## task\_events

    Get all events for a task

    Parameters:

      taskId

    equal to rest call:

      GET runtime/tasks/:taskId/events

## task\_event

    Get an event for a task

    Parameters:

      taskId
      eventId

    equal to rest call:

      GET runtime/tasks/:taskId/events/:eventId

## task\_attachments

    Get all attachments on a task

    Parameters:

      taskId

    equal to rest call:

      GET runtime/tasks/:taskId/attachments

## task\_attachment

    Get an attachment on a task

    Parameters:

      taskId
      attachmentId

    equal to rest call:

      GET runtime/tasks/:taskId/comments/:attachmentId

## task\_attachment\_content

    Get the content for an attachment on a task

    Parameters:

      taskId
      attachmentId

    equal to rest call:

      GET runtime/tasks/:taskId/attachments/:attachmentId/content

## historic\_process\_instances

    List of historic process instances

    Parameters: see user guide (http://www.activiti.org/userguide/index.html#restHistoricProcessInstancesGet)

    equal to rest call:

      GET history/historic-process-instances

## query\_historic\_process\_instances

    Query for historic process instances

    Parameters: see user guide (http://www.activiti.org/userguide/index.html#N153C2)

    equal to rest call:

      POST history/historic-process-instances

## historic\_process\_instance

    Get a historic process instance

    Parameters:

      processInstanceId

    equal to rest call:

      GET history/historic-process-instances/:processInstanceId

## delete\_historic\_process\_instance

    Delete a historic process instance

    Parameters:

      processInstanceId

    equal to rest call:

      DELETE history/historic-process-instances/:processInstanceId

## historic\_process\_instance\_comments

    Get all comments on a historic process instance

    Parameters:

      processInstanceId

    equal to rest call:

      GET history/historic-process-instances/:processInstanceId/comments

## historic\_process\_instance\_comment

    Get a comment on a historic process instance

    Parameters:

      processInstanceId
      commentId

    equal to rest call:

      GET history/historic-process-instances/:processInstanceId/comments/:commentId

## historic\_task\_instances

    Get historic task instances

    Parameters: see user guide (http://www.activiti.org/userguide/index.html#restHistoricTaskInstancesGet)

    equal to rest call:

      GET history/historic-task-instances

## historic\_variable\_instances

    Get historic variable instances, either from tasks or process instances

    Parameters: see user guide (http://www.activiti.org/userguide/index.html#restHistoricVariableInstancesGet)

    equal to rest call:

      GET history/historic-variable-instances

## query\_historic\_variable\_instances

    Query historic variable instances, either from tasks or process instances

    Parameters: see user guide (http://www.activiti.org/userguide/index.html#N15B00)

    equal to rest call:

      POST query/historic-variable-instances

## historic\_task\_instance

    Get a historic task instance

    Parameters:

      taskId

    equal to rest call:

      GET history/historic-task-instances/:taskId

## historic\_task\_instance\_identity\_links

    Get the identity links of a historic task instance

    Parameters:

      taskId

    equal to rest call:

      GET history/historic-task-instances/:taskId/identitylinks

# LICENSE AND COPYRIGHT

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See [http://dev.perl.org/licenses/](http://dev.perl.org/licenses/) for more information.
