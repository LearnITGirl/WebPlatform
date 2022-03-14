@MentorApplicationStep4 = React.createClass
  render: ->
    React.DOM.div
      className: 'fields'
      React.createElement(ApplicationTextArea, key: 'suggestion', field: 'application_idea', label: "Which idea/application would you suggest for a complete beginner to work on during 12 weeks (part-time)?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationTextArea, key: 'roadmap', field: 'roadmap', label: "Imagine you have been accepted to the program. Please describe how a typical week as a mentee at Learn IT, Girl! would look like for you.", application: @props.application, setApplicationField: @props.setApplicationField)