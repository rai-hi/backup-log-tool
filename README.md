# Database backup logging tool

## Running the two scripts described in the brief
You can run the task using `ruby main.rb` in the project folder. This will read the file at `spec/support/files/backup_log.txt`, output the failed deletions to `output.txt` (in the project folder), parse from the same `output.txt` and print out the number of successful vs unsuccessful deletions in the console.

## Running the test suite
You can run the test suite with `rspec` from within the project folder.

This includes a test for each of the two tasks, located in:
- `spec/lib/task/backup_deleter_spec.rb`
- `spec/lib/task/failed_backup_deletion_reporter_spec.rb`

## Code coverage
After running rspec, the coverage report will be visible at `coverage/index.html`.

## Assumptions
Some assumptions were made over the course of developing this solution. They are listed below:

### Deletion log file format
The deletion log was described as having the following format:

```
ID    Created at    Status Code ErrorDescription
a680  2019-07-10 00:08:02 +0000  Removed 200
a181  2019-07-10 00:08:02 +0000  Error  500 "{error: 'invalid ID' }"
```

Since the intended spacing isn't obvious, I've assumed it to look like this:

```
ID  Created at  Status Code   ErrorDescription
a680  2019-07-10 00:08:02 +0000  Removed 200
a181  2019-07-10 00:08:02 +0000  Error 500  "{error: 'invalid ID' }"
```

i.e. one space between words in the same heading, and two spaces for delimiting. I've also assumed 'Removed 200' and 'Error 500' are status codes, and not a 'status' and a 'code'.

### Log writer appends if file already exists
The log file writer will only add headings to an empty or non-existent file, and for any existing files with content, it will simply append the lines.

Therefore, if running on the same data multiple times, the log will contain duplicate lines. I didn't have time to add more complex handling around this, so I left it for now.

## Original brief
```
Write a script that will parse a file with following file structure (2 spaces row delimiter):

ID  Created at  Status  Size  Database
a810  2019-07-10 00:08:02 +0000  Completed 2019-07-10 00:18:53 +0000  482.43MB  DATABASE
a179  2019-07-09 00:06:19 +0000  Completed 2019-07-09 00:23:42 +0000  480.99MB  DATABASE
a278  2019-07-08 00:06:19 +0000  Completed 2019-07-08 00:16:04 +0000  479.59MB  DATABASE
a827  2019-07-07 00:08:02 +0000  Completed 2019-07-07 00:18:43 +0000  481.75MB  DATABASE

You have to extract IDs of backups that were created more than 30 days ago. 

Next you have to send the IDs (one by one) to the API endpoint `PUT https://example.com/remove-backup?backup_id=#{ID}`.
Correct API response status is 200, if it returns something else you also have to store the response body in the file with following format:

ID    Created at    Status Code ErrorDescription
a680  2019-07-10 00:08:02 +0000  Removed 200
a181  2019-07-10 00:08:02 +0000  Error  500 "{error: 'invalid ID' }"

Also write a script that will parse the events log text file and return the number of successful and failed backups deletions based on date range arguments provided.

Please include specs and provide an object oriented structure for the code.
```
