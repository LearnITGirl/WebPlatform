programming_language_1 = ProgrammingLanguage.find_by_name("Ruby")
programming_language_2 = ProgrammingLanguage.find_by_name("C")
edition = Edition.first

MenteeApplication.create(first_name: "Jane", last_name: "Doe", email: "mentee@litg.com", gender: "female", country: "IN", program_country: "IN", time_zone: "5 - Mumbai",
                         motivation: "Motivation - Lorem ipsum dolor sit amet, malis zril accusam ex quo, efficiendi definitiones interpretaris vis te.",
                         experience: "Experience - Has an aliquip equidem.",
                         background: "Background - Est quaerendum accommodare eu, erant recusabo his id, alterum partiendo et mel.",
                         project_proposal: "Project Proposal - Lorem ipsum dolor sit amet, malis zril accusam ex quo, efficiendi definitiones interpretaris vis te.",
                         roadmap: "Roadmap - Lorem ipsum dolor sit amet, malis zril accusam ex quo, efficiendi definitiones interpretaris vis te.",
                         time_availability: 3, engagements: ["master_student", "part_time", "volunteer", "one_project"],
                         state: 1, communicating_in_english: true, operating_system: "mac_os",
                         team_work_experience: "Team Work Experience - Lorem ipsum dolor sit amet, malis zril accusam ex quo.",
                         new_learnings: "New Learnings - Lorem ipsum dolor sit amet, malis zril accusam ex quo.",
                         previous_programming_experience: true, programming_language_id: programming_language_1.id, edition_id: edition.id,
                         programming_experience_level: Hash[programming_language_1.slug, "beginner"],
                         programming_experience_detail: Hash[programming_language_1.slug, "Lorem ipsum dolor sit amet, malis zril accusam ex quo, efficiendi definitiones interpretaris vis te."]
)

MentorApplication.create(first_name: "Alice", last_name: "Doe", email: "mentor@litg.com", gender: "female", country: "IN", program_country: "IN", time_zone: "5 - Mumbai",
                         motivation: "Motive - Lorem ipsum dolor sit amet, malis zril accusam ex quo, efficiendi definitiones interpretaris vis te.",
                         mentor_experience: "Mentor Experience - Lorem ipsum dolor sit amet, malis zril accusam ex quo, efficiendi definitiones interpretaris vis te.",
                         background: "Background - Lorem ipsum dolor sit amet, malis zril accusam ex quo, efficiendi definitiones interpretaris vis te.",
                         git: true,
                         application_idea: "Application Idea - Lorem ipsum dolor sit amet, malis zril accusam ex quo, efficiendi definitiones interpretaris vis te.",
                         concept_explanation: " Concept Explanation - Lorem ipsum dolor sit amet, malis zril accusam ex quo, efficiendi definitiones interpretaris vis te.",
                         time_availability: 3,
                         engagements: ["master_student", "part_time", "volunteer", "one_project"],
                         state: 1,
                         communicating_in_english: true,
                         roadmap: "will ask the mentee, depending on mentee interest",
                         edition_id: edition.id,
                         programming_language_ids: [programming_language_1.id, programming_language_2.id],
                         programming_languages_info: Hash[programming_language_1.slug, 'i know it very well', programming_language_2.slug, 'Just learned'],
                         programming_experience_level: Hash[programming_language_1.slug, "beginner", programming_language_1.slug, "professional"],
                         programming_experience:"",
                         old_programming_languages:"",
                         like_mentoring_beginner: true,
                         gdpr_consent: true,
                         perceived_methods:["facebook", "linkedin"],
                         perceived_other:""
)