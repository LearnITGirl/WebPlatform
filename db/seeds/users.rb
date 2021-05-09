User.create(email: "test@test.com", role: 1, first_name: "Test", password: "password", password_confirmation: "password")
User.create(email: "mentee@test.com", role: 2, first_name: "Mentee", password: "password", password_confirmation: "password", is_missing: false)
User.create(email: "mentor@test.com", role: 3, first_name: "Mentor", password: "password", password_confirmation: "password")
Project.create(title: "Project 01", language: "ruby", description: "Project 01 description", github_link: "www.github.com/litg/project01", mentor_id: 3, mentee_id: 2)