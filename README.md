# plaintext to iCloud Notes.app importer

There's no supported way to import notes into OS X or iOS's Notes.app programs.

As a result, this script uses browser automation to do the job by interacting
only with the Notes webapp on iCloud.com

## Prerequisites

* Have `chromedriver` installed and on your path
* Run `bundle install` to make sure the dependencies work
* Make sure Energy Saver is configured to not sleep the machine, since this is
incredibly slow

## Running the script

The three parameters (in order) are `username`, `password`, and a directory containing
all of your notes in ".txt" files.

```
bundle exec script/create_notes_in_icloud.rb "foo@me.com" "myPassword" "/Users/foo/my/notes"
```


