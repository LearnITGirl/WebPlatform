@MenteeApplicationStep1 = React.createClass
  getInitialState: ->
    application: @props.application
    countries: @props.countries
    timezones: @props.timezones
    step: 1

  genderOptions: ->
    [
      {name: 'Female', value: 'female'},
      {name: 'Male', value: 'male'},
      {name: 'other', value: 'other'},
    ]

  render: ->
    React.DOM.div
      className: 'fields'
      React.DOM.p
        className: 'text-center'
        "Let us know a little about yourself"
      if @state.application.errors
        React.DOM.div
          className: "alert alert-danger text-center"
          @application.errors.full_messages.join(", ")
      React.createElement(ApplicationTextField, key: 'firstName', field: 'first_name', placeholder: "First Name", application: @state.application)
      React.createElement(ApplicationTextField, key: 'lastName', field: 'last_name', placeholder: "Last Name", application: @state.application)
      React.createElement(ApplicationTextField, key: 'email', field: 'email', placeholder: "Email", application: @state.application)
      React.createElement(ApplicationRadioGroup, key: 'gender', options: @genderOptions(), field: 'gender', placeholder: "Gender", application: @state.application)
      React.createElement(ApplicationSelectField, key: 'country', options: @state.countries, field: 'country', label: "Where are you from?", placeholder: "Choose your country", application: @state.application)
      React.createElement(ApplicationSelectField, key: 'program_country', options: @state.countries, field: 'program_country', label: "Where will you be during the program?", placeholder: "Choose your country", application: @state.application)
      React.createElement(ApplicationSelectField, key: 'time_zone', options: @state.timezones, field: 'time_zone', label: "Which timezone you will be at during the program?", placeholder: "Choose your timezone", application: @state.application)
