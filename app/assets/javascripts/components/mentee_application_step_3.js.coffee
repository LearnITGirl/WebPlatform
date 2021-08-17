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
    info = "We recomend to select Pyhton/Django as you programming language rather than Ruby/Rails, if you are going to use Windows OS"
    React.DOM.div
      className: 'hint-message'
      info

  render: ->
    React.DOM.div
      className: 'fields'
      React.createElement(ApplicationRadioGroup, key: 'programmingLanguage', field: 'programming_language', groupId: 'other', options: @props.programming_languages, placeholder: "Which programming language or framework would you like to learn during the mentorship program?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationCheckboxGroup, key: 'otherProgrammingLanguages', field: 'other_programming_languages', groupId: 'opl', options: @props.programming_languages, placeholder: "To increase your chances of being matched to a suitable mentor, please consider specifying additional choices. (upto 4 choices)", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationRadioGroup, key: 'previousProgrammingExperience', field: 'previous_programming_experience', options: @yesNoOptions(), placeholder: "Do you have previous experience in any other programming language?", application: @props.application, setApplicationField: @props.setApplicationField)
      if @props.application.previous_programming_experience == 'true'
        React.createElement(ApplicationTextArea, key: 'experience', field: 'experience', label: "Please name the language(s), your level of expertise (beginner, intermediate, professional) and tell us about the projects you have worked on.", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationRadioGroup, key: 'operatingSystem', field: 'operating_system', options: @operating_systems(), placeholder: "What operation system are you using?", application: @props.application, setApplicationField: @props.setApplicationField)
      if @props.application.programming_language == 'ruby' && @props.application.operating_system == 'windows'
        @systemWarning()
      React.createElement(ApplicationTextArea, key: 'projectProposal', field: 'project_proposal', label: "What project would you like to develop during the learning period? Please come up with your own idea", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationTextArea, key: 'roadmap', field: 'roadmap', label: "If you were to implement the application described in the previous question, what would be your roadmap?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationRadioGroup, key: 'timeAvailability', field: 'time_availability', options: @props.time_availabilities, placeholder: "How much time can you dedicate to learning through the program?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationCheckboxGroup, key: 'engagements', field: 'engagements', options: @props.engagements, placeholder: "Do you have any other engagements during the 3-month program period? Check all that apply", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationAgreeCheckbox, key: 'gdprConsent', field: 'gdpr_consent', name: 'I read and agree to the Privacy Policy', checked: false, placeholder: "Please read our GDPR compliant", link: {text: "Privacy Policy", href: "/privacy_policy"}, application: @props.application, setApplicationField: @props.setApplicationField)
