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

EmailTemplate.create(
subject: "[Learn IT, Girl] Mentor application results",
recipients: 10,
body: "Dear %{first_name},\r\n\r\nIt has been great to have you applying to “Learn IT, Girl” second edition. We really liked your motivation and passion for helping a girl learn IT. However, we currently don’t have a mentee to match you with. This is not the end! We will have you on our waiting list in case we find a suitable mentee for you during the programme.\r\n\r\nMeanwhile, you can still help mentees through our <a href=\"https://www.facebook.com/groups/learnitgirl/\" target=\"_blank\">Facebook group</a>, helping answering questions they might have. \r\n\r\nWe would also love you to give us feedback on our application process. You can fill in <a target=\"_blank\"href=\"https://docs.google.com/forms/d/1jMiiq3m2KYutFB4ANTJKmOrzm8uqBeadhgQKEdB9_Co/viewform?c=0&w=1\">this survey</a> telling us what you think about our application process so we can make it better next time.\r\n\r\nKind regards,\r\n<i>The \"Learn IT, Girl!\" team</i>\r\n<a href=\"http://www.learnitgirl.com/\" target=\"_blank\">\"Learn IT, Girl\"</a> | <a href=\"https://twitter.com/learnitgirl\" target=\"_blank\">Follow us on Twitter </a>| <a href=\"https://www.facebook.com/learnitgirl/\" target=\"_blank'>Like us on Facebook </a>| <a href=\"https://learnitgirl.wordpress.com/\" target=\"_blank\">Read our blog</a>"
)


EmailTemplate.create(
  subject: "[Learn IT, Girl] Welcome as a second edition mentor!",
  recipients: 2,
  body: "Dear %{first_name},\r\n\r\nThank you for applying to “Learn IT, Girl” second edition! We are very excited to announce that you are accepted as a mentor. Congratulations! We are happy to have you with us helping us change the trend in IT.\r\n\r\nYour mentee will be %{mentee_full_name}. Her email is %{mentee_email}. She is from %{mentee_country} and she wants to work on:\r\n%{project_description}\r\n\r\nThe next step is to confirm your participation in the program and create an account by clicking here <a href=%{registration_link} target=\"_blank\">link</a>. Please have a look at the <a href=\"https://www.learnitgirl.com/mentor_dos_and_donts\" target=\"_blank\">Dos and Don’ts for mentors </a> and <a href=\"https://www.learnitgirl.com/mentee_dos_and_donts\" target=\"_blank\">scholars</a> before you contact your mentee. You should schedule a Hangout/Skype session with your mentee to work together on a final project and description. Once you have agreed on them, your mentee will be able to update them on her profile (do so during this first week as it will get blocked afterwards). You will also need to work on a roadmap for the next 12 weeks, including weekly tasks that you will add to your dashboard on the LITG website. You can check a roadmap example <a href=\"https://www.learnitgirl.com/roadmap_example\" target=\"_blank\">here</a>.\r\n\r\nYour mentee and you will be using git to communicate. If you would like to refresh your git skills, you can check <a href=\"http://www.learnitgirl.com/learning_materials/git\" target=\"_blank\">this tutorial</a>.\r\n\r\nIf you haven’t already, we invite you to join the <a href=\"https://www.facebook.com/groups/learnitgirl/\" target=\"_blank\"> LITG Facebook scholar group </a> and the <a href=\"https://www.facebook.com/groups/learnitgirl.mentors/\" target=\"_blank\"> LITG mentor group</a>. These will be great places to socialize and share experiences.\r\n\r\nWe would also love you to give us feedback on our application process. You can fill in <a target=\"_blank\"href=\"https://docs.google.com/forms/d/1jMiiq3m2KYutFB4ANTJKmOrzm8uqBeadhgQKEdB9_Co/viewform?c=0&w=1\">this survey</a> telling us what you think about our application process so we can make it better next time.\r\n\r\nWe're looking forward to hearing from you! Thank you so much for your involvement!\r\n\r\nKind regards,\r\n<i>The \"Learn IT, Girl!\" team</i>\r\n<a href=\"http://www.learnitgirl.com/\" target=\"_blank\">\"Learn IT, Girl\"</a> | <a href=\"https://twitter.com/learnitgirl\" target=\"_blank\">Follow us on Twitter </a>| <a href=\"https://www.facebook.com/learnitgirl/\" target=\"_blank'>Like us on Facebook </a>| <a href=\"https://learnitgirl.wordpress.com/\" target=\"_blank\">Read our blog</a>"
)

