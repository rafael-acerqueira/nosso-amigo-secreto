$(document).on 'turbolinks:load', ->
  $('#member_email, #member_name').keypress (e) ->
    if e.which == 13 && valid_email($( "#member_email" ).val()) && $( "#member_name" ).val() != ""
      $('.new_member').submit()

  $('#member_email, #member_name').bind 'blur', ->
    if valid_email($( "#member_email" ).val()) && $( "#member_name" ).val() != ""
      $('.new_member').submit()

  $('.new_member').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'POST'
        dataType: 'json',
        data: $(".new_member").serialize()
        success: (data, text, jqXHR) ->
          insert_member(data['id'], data['name'],  data['email'])
          $('#member_name, #member_email').val("")
          $('#member_name').focus()
          Materialize.toast('Membro adicionado', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problema na hora de incluir membro', 4000, 'red')
    return false

  $('.member_list').on 'blur', '.update_member_fields', ->
    if valid_email($( "#update_member_email" ).val()) && $( "#update_member_name" ).val() != ""
      current_form_id = $(this).context.form.id
      current_form = $("#" + current_form_id)

      $.ajax current_form.attr("action"),
          type: 'PUT'
          dataType: 'json',
          data: current_form.serialize()
          success: (data, text, jqXHR) ->
            Materialize.toast('Membro atualizado', 4000, 'green')
          error: (jqXHR, textStatus, errorThrown) ->
            Materialize.toast('Problema na atualização do Membro', 4000, 'red')
      return false

  $('body').on 'click', 'a.remove_member', (e) ->
    $('#remove_member_modal').modal('open')
    $('.remove_member_form').attr('action', 'members/' + e.currentTarget.id)
    $('#member_remove_id').val(e.currentTarget.id)
    return false

  $('.remove_member_form').on 'submit', (e) ->
    $.ajax "/members/" + $('#member_remove_id').val(),
        type: 'DELETE'
        dataType: 'json',
        data: {}
        success: (data, text, jqXHR) ->
          Materialize.toast('Membro removido', 4000, 'green')
          $('#member_' + $('#member_remove_id').val()).remove()
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problema na remoção de membro', 4000, 'red')
    $('#remove_member_modal').modal('close')
    return false

valid_email = (email) ->
  /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(email)

insert_member = (id, name, email) ->
  $('.member_list').append(
    '<div class="member" id="member_' + id + '">' +
      '<div class="row">' +
        '<form class="update_member" id="edit_member_'+id+'" action="/members/'+id+'" accept-charset="UTF-8" method="post">' +
          '<div class="col s12 m5 input-field">' +
            '<input name="member[name]" type="text" class="validate update_member_fields" id="update_member_name" value="' + name + '">' +
            '<label for="name" class="active">Nome</label>' +
          '</div>' +
          '<div class="col s12 m5 input-field">' +
            '<input name= "member[email]" type="email" class="validate update_member_fields" id="update_member_email" value="' + email + '">' +
            '<label for="email" class="active" data-error="Formato incorreto">Email</label>' +
          '</div>' +
        '<form>' +
        '<div class="col s3 offset-s3 m1 input-field">' +
          '<i class="material-icons icon">visibility</i>' +
        '</div>' +
        '<div class="col s3 m1 input-field">' +
          '<a href="#" class="remove_member" id="' + id + '">' +
            '<i class="material-icons icon">delete</i>' +
          '</a>' +
        '</div>' +
      '</div>' +
    '</div>')
