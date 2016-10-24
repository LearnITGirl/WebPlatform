@MenteeApplicationStep3 = React.createClass
  yesNoOptions: ->
    [
      {name: 'Yes', value: 'true'},
      {name: 'No', value: 'false'},
    ]

  operating_systems: ->
    [
      {name: 'Windows', value: 'windows'},
      {name: 'Mac OS', value: 'mac_os'},
      {name: 'Linux', value: 'linux'},
    ]

  systemWarning: ->
    info = "You better use Linux/Ubuntu if you want to learn Ruby/Rails. If you want to use Window, please think about learning Python/Django"
    React.DOM.div
      className: 'lol'
      info

  render: ->
    React.DOM.div
      className: 'fields'
      if @props.application.errors
        React.DOM.div
          className: "alert alert-danger text-center"
          @application.errors.full_messages.join(", ")
      React.createElement(ApplicationRadioGroup, key: 'programming_language', field: 'programming_language', options: @props.programming_languages, placeholder: "Which programming language or framework would you like to learn during the mentorship program?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationRadioGroup, go: @go, key: 'previous_programming_experience', field: 'previous_programming_experience', options: @yesNoOptions(), placeholder: "Do you have previous experience in any other programming language?", application: @props.application, setApplicationField: @props.setApplicationField)
      if @props.application.previous_programming_experience == 'true'
        React.createElement(ApplicationTextArea, key: 'experience', field: 'experience', label: "Please name the language(s), your level of expertise (beginner, intermediate, professional) and tell us about the projects you have worked on.", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationRadioGroup, key: 'operating_system', field: 'operating_system', options: @operating_systems(), placeholder: "What operation system are you using?", application: @props.application, setApplicationField: @props.setApplicationField)
      if @props.application.programming_language == 'ruby' && @props.application.operating_system == 'windows'
        @systemWarning()
      React.createElement(ApplicationTextArea, key: 'project_proposal', field: 'project_proposal', label: "Which project would you like to develop during the learning period?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationTextArea, key: 'roadmap', field: 'roadmap', label: "If you were to implement the application described in the previous question, what would be your roadmap?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationRadioGroup, key: 'time_availability', field: 'time_availability', options: @props.time_availabilities, placeholder: "How much time can you dedicate to learning through the program?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationCheckboxGroup, key: 'engagements', field: 'engagements', options: @props.engagements, placeholder: "Do you have any other engagements during the 3-month program period? Check all that apply", application: @props.application, setApplicationField: @props.setApplicationField)
