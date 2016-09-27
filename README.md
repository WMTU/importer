importer
========
App for Uploading and Applying Metadata to Audio Files in Preparation for
Importing Into WideOrbit

#### Features
* Bulk upload and modification
* Media conversion
* Move completed files to WideOrbit server
* Read and write Scott Studios wave format

#### Dependencies
* **ffmpeg** - Needed for media file manipulation
* **openjdk** _Dev Only_ - Needed to run a test LDAP server


## App Details

### Code Structure
Application independent code should be stored inside the `lib/modules` directory. This will help to
keep app code and library code organized and separate. All code inside `lib/modules` has been added
to the Rails auto-loading system so it is still accessible from the app by just using the proper
namespace.

### App Services
If controllers start to contain too much code some of that logic inside the controller should be
moved out to a service. The idea behind the service structure is to contain a single class that
performs a single action. This not only helps to reduce bloat in controllers, but also helps
testing efforts because each service does one thing only. For an example of this structure
take a peek at [app/services/users/authenticate.rb](app/services/users/authenticate.rb) and
[app/controllers/sessions.rb](app/controllers/sessions.rb) specifically the `create` action.

### Authentication
Auth is done via LDAP. User accounts are automatically created with properties received from the LDAP
server. To setup a test LDAP server you will need to have the `openjdk` installed. After that is
installed just run `rake ldap:start` and an LDAP server will be started on port 3897 which should
be configured in the application's config file. You can then use the user name `aa729` and password
`smada` to login to the application.

### Scott Format Details
Right now the `Scot` module defines the structures of the Scott Studios format using the Record class
from the BinData gem; once an instance of RiffChunk is fully populated, a Scott Studios WAVE file
can be written using the write(file) method inherited from BinData::Record.
