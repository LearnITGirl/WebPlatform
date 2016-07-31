@MenteeApplicationStep1 = React.createClass
  getInitialState: ->
    application: @props.application
    countries: @props.countries
    timezones: @props.timezones
    step: @props.step

  fieldValueChanged: (e) ->
    @setState description: e.target.value
    if @state.product.description != @state.description
      @setState showDescriptionButtons: true
    else
      @setState showDescriptionButtons: false

  nextStep: ->
    step = @state.step + 1
    @setState step: step

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
      React.createElement(MenteeApplicationInputField, key: 'firstName', field: 'first_name', placeholder: "First Name", application: @state.application)
      React.createElement(MenteeApplicationInputField, key: 'lastName', field: 'last_name', placeholder: "Last Name", application: @state.application)
      React.createElement(MenteeApplicationInputField, key: 'email', field: 'email', placeholder: "Email", application: @state.application)
      React.createElement(MenteeApplicationRadioGroup, key: 'gender', options: ['Female', 'Male', 'Other'], field: 'gender', placeholder: "Gender", application: @state.application)
      React.createElement(MenteeApplicationSelectField, key: 'country', options: @state.countries, field: 'country', label: "Where are you from?", placeholder: "Choose your country", application: @state.application)
      React.createElement(MenteeApplicationSelectField, key: 'program_country', options: @state.countries, field: 'program_country', label: "Where will you be during the program?", placeholder: "Choose your country", application: @state.application)
      React.createElement(MenteeApplicationSelectField, key: 'time_zone', options: @state.timezones, field: 'time_zone', label: "Which timezone you will be at during the program?", placeholder: "Choose your timezone", application: @state.application)
      React.DOM.div
        className: "form-group buttons text-center"
        React.DOM.button
          className: "btn btn-pink"
          onClick: @nextStep
          "Next step"
        React.DOM.p null
          "Step 1/4"