EmailTemplate.create(
  subject: "[Learn IT, Girl] Mentor application results",
  recipients: 11,
   body: "Dear %{first_name},\r\n\r\nIt has been great to have you applying to “Learn IT, Girl” second edition. We have had a big number of applications to evaluate and we have valued motivation, communication skills and details in the answers. Unfortunately, your application hasn’t been successful, mostly due to the shortness in the answers, so we will not be able to accept you at “Learn IT, Girl” this time. \r\n\r\nEven if you didn’t get accepted this time, we loved the fact that you applied to join us! Don’t get discouraged! We love the fact that you want to mentor other to help them learn IT. You can still help mentees through our <a href=\"https://www.facebook.com/groups/learnitgirl/\" target=\"_blank\">Facebook group </a>, helping answering questions they might have. \r\n\r\nWe would also love you to give us feedback on our application process. You can fill in <a target=\"_blank\"href=\"https://docs.google.com/forms/d/1jMiiq3m2KYutFB4ANTJKmOrzm8uqBeadhgQKEdB9_Co/viewform?c=0&w=1\">this survey</a> telling us what you think about our application process so we can make it better next time.\r\n\r\nKind regards,\r\n<i>The \"Learn IT, Girl!\" team</i>\r\n<a href=\"http://www.learnitgirl.com/\" target=\"_blank\">\"Learn IT, Girl\"</a> | <a href=\"https://twitter.com/learnitgirl\" target=\"_blank\">Follow us on Twitter </a>| <a href=\"https://www.facebook.com/learnitgirl/\" target=\"_blank'>Like us on Facebook </a>| <a href=\"https://learnitgirl.wordpress.com/\" target=\"_blank\">Read our blog</a>"
)

EmailTemplate.create(
  subject: "[Learn IT, Girl] Congratulations! Welcome as a second edition mentee. Action required",
  recipients: 0,
  body: "Dear %{first_name},\r\n\r\nThank you for applying to “Learn IT, Girl” second edition! We are very excited to announce that you are accepted as a scholar. Congratulations! We are happy to have you with us learning IT and being part of our community.\r\n\r\nYour mentor will be %{mentor_full_name}. They are from %{mentor_country} and their email is %{mentor_email}.\r\n\r\nThe next step is to confirm your participation in the program and create an account by clicking <a href=%{registration_link} target=\"_blank\">here</a> Please have a look at the <a href=\"https://www.learnitgirl.com/mentee_dos_and_donts\" target=\"_blank\">Dos and Don’ts</a> before contacting your mentor. You should schedule a Hangout/Skype session with them to work together on a final project and description. Once you have agreed on them, you will be able to update them on your profile (do so during this first week as it will get blocked afterwards). You will also need to work on a roadmap for the next 12 weeks, including weekly tasks that you will add to your dashboard on the LITG website. You can check a roadmap example <a href=%{roadmap_link} target=\"_blank\">here</a>.\r\n\r\nIf you haven’t already, we invite you to join the <a href=\"https://www.facebook.com/groups/learnitgirl/\" target=\"_blank\">LITG Facebook scholar group</a>. It will be a great place to socialize and share experiences.\r\n\r\nWe would also love you to give us feedback on our application process. You can fill in <a href=\"https://docs.google.com/forms/d/1K6i_vy_8_aC1EXL1TzprN5QGxIC52lO8BPcTiF_2hZM/viewform?usp=send_form\" target=\"_blank\">this survey</a> telling us what you think about our application process so we can make it better next time.\r\n\r\nWe're looking forward to hearing from you! Thank you so much for your involvement!\r\n\r\nKind regards,\r\n<i>The \"Learn IT, Girl!\" team</i>\r\n<a href=\"http://www.learnitgirl.com/\" target=\"_blank\">\"Learn IT, Girl\"</a> | <a href=\"https://twitter.com/learnitgirl\" target=\"_blank\">Follow us on Twitter </a>| <a href=\"https://www.facebook.com/learnitgirl/\" target=\"_blank'>Like us on Facebook </a>| <a href=\"https://learnitgirl.wordpress.com/\" target=\"_blank\">Read our blog</a>\r\n",
)

