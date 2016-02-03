# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#
=begin
edition = Edition.create(start_date: DateTime.new(2016, 2, 15), end_date: DateTime.new(2016, 5, 8), name: "second")
Week.create(start: DateTime.new(2016, 2, 15), end: DateTime.new(2016, 2, 21), number: 1, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 2, 22), end: DateTime.new(2016, 2, 28), number: 2, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 2, 29), end: DateTime.new(2016, 3, 6), number: 3, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 3, 7), end: DateTime.new(2016, 3, 13), number: 4, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 3, 14), end: DateTime.new(2016, 3, 20), number: 5, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 3, 21), end: DateTime.new(2016, 3, 27), number: 6, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 3, 28), end: DateTime.new(2016, 4, 3), number: 7, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 4, 4), end: DateTime.new(2016, 4, 10), number: 8, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 4, 11), end: DateTime.new(2016, 4, 17), number: 9, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 2, 18), end: DateTime.new(2016, 4, 24), number: 10, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 4, 25), end: DateTime.new(2016, 5, 1), number: 11, edition_id: edition.id)
Week.create(start: DateTime.new(2016, 5, 2), end: DateTime.new(2016, 5, 8), number: 12, edition_id: edition.id)
=end

EmailTemplate.create(
subject: "[Learn IT, Girl] Mentor application results",
recipients: 10,
body: "Dear %{first_name},\r\n\r\nIt has been great to have you applying to “Learn IT, Girl” second edition. We really liked your motivation and passion for helping a girl learn IT. However, we currently don’t have a mentee to match you with. This is not the end! We will have you on our waiting list in case we find a suitable mentee for you during the programme.\r\n\r\nMeanwhile, you can still help mentees through our <a href=\"https://www.facebook.com/groups/learnitgirl/\" target=\"_blank\">Facebook group</a>, helping answering questions they might have. \r\n\r\nWe would also love you to give us feedback on our application process. You can fill in <a target=\"_blank\"href=\"https://docs.google.com/forms/d/1jMiiq3m2KYutFB4ANTJKmOrzm8uqBeadhgQKEdB9_Co/viewform?c=0&w=1\">this survey</a> telling us what you think about our application process so we can make it better next time.\r\n\r\nKind regards,\r\n<i>The \"Learn IT, Girl!\" team</i>\r\n<a href=\"http://www.learnitgirl.com/\" target=\"_blank\">\"Learn IT, Girl\"</a> | <a href=\"https://twitter.com/learnitgirl\" target=\"_blank\">Follow us on Twitter </a>| <a href=\"https://www.facebook.com/learnitgirl/\" target=\"_blank'>Like us on Facebook </a>| <a href=\"https://learnitgirl.wordpress.com/\" target=\"_blank\">Read our blog</a>"
)
