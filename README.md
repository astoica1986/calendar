# README
## Initial description
A group event will be created by an user. The group event should run for a whole number of days e.g.. 30 or 60. There should be attributes to set and update the start, end or duration of the event (and calculate the other value). The event also has a name, description (which supports formatting) and location. The event should be draft or published. To publish all of the fields are required, it can be saved with only a subset of fields before it’s published. When the event is deleted/remove it should be kept in the database and marked as such.
## Additional notes

At the moment this app only contains the CRUD for a group_event resource.  
If an event is a draft (published!=true) only a name is required.
If a start or end date is provided validation will be performed as well.  
If an event is published all fields are validated.

You can update any 2 attributes from start/end date and duration and the third one will be calculated.  
However you are not allowed to update all 3 at the same time: a validation error will be raised.

Usage
***
bundle install
rails db:setup
rspec
rails s

Use curl, an api client or the browser to perform CRUD operations on the group event url  
localhost/group_events  

***

