<% if @entry.errors.any? %>
    <ul>
        <% @entry.errors.full_message.each do |error| %>
            <li><%= error %></li>
        <% end %>
    </ul>
<% end %>

<br>
<%= form_for [@project, @entry] do |f| %>
    <%= f.label :hours %>
    <%= f.text_field :hours %>
    <br>
    <%= f.label :minutes %>
    <%= f.text_field :minutes %>
    <br>
    <%= f.label :date %>
    <%= f.text_field :date %>
    <br>
    <%= f.submit 'Save' %>
<% end %>