@MentorApplicationStep3 = React.createClass
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
      React.createElement(ApplicationRadioGroup, key: 'gitKnown', field: 'git', options: @yesNoOptions(), placeholder: "Are you familiar with Git and are comfortable instructing a beginner on using it with GitHub?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationRadioGroup, key: 'operatingSystem', field: 'operating_system', options: @operating_systems(), placeholder: "Which operating system do you feel comfortable working with during the program?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationCheckboxGroup, key: 'programmingLanguages', field: 'programming_languages', options: @props.programming_languages, placeholder: "What programming language(s) do you feel comfortable to teach during the mentorship program?", application: @props.application, setApplicationField: @props.setApplicationField, hint_field: 'programming_languages_info')