EmailTemplate.create(
  subject: "[Learn IT, Girl] Mentee application results",
  recipients: 1,
  body: "Dear %{first_name},\r\n\r\nIt has been great to have you applying to “Learn IT, Girl” second edition. We have had a big number of applications to evaluate and we have valued motivation, communication skills and details in the answers. Unfortunately, your application hasn’t been successful, mostly due to the shortness in the answers, so we will not be able to accept you at “Learn IT, Girl” this time.\r\n\r\nEven if you didn’t get accepted this time, we loved the fact that you applied to join us! Don’t get discouraged! We love the fact that you want to learn IT and work on a project. You can still join <a href=\"https://www.facebook.com/groups/learnitgirl/\" target=\"_blank\"> our Facebook group </a> and be part of our community.\r\n\r\nWe would also love you to give us feedback on our application process. You can fill in <a target=\"_blank\"href=\"https://docs.google.com/forms/d/1K6i_vy_8_aC1EXL1TzprN5QGxIC52lO8BPcTiF_2hZM/viewform?usp=send_form\">this survey</a> telling us what you think about our application process so we can make it better next time.\r\n\r\nKind regards,\r\n<i>The \"Learn IT, Girl!\" team</i>\r\n<a href=\"http://www.learnitgirl.com/\" target=\"_blank\">\"Learn IT, Girl\"</a> | <a href=\"https://twitter.com/learnitgirl\" target=\"_blank\">Follow us on Twitter </a>| <a href=\"https://www.facebook.com/learnitgirl/\" target=\"_blank'>Like us on Facebook </a>| <a href=\"https://learnitgirl.wordpress.com/\" target=\"_blank\">Read our blog</a>\r\n"
)

EmailTemplate.create(
  subject: "[Learn IT, Girl] Mentee application results",
  recipients: 12,
  body: "Dear %{first_name},\r\n\r\nIt has been great to have you applying to “Learn IT, Girl” second edition. We have had a big number of applications and we were not able to match every mentee with a mentor, so we will not be able to accept you at “Learn IT, Girl” this time. However, this is not the end! We will keep you in our waiting list in case we find a mentor for you in the next month.\r\n\r\nEven if you didn’t get accepted this time, we loved the fact that you applied to join us! Don’t get discouraged! We love the fact that you want to learn IT and work on a project. You can still join <a href=\"https://www.facebook.com/groups/learnitgirl/\" target=\"_blank\"> our Facebook group </a> and be part of our community.\r\n\r\nWe would also love you to give us feedback on our application process. You can fill in <a target=\"_blank\"href=\"https://docs.google.com/forms/d/1jMiiq3m2KYutFB4ANTJKmOrzm8uqBeadhgQKEdB9_Co/viewform?c=0&w=1\">this survey</a> telling us what you think about our application process so we can make it better next time.\r\n\r\nKind regards,\r\n<i>The \"Learn IT, Girl!\" team</i>\r\n<a href=\"http://www.learnitgirl.com/\" target=\"_blank\">\"Learn IT, Girl\"</a> | <a href=\"https://twitter.com/learnitgirl\" target=\"_blank\">Follow us on Twitter </a> | <a href=\"https://www.facebook.com/learnitgirl\" target=\"_blank\">Like us on Facebook </a> | <a href=\"https://learnitgirl.wordpress.com/\" target=\"_blank\">Read our blog</a>"
)

EmailTemplate.create(
  subject: "[Learn IT, Girl] Warning. Registration not complete. Action required",
  recipients: 13,
  body: "Dear %{first_name},\r\n\r\nThis is a friendly reminder from “Learn IT, Girl”. You have not registered into our website after being accepted into the “Learn IT, Girl” program. You can do so by clicking <a href=%{registration_link} target=\"_blank\">here</a>.\r\n\r\nWe had a very big number of applications and we could unfortunately not match all of them with a mentor. Therefore, you must register in the website by the end of this week (February 21) in order to participate in the program. Otherwise we will give this spot to another mentee.\r\n\r\nPlease let us know if you have any questions, problems or doubts. We will be happy to help!\r\n\r\nKind regards,\r\n<i>The \"Learn IT, Girl!\" team</i>\r\n<a href=\"http://www.learnitgirl.com/\" target=\"_blank\">\"Learn IT, Girl\"</a> | <a href=\"https://twitter.com/learnitgirl\" target=\"_blank\">Follow us on Twitter </a>| <a href=\"https://www.facebook.com/learnitgirl\" target=\"_blank\">Like us on Facebook </a> | <a href=\"https://learnitgirl.wordpress.com\" target=\"_blank\">Read our blog</a>"
)

