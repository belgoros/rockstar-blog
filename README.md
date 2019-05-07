# Rock Stars Blog

Exercise blog engine Rails API providing JSON API for posts and comments in a threaded way like Slack or Reddit.
One or many comments can be added either to a Poat or to a comment.

### Excel reports

You can download an Excel file containing comments for a specified post at `/api/post/:post_id/comments` end-point.`

To populate the database, run `rails db:setup`,  see `seeds.rb` for more details.

### Tests

RSpec is used as testing framework.
Run `rspec` to run the tests.


### TODO

Fix pending request spec examples to create a comment.


