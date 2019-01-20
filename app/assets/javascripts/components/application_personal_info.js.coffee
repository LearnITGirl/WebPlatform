@ApplicationPersonalInfo = React.createClass
  genderOptions: ->
    [
      {name: 'Female', value: 'female'},
      {name: 'Male', value: 'male'},
      {name: 'other', value: 'other'},
    ]

  yesNoOptions: ->
    [
      {name: 'Yes', value: 'true'},
      {name: 'No', value: 'false'},
    ]

  render: ->
    React.DOM.div
      className: 'fields'
      React.DOM.p
        className: 'text-center'
        "Let us know a little about yourself"
      React.createElement(ApplicationTextField, key: 'firstName', field: 'first_name', placeholder: "First Name", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationTextField, key: 'lastName', field: 'last_name', placeholder: "Last Name", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationTextField, key: 'email', field: 'email', placeholder: "Email", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationRadioGroup, key: 'gender', options: @genderOptions(), field: 'gender', placeholder: "Gender", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationSelectField, key: 'country', options: @props.countries, field: 'country', label: "Where are you from?", placeholder: "Choose your country", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationSelectField, key: 'programCountry', options: @props.countries, field: 'program_country', label: "Where will you be during the program?", placeholder: "Choose your country", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationSelectField, key: 'timeZone', options: @props.timezones, field: 'time_zone', label: "Which timezone you will be at during the program?", placeholder: "Choose your timezone", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationRadioGroup, key: 'communicatingInEnglish', options: @yesNoOptions(), field: 'communicating_in_english', placeholder: "Do you feel comfortable communicating and working on the project in English?", application: @props.application, setApplicationField: @props.setApplicationField)
      if @props.application_type == 'mentee'
        React.createElement(ApplicationAgreeCheckbox, key: 'sendToMentorConfirmed', field: 'send_to_mentor_confirmed', name: 'I agree', checked: 'true', placeholder: "In case your application is successful we would like to forward the information collected in this form to your future mentor. He or she can use it to prepare for your first meeting/skype call. Please confirm that you agree to this.", application: @props.application, setApplicationField: @props.setApplicationField)
