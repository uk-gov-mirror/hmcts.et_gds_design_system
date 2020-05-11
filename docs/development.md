# Development Guidelines

## Form Elements

### Interface To Rails

The form builder is to provide a standard interface to rails which is similar
to standard rails form elements, but prefixed with govuk_

For example, a text field is rendered like this

```ruby
<%= form_for @kitchen_sink, builder: EtGdsDesignSystem.form_builder_class do |f| %>
  <h2>Text Field</h2>
  <div>
    <%= f.govuk_text_field :text_field_value, label: { text: 'Text field value label' }, hint_text: 'Hint text' %>
  </div>


<% end %>
```

This differs from a normal rails form element in the following ways

1. We specify a builder in the form_for tag
2. Instead of just f.text_field, we use f.govuk_text_field
3. The govuk_text_field has the ability to add a label and hint_text

## Template Elements

This gem can provide the application with a layout that a typical govuk
application would be happy with.  However, instead of providing lots of 
customisation options with things like content_for calls all over the place,
it is preferred that the layout is built from many helpers which
this gem will provide, again, all prefixed with govuk_

This enables developers to just as easily provide their own
layouts with their code injected in just the right places.

Examples of helpers might be

```ruby
<%= govuk_skip_to_main_content %>
<%= govuk_cookie_message %>
<%= govuk_header do %>
  <div>My Custom Header Stuff</div>
<% end %>
<%= govuk_footer do %>
  <div>My custom footer stuff</div>
<% end %>

```

Basic customisations of these helpers can be done using
standard ruby arguments and blocks, but if there are
too many things to customize, maybe think about breaking it
down differently.

The idea here is that the application's views should
be about the application, not about how govuk wants it
to look.  Any govuk helpers will be clear by the govuk_ prefix

## Assets

All assets related to the govuk look and feel should be provided
by this gem, we should not expect the main application to 
have to locate these and install them locally.

## Testing

This gem will have its own test suite to make sure that
when it is integrated into a rails application, it is very
likely to just work.

This test suite will use govuk capybara selectors and site prism pages defined by
another gem called [et_test_helpers](https://github.com/hmcts/et_test_helpers)

Please refer to this gem for instructions on how to use it, but
a similar principle applies to the application helpers in that 
things will be prefixed with govuk_ and we do not expect the application's
test suite (or in this case - our test suite) to have knowledge of
how a govuk gds component should be tested.

## Local Development

Whilst of course, the TDD approach is preferred, if you need to have
a look at what the components look like, this gem provides
access to the 'dummy application' - so just do the normal :-

```bash
bundle exec rails s
```

and visit http://localhost:3000

and you will see the 'Kitchen Sink' application.

Note that there are links at the bottom of the page to toggle 
fake errors and to add hints so that you can see those too for the form
elements.
