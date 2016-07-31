@MenteeApplicationStep3 = React.createClass
  getInitialState: ->
    application: @props.application
    programming_languages: @props.programming_languages
    step: 3

  programmingLevelOptions: ->
    [
      {name: "I'm just learning to code", value: 'begginer'},
      {name: "I can code in at least one programming language but I'm not very confident in my skills", value: 'medium'},
      {name: "I'm very confident about coding in at least one programming language", value: 'advanced'}
    ]

  render: ->
    React.DOM.div
      className: 'fields'
      if @state.application.errors
        React.DOM.div
          className: "alert alert-danger text-center"
          @application.errors.full_messages.join(", ")
      React.createElement(ApplicationRadioGroup, key: 'programming_level', field: 'english_level', options: @programmingLevelOptions(), placeholder: "Are you an absolute beginner in coding or are you a professional looking into learning a new language?", application: @state.application)
      React.createElement(ApplicationTextArea, key: 'background', field: 'background', label: "What is your background? Tell us about your education and professional experience if you have it", application: @state.application)
      React.createElement(ApplicationRadioGroup, key: 'programming_language', field: 'programming_language', options: @state.programming_languages, placeholder: "Which programming language or framework would you like to learn during the mentorship program?", application: @state.application)
      React.createElement(ApplicationTextArea, key: 'project_proposal', field: 'project_proposal', label: "Which project would you like to develop during the learning period?", application: @state.application)
      React.createElement(ApplicationTextArea, key: 'roadmap', field: 'roadmap', label: "If you were to implement the application described in the previous question, what would be your roadmap?", application: @state.application)
