Evaluation.find_or_create_by(score: 50, mentor_application_id: 1, mentee_application_id: nil, user_id: 1)
Evaluation.find_or_create_by(score: 50, mentor_application_id: nil, mentee_application_id: 1, user_id: 1)
MenteeApplication.find_by(email: "mentee@litg.com").update(state: 4, evaluator_id: 1)
MentorApplication.find_by(email: "mentor@litg.com").update(state: 4, evaluator_id: 1)
