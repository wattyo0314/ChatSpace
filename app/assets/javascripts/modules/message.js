$(function(){
  function buildHTML(message){
    if ( message.image ) {
      let html =
      `
      <div class="message" data-message-id=${message.id}>
        <div class="upper-message">
          <div class="upper-message__user-name">
            ${message.user_name}
          </div>
          <div class="upper-message__date">
            ${message.created_at}
          </div>
        </div>
        <div class="lower-message>
          <p class="lower-message__content">
            ${message.content}
          </p>
          <img class="message__image" src="${message.image}">
        </div>
      </div>
       `
      return html;
    } else {
      let html =
      `
      <div class="message" data-message-id=${message.id}>  
        <div class="upper-message">
          <div class="upper-message__user-name">
            ${message.user_name}
          </div>
          <div class="upper-message__date">
            ${message.created_at}
          </div>
        </div>
          <p class="lower-message__content">
            ${message.content}
          </p>
      </div>
    `
      return html;
    };
  }

  $('.Form').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      console.log(data)
      let html = buildHTML(data);
      $('.messages').append(html);
      $('form')[0].reset();
      $('.messages').animate({ scrollTop: $('.messages')[0].scrollHeight});
      $('.Form__contents__submit').prop("disabled", false);
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
      $('.Form__contents__submit').prop("disabled", false);
    });
  })
});