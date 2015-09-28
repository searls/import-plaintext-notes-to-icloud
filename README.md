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

## Troubleshooting

The script will fail if a push notification comes in while you're on the other site (for example a reminders.app or calendar.app notification along the top of the window), because it will block the new note button. If this is a hangup for you, you can figure out how to search for the Close link and click it before each iteration.