EmailTemplate.create(
  subject: "[Learn IT, Girl] Warning. Registration not complete. Action required",
  recipients: 14,
  body: "Dear %{first_name},\r\n\r\nThis is a friendly reminder from “Learn IT, Girl”. You have not registered into our website after being accepted as a mentor into the “Learn IT, Girl” program. You can do so by clicking <a href=%{registration_link} target=\"_blank\">here</a>.\r\n\r\nWe need to secure the mentor spots before releasing the mentee acceptance notes, so we need you to register no later than Saturday February 13 in order for your mentee to enroll into the program.\r\n\r\nPlease let us know if you have any questions, problems or doubts. We will be happy to help!\r\n\r\nKind regards,\r\n<i>The \"Learn IT, Girl!\" team</i>\r\n<a href=\"http://www.learnitgirl.com/\" target=\"_blank\">\"Learn IT, Girl\"</a> | <a href=\"https://twitter.com/learnitgirl\" target=\"_blank\">Follow us on Twitter </a> | <a href=\"https://www.facebook.com/learnitgirl\" target=\"_blank\">Like us on Facebook </a> | <a href=\"https://learnitgirl.wordpress.com\" target=\"_blank\">Read our blog</a>"
)

EmailTemplate.create(
  subject: "[Learn IT, Girl] Reported as missing. Action required",
  recipients: 4,
  body: "Dear %{first_name} %{last_name}\r\nYour mentee has reported you as missing in “Learn IT, Girl” as she has been unable to get in touch with you. Mentors are key part of “Learn IT, Girl”, as they help make the dream of learning to code come true for their mentee. For this dream to become true, communication is essential.\r\n\r\nIf there is any problem or issue causing this, please, let us know. We will do our best to help and remove any roadblocks! In order for your status not be marked as “abandoned” you should contact your mentee and AND log into the platform in the next ten days.\r\n\r\nPlease let us know if you have any questions, problems or doubts. We will be happy to help!\r\n\r\nBest regards,\r\nThe “Learn IT, Girl” team\r\n<a href=\"http://www.learnitgirl.com\" target=\"_blank\">\"Learn IT, Girl\"</a> | <a href=\"https://twitter.com/learnitgirl\" target=\"_blank\">Follow us on Twitter </a>| <a href=\"https://www.facebook.com/learnitgirl\" target=\"_blank\">Like us on Facebook </a>| <a href=\"https://learnitgirl.wordpress.com\" target=\"_blank\">Read our blog</a>"
)

EmailTemplate.create(
  subject: "[Learn IT, Girl] Reported as missing. Action required",
  recipients: 5,
  body: "Dear %{first_name} %{last_name}\r\nYour mentor has reported you as missing in “Learn IT, Girl” as they have been unable to get in touch with you. For successfully learning a new language and receiving the “Learn IT, Girl” diploma of completion, you must work regularly together with your mentor.\r\n\r\nIf there is any problem or issue causing this, please, let us know. We will do our best to help and remove any roadblocks! In order for your project not be marked as “abandoned” you should contact your mentor AND log into the platform in the next ten days.\r\n\r\nPlease let us know if you have any questions, problems or doubts. We will be happy to help!\r\n\r\nBest regards,\r\nThe “Learn IT, Girl” team\r\n<a href=\"http://www.learnitgirl.com\" target=\"_blank\">\"Learn IT, Girl\"</a> | <a href=\"https://twitter.com/learnitgirl\" target=\"_blank\">Follow us on Twitter </a>| <a href=\"https://www.facebook.com/learnitgirl\" target=\"_blank\">Like us on Facebook </a>| <a href=\"https://learnitgirl.wordpress.com\" target=\"_blank\">Read our blog</a>"
)

