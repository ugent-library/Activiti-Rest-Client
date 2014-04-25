package Activiti::Rest::Error;
use Activiti::Sane;
use Moo;
extends 'Throwable::Error';

#see: http://www.activiti.org/userguide/#N12F88 for status codes

package Activiti::Rest::Error::UnAuthorized;
use Activiti::Sane;
use Moo;
extends 'Activiti::Rest::Error';

package Activiti::Rest::Error::Forbidden;
use Activiti::Sane;
use Moo;
extends 'Activiti::Rest::Error';


package Activiti::Rest::Error::NotFound;
use Activiti::Sane;
use Moo;
extends 'Activiti::Rest::Error';

package Activiti::Rest::Error::MethodNotAllowed;
use Activiti::Sane;
use Moo;
extends 'Activiti::Rest::Error';

package Activiti::Rest::Error::Conflict;
use Activiti::Sane;
use Moo;
extends 'Activiti::Rest::Error';

package Activiti::Rest::Error::UnsupportedMediaType;
use Activiti::Sane;
use Moo;
extends 'Activiti::Rest::Error';

package Activiti::Rest::Error::InternalServerError;
use Activiti::Sane;
use Moo;
extends 'Activiti::Rest::Error';

1;
