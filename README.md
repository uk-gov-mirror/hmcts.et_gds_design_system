# ET GDS Design System
This gem integrates the govuk-frontend npm modules into a rails
application that is using webpacker.

## Usage

The example application in test/dummy provides many examples
on how to use this gem.  It is named the 'Kitchen Sink' as it has everything
but the kitchen sink !

Please view the source code in there for more examples, but here
is one for a form component

```ruby
<%= form_for @kitchen_sink, builder: EtGdsDesignSystem.form_builder_class do |f| %>
  <h2>Text Field</h2>
  <div>
    <%= f.govuk_text_field :text_field_value, label: { text: 'Text field value label' }, hint_text: 'Hint text' %>
  </div>


<% end %>
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'et_gds_design_system', git: 'git@github.com:hmcts/et_gds_design_system.git', tag: 'v0.1.0'
```

And then execute:
```bash
$ bundle exec rails g et_gds_design_system:install
```

You might want to review what it has done - which will work if you
have an application pack in app/javascript/packs/application.js

Also, you may want to consider changing 'extract_css' to true in
your config/webpacker.yml so that your css works when
using browsers without javascript.

## Contributing

Whilst this gem is wrapping the work done by others in the [gov-uk-frontend](https://www.npmjs.com/package/govuk-frontend) npm
module, it is important to always think that it may not always
use that, so wrap things accordingly.

Also, the gem may choose to extend functionality provided by govuk-frontend or event 
modify functionality, so do not expect the user of this gem to know
anything about govuk-frontend.

When documenting, you can refer to govuk-frontend for various items but
because this gem can override things, be careful not to send the
user on a wild goose chase when linking to this documentation if the gem
has extended or modified functionality.

For detailed documentation, see [docs/development.md](docs/development.md)

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