EmailTemplate.create(
  subject: "[Learn IT, Girl] Midterm survey. Action required.",
  recipients: 15,
  body: "Hi %{first_name},\r\n\r\nWe hope you are great! We can’t believe that after all this hard work helping your mentee, we are already half-way through the program! \r\n\r\nIt is time for you to fill the midterm survey to let us know how the process is going for you and your mentee and any other feedback you have. You can access the survey <a href=%{midterm_evaluation_url} target=\"_blank\">here</a>.\r\n\r\nYou have until Sunday April 3 to fill it in.\r\n\r\nKind regards,\r\n<i>The \"Learn IT, Girl!\" team</i>\r\n<a href=\"http://www.learnitgirl.com/\" target=\"_blank\">\"Learn IT, Girl\"</a> | <a href=\"https://twitter.com/learnitgirl\" target=\"_blank\">Follow us on Twitter </a>| <a href=\"https://www.facebook.com/learnitgirl/\" target=\"_blank'>Like us on Facebook </a>| <a href=\"https://learnitgirl.wordpress.com/\" target=\"_blank\">Read our blog</a>"
)

EmailTemplate.create(
  subject: "[Learn IT, Girl] Midterm survey. Action required.",
  recipients: 16,
  body: "Hi %{first_name},\r\n\r\nWe hope you are great! We can’t believe that after all this hard work in your project, we are already half-way through the program! We hope you are having an amazing time and are learning a lot. \r\n\r\nIt is time for you to fill the midterm survey to let us know how the process is going for you and how you have progressed in your project. You can access the survey <a href=%{midterm_evaluation_url} target=\"_blank\">here</a>.\r\n\r\nYou have until Sunday April 3 to fill it in.\r\n\r\nKind regards,\r\n<i>The \"Learn IT, Girl!\" team</i>\r\n<a href=\"http://www.learnitgirl.com/\" target=\"_blank\">\"Learn IT, Girl\"</a> | <a href=\"https://twitter.com/learnitgirl\" target=\"_blank\">Follow us on Twitter </a>| <a href=\"https://www.facebook.com/learnitgirl/\" target=\"_blank'>Like us on Facebook </a>| <a href=\"https://learnitgirl.wordpress.com/\" target=\"_blank\">Read our blog</a>"
)

EmailTemplate.create(
  subject: "[Learn IT, Girl] Missing from website. Action required",
  recipients: 17,
  body: "Dear %{first_name},\r\n\r\nWe have recently noticed that you have not logged into the “Learn IT, Girl” platform nor committed to your GitHub repository in the last two weeks. For successfully learning a new language and receiving the “Learn IT, Girl” diploma of completion, you must work regularly.\r\n\r\nIf there is any problem or issue causing this, please, let us know. We will do our best to help and remove any roadblocks! <b>In order for your project not be marked as “abandoned” you should contact us AND log into to the platform in the next ten days.</b>\r\n\r\nPlease let us know if you have any questions, problems or doubts. We will be happy to help!\r\n\r\nBest regards,\r\n<i>The \"Learn IT, Girl!\" team</i>\r\n<a href=\"http://www.learnitgirl.com/\" target=\"_blank\">\"Learn IT, Girl\"</a> | <a href=\"https://twitter.com/learnitgirl\" target=\"_blank\">Follow us on Twitter </a> | <a href=\"https://www.facebook.com/learnitgirl\" target=\"_blank\">Like us on Facebook </a> | <a href=\"https://learnitgirl.wordpress.com\" target=\"_blank\">Read our blog</a>"
)

EmailTemplate.create(
  subject: "[Learn IT, Girl] Missing from website. Action required",
  recipients: 18,
  body: "Dear %{first_name},\r\n\r\nWe have recently noticed that you have not logged into the “Learn IT, Girl” platform in the last two weeks. Mentors are key part of “Learn IT, Girl”, as they help make the dream of learning to code come true for their mentee. For this dream to become true, communication and planning are essential.\r\n\r\nIf there is any problem or issue causing this, please, let us know. We will do our best to help and remove any roadblocks! <b>In order for your status not be marked as “abandoned” you should contact us AND log into the platform in the next ten days.</b>\r\n\r\nPlease let us know if you have any questions, problems or doubts. We will be happy to help!\r\n\r\nBest regards,\r\n<i>The \"Learn IT, Girl!\" team</i>\r\n<a href=\"http://www.learnitgirl.com/\" target=\"_blank\">\"Learn IT, Girl\"</a> | <a href=\"https://twitter.com/learnitgirl\" target=\"_blank\">Follow us on Twitter </a> | <a href=\"https://www.facebook.com/learnitgirl\" target=\"_blank\">Like us on Facebook </a> | <a href=\"https://learnitgirl.wordpress.com\" target=\"_blank\">Read our blog</a>"
)

