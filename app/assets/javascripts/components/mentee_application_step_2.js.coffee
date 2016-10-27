@MenteeApplicationStep2 = React.createClass
  render: ->
    React.DOM.div
      className: 'fields'
      React.createElement(ApplicationTextArea, key: 'motivation', field: 'motivation', label: "Why do you want to be a part of Learn IT Girl? Tell us about your motivation! (app. 100 words)", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationTextArea, key: 'background', field: 'background', label: "What is your background? Tell us about your education and - if you have - about your professional experience. It does not have to be related to programing. (app. 100 words)", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationTextArea, key: 'teamWorkExperience', field: 'team_work_experience', label: "Tell us about a time where you collaborated with others in a team. What was the project or task that you worked on? What was your role in the team? How was your experience? (app. 100 words)", application: @props.application, setApplicationField: @props.setApplicationField)
