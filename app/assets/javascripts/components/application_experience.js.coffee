@ApplicationExperience = React.createClass
  yesNoOptions: ->
    [
      {name: 'Yes', value: 'true'},
      {name: 'No', value: 'false'},
    ]

  render: ->
    React.DOM.div
      className: 'fields'
      React.createElement(ApplicationTextArea, key: 'motivation', field: 'motivation', label: "Why do you want to be a part of Learn IT Girl? Tell us about your motivation! (approx. 100 words)", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationTextArea, key: 'background', field: 'background', label: "We would like to get to know you better. What is your background? Tell us about your education and if you have, about your professional experience. It does not have to be related to programming. (approx. 100 words)", application: @props.application, setApplicationField: @props.setApplicationField)
      if @props.application_type == 'mentee'
        React.createElement(ApplicationTextArea, key: 'teamWorkExperience', field: 'team_work_experience', label: "Tell us about a time where you collaborated with others in a team. What was the project or task that you worked on? What was your role in the team? How was your experience? (approx. 100 words)", application: @props.application, setApplicationField: @props.setApplicationField)
      else if @props.application_type == 'mentor'
        React.createElement(ApplicationRadioGroup, key: 'previousMentorExperience', field: 'previous_mentor_experience', options: @yesNoOptions(), placeholder: "Have you ever mentored someone or taught classes? (Does not have to be in a technical field)", application: @props.application, setApplicationField: @props.setApplicationField)
      if @props.application_type == 'mentee'
        React.createElement(ApplicationTextArea, key: 'newLearnings', field: 'new_learnings', label: "Tell us about a recent time when you learnt something new. What did you learn? How did you go about it? (Does not have to be technical). What were your key takeaways from the experience?", application: @props.application, setApplicationField: @props.setApplicationField)
      if @props.application.previous_mentor_experience == 'true'
        React.createElement(ApplicationTextArea, key: 'mentoringExperience', field: 'mentor_experience', label: "What did you teach/coach/mentor and to whom? What was your own biggest learning or take away from the experience?", application: @props.application, setApplicationField: @props.setApplicationField)
      if @props.application_type == 'mentor'
        React.createElement(ApplicationRadioGroup, groupId:'like_mentor', key: 'likeMentoringBeginner', field: 'like_mentoring_beginner', options: @yesNoOptions(), placeholder: "Do you feel comfortable mentoring a person that is just starting out in tech? This could be beginner students or people wanting to change their careers from other fields to tech.", application: @props.application, setApplicationField: @props.setApplicationField)