EmailTemplate.create(
  subject: "[Learn IT, Girl] It’s the end of the program! Please fill in the final evaluation",
  recipients: 19,
   body: "Hi %{first_name},\r\n\r\nWe are very moved to see that this edition of “Learn IT, Girl” has reached its end. We have been very happy to see the great progress you have all made and the great projects you have been working on.\r\n\r\nWe hope this experience has been great for you and we wish that you will continue learning and never stop coding. Now it is time to fill in the final evaluation so we can asses your work and award diplomas. Click <a href=%{final_survey_url} target=\"_blank\">here</a> to fill it in now.\r\n\r\nWe would like to showcase some mentee stories in our blog. If you would be interested in collaborating for this, please let us know.\r\n\r\nWe would love to continue working on further editions of “Learn IT, Girl” in the future. If you would like to contribute to the program as an organizer or platform developer, please send us an email.\r\n\r\nBest regards and let’s keep coding,\r\n<i>The \"Learn IT, Girl!\" team</i>\r\n<a href=\"http://www.learnitgirl.com/\" target=\"_blank\">\"Learn IT, Girl\"</a> | <a href=\"https://twitter.com/learnitgirl\" target=\"_blank\">Follow us on Twitter </a>| <a href=\"https://www.facebook.com/learnitgirl/\" target=\"_blank'>Like us on Facebook </a>| <a href=\"https://learnitgirl.wordpress.com/\" target=\"_blank\">Read our blog</a>"
)

EmailTemplate.create(
  subject: "[Learn IT, Girl] It’s the end of the program! Please fill in the final evaluation",
  recipients: 20,
  body: "Hi %{first_name},\r\n\r\nWe are very moved to see that this edition of “Learn IT, Girl” has reached its end. We have been very happy to see the progress mentees have made with your mentorship and the wonderful projects they have worked on.\r\n\r\nWe hope this experience has been great for you and your mentee and we wish you to see you again at “Learn IT, Girl”. Now it is time to fill in the final evaluation so we can asses your mentee´s work and award diplomas to you both. Click <a href=%{final_survey_url} target=\"_blank\">here</a> to fill it in now.\r\n\r\nWe would like to showcase some mentor stories in our blog. If you would be interested in collaborating for this, please let us know.\r\n\r\nWe would love to continue working on further editions of “Learn IT, Girl” in the future. If you would like to contribute to the program as an organizer or platform developer, please send us an email.\r\n\r\nBest regards and let’s keep coding,\r\n<i>The \"Learn IT, Girl!\" team</i>\r\n<a href=\"http://www.learnitgirl.com/\" target=\"_blank\">\"Learn IT, Girl\"</a> | <a href=\"https://twitter.com/learnitgirl\" target=\"_blank\">Follow us on Twitter </a>| <a href=\"https://www.facebook.com/learnitgirl/\" target=\"_blank'>Like us on Facebook </a>| <a href=\"https://learnitgirl.wordpress.com/\" target=\"_blank\">Read our blog</a>"
)


EmailTemplate.create(
  subject: "[Learn IT, Girl!] Evaluation results",
  body: "Dear %{first_name},\r\n\r\nIt has been great to have you as part of “Learn IT, Girl”. We love people joining to learn a new programming language. However, we are sad to say after evaluating your final self­-evaluation form and your project, we cannot award you a diploma. \r\n\r\nIf you think there has been an error in the result, please contact us by replying to this email. Make sure all your code has been uploaded to your repository on time and you filled in the final self­-evaluation survey.\r\n\r\nWe hope you had a good experience with “Learn IT, Girl” and hope you continue your journey through coding.\r\n\r\nBest wishes,\r\n<i>The \"Learn IT, Girl!\" team</i>",
  recipients: 24
)

EmailTemplate.create(
  subject: "[Learn IT, Girl!] Evaluation results",
  recipients: 22,
  body: "Dear %{first_name},\r\n\r\nIt has been great to have you as part of “Learn IT, Girl”. We love people helping women learn how to code. However, we are sad to say after evaluating your final self­-evaluation form, we cannot award you a diploma.\r\n\r\nIf you think there has been an error in the result, please contact us by replying to this email. Make sure you  filled in the final self­-evaluation survey.\r\n\r\nWe hope you had a good experience with “Learn IT, Girl” and hope you continue to help women learn how to code in the future.\r\n\r\nBest wishes,\r\n<i>The \"Learn IT, Girl!\" team</i>"
)

