<% if @entry.errors.any? %>
    <ul>
        <% @entry.errors.full_message.each do |error| %>
            <li><%= error %></li>
        <% end %>
    </ul>
<% end %>

<br>
<%= form_for [@project] do |f| %>
    <%= f.label :name %>
    <%= f.text_field :name %>
    <br>
    <%= f.label :description %>
    <%= f.text_field :description %>
    <br>
    <%= f.submit 'Save' %>
<% end %>