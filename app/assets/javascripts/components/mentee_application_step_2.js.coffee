@MenteeApplicationStep2 = React.createClass
  getInitialState: ->
    application: @props.application
    countries: @props.countries
    timezones: @props.timezones
    step: 2

  englishLevelOptions: ->
    [
     {name:'Very well', value: 'very well'},
     {name: 'Not so well', value: 'not so well'},
     {name: 'Good enough', value: 'good enough'},
     {name: 'No', value: 'no'}
    ]

  render: ->
    React.DOM.div
      className: 'fields'
      if @state.application.errors
        React.DOM.div
          className: "alert alert-danger text-center"
          @application.errors.full_messages.join(", ")
      React.createElement(ApplicationTextArea, key: 'motivation', field: 'motivation', label: "What motivated you to become a scholar?", application: @state.application)
      React.createElement(ApplicationRadioGroup, key: 'english_level', field: 'english_level', options: @englishLevelOptions(), placeholder: "Can you read and write in English?", application: @state.application)
      React.createElement(ApplicationTextArea, key: 'experience', field: 'experience', label: "Do you have any experience working as a team or collaborating with others? Tell us about it. What was the project or task? What was your role? Tell us as many things as you want.", application: @state.application)