EmailTemplate.create(
  subject: "[Learn IT, Girl!] Evaluation results congratulations!",
  recipients: 23,
  body: "Dear %{first_name},\r\n\r\nWe are happy to have had you in the program and we are very proud of how you have worked in your project. Congratulations on passing the program!\r\n\r\nWe will be issuing diplomas for each graduated mentee and mentors, through our partners, <a href=\"https://www.accredible.com/\" target=\"_blank\">Accredible</a>. Expect to receive your diploma on this email in the following weeks.\r\n\r\nWe hope you had a wonderful experience with us!\r\n\r\nBest wishes,\r\n<i>The \"Learn IT, Girl!\" team</i>"
)

EmailTemplate.create(
  subject: "[Learn IT, Girl!] Evaluation results congratulations! ",
  recipients: 21,
  body: "Dear %{first_name},\r\n\r\nWe are happy to have had you in the program and we are very proud of the effort you have made to help your mentee. Congratulations on passing the program!\r\n\r\nWe will be issuing diplomas for each graduated mentee and mentors, through our partners, <a href=\"https://www.accredible.com/\" target=\"_blank\">Accredible</a>.  Expect to receive your diploma on this email in the following weeks. \r\n\r\nWe hope you had a wonderful experience with us! \r\n\r\nBest wishes,\r\n<i>The \"Learn IT, Girl!\" team</i>"
)


ProgrammingLanguage.find_or_create_by(name: "C", slug: "c")
ProgrammingLanguage.find_or_create_by(name: "C++", slug: "c_plus_plus")
ProgrammingLanguage.find_or_create_by(name: "Java", slug: "java")
ProgrammingLanguage.find_or_create_by(name: "Python", slug: "python")
ProgrammingLanguage.find_or_create_by(name: "C#", slug: "c_sharp")
ProgrammingLanguage.find_or_create_by(name: ".NET", slug: "dot_net")
ProgrammingLanguage.find_or_create_by(name: "HTML, CSS", slug: "html_css")
ProgrammingLanguage.find_or_create_by(name: "Javascript", slug: "javascript")
ProgrammingLanguage.find_or_create_by(name: "Ruby", slug: "ruby")
ProgrammingLanguage.find_or_create_by(name: "PHP", slug: "php")

Edition.first_or_create(name: "first")
Edition.first_or_create(name: "second")
Edition.first_or_create(name: "third")

Badge.create(name: 1, image: "badges/midterm.png", thumbnail: "badges/thumbnails/midterm.png", description: "Badge awarded when mentee completed midterm survey")
Badge.create(name: 2, image: "badges/finalterm.png", thumbnail: "badges/thumbnails/finalterm.png", description: "Badge awarded when mentee completed final survey")
Badge.create(name: 3, image: "badges/organized.png", thumbnail: "badges/thumbnails/organized.png", description: "Badge awarded when mentee enters roadmap")
Badge.create(name: 5, image: "badges/energetic.png", thumbnail: "badges/thumbnails/energetic.png", description: "Badge awarded when mentee completes all tasks for 2 weeks in a row")
Badge.create(name: 6, image: "badges/timekeeper.png", thumbnail: "badges/thumbnails/timekeeper.png",description: "Badge awarded when mentee completes all tasks for the current week")
Badge.create(name: 7, image: "badges/novice.png", thumbnail: "badges/thumbnails/novice.png", description: "Badge awarded when mentee completes first task")
Badge.create(name: 8, image: "badges/ambitious.png", thumbnail: "badges/thumbnails/ambitious.png", description: "Badge awarded when mentee completes all tasks for 3 weeks in a row")
Badge.create(name: 9, image: "badges/coder.png", thumbnail: "badges/thumbnails/coder.png", description: "Badge awarded when mentee creates her first github commit")
Badge.create(name: 10, image: "badges/visionary.png", thumbnail: "badges/thumbnails/visionary.png", description: "Badge awarded when mentee has provided a creative project description that’s doable and detailed")
=end
